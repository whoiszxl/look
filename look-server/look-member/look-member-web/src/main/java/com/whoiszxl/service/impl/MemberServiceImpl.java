package com.whoiszxl.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.whoiszxl.cqrs.command.MemberLoginCommand;
import com.whoiszxl.cqrs.command.UpdateMemberCommand;
import com.whoiszxl.cqrs.response.MemberResponse;
import com.whoiszxl.dozer.DozerUtils;
import com.whoiszxl.dto.FollowerDTO;
import com.whoiszxl.dto.MemberDTO;
import com.whoiszxl.entity.Member;
import com.whoiszxl.entity.MemberFollower;
import com.whoiszxl.entity.MemberInfo;
import com.whoiszxl.enums.StatusEnum;
import com.whoiszxl.mapper.MemberMapper;
import com.whoiszxl.service.MemberFollowerService;
import com.whoiszxl.service.MemberInfoService;
import com.whoiszxl.service.MemberService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.whoiszxl.utils.AssertUtils;
import com.whoiszxl.utils.AuthUtils;
import com.whoiszxl.utils.IdWorker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 会员表 服务实现类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Service
public class MemberServiceImpl extends ServiceImpl<MemberMapper, Member> implements MemberService {

    @Autowired
    private IdWorker idWorker;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private DozerUtils dozerUtils;

    @Autowired
    private MemberInfoService memberInfoService;

    @Autowired
    private MemberFollowerService memberFollowerService;

    @Override
    public MemberResponse memberInfo() {
        Long memberId = AuthUtils.getMemberId();
        AssertUtils.isTrue(Objects.nonNull(memberId), "未登录");

        Member member = this.getById(memberId);
        MemberInfo memberInfo = memberInfoService.getOne(Wrappers.<MemberInfo>lambdaQuery().eq(MemberInfo::getMemberId, memberId));

        MemberResponse memberResponse = dozerUtils.map(member, MemberResponse.class);
        dozerUtils.map(memberInfo, memberResponse);
        return memberResponse;
    }

    @Override
    public void updateMemberInfo(UpdateMemberCommand updateMemberCommand) {
        Long memberId = AuthUtils.getMemberId();

        //校验用户是否存在
        Member member = this.getById(memberId);
        AssertUtils.isTrue(Objects.nonNull(member), "用户不存在");

        //如果修改用户名，校验用户名是否已经存在了
        Member existMember = this.getOne(Wrappers.<Member>lambdaQuery().eq(Member::getUsername, updateMemberCommand.getUsername()));
        AssertUtils.isTrue(Objects.isNull(existMember), "用户名已存在");

        Member updateMember = dozerUtils.map(updateMemberCommand, Member.class);
        MemberInfo updateMemberInfo = dozerUtils.map(updateMemberCommand, MemberInfo.class);

        updateMember.setId(memberId);
        updateMemberInfo.setMemberId(memberId);

        this.updateById(updateMember);
        memberInfoService.update(updateMemberInfo, Wrappers.<MemberInfo>lambdaQuery().eq(MemberInfo::getMemberId, memberId));
    }

    @Override
    public String login(MemberLoginCommand loginCommand) {
        //1. 校验账号密码是否匹配
        Member member = this.getOne(Wrappers.<Member>lambdaQuery().eq(Member::getUsername, loginCommand.getUsername()));
        AssertUtils.isTrue(Objects.nonNull(member), "用户不存在");
        AssertUtils.isTrue(passwordEncoder.matches(loginCommand.getPassword(), member.getPassword()), "账号或密码错误");

        //2. 登录
        AuthUtils.login(member.getId());

        //3. 更新最后的登录时间
        //member.updateLastLoginTime();

        //4. 发布登录成功的领域事件，处理后续的活跃度更新，登录时间更新等操作
        //memberDomainEventPublisher.publishMemberLoginSuccessEvent(new MemberLoginSuccessEvent(member.getId()));

        return AuthUtils.getToken();
    }

    @Override
    public void register(MemberLoginCommand loginCommand) {
        Member member = this.getOne(Wrappers.<Member>lambdaQuery().eq(Member::getUsername, loginCommand.getUsername()));
        AssertUtils.isTrue(Objects.isNull(member), "用户已存在");

        String password = passwordEncoder.encode(loginCommand.getPassword());

        Member registerMember = new Member();
        registerMember.setId(idWorker.nextId());
        registerMember.setUsername(loginCommand.getUsername());
        registerMember.setPassword(password);
        registerMember.setPhone(loginCommand.getUsername());
        this.save(registerMember);

        Long memberId = registerMember.getId();
        MemberInfo memberInfo = new MemberInfo();
        memberInfo.setMemberId(memberId);
        memberInfoService.save(memberInfo);
    }

    @Override
    public void ban(Long memberId) {
        Member member = this.getById(memberId);
        AssertUtils.isTrue(Objects.nonNull(member), "用户不存在");
        member.setStatus(StatusEnum.CLOSE.getCode());
        this.updateById(member);
    }

    @Override
    public List<MemberDTO> findMemberInfoByIds(List<Long> memberIdList) {
        List<Member> memberPOList = this.list(Wrappers.<Member>lambdaQuery().in(Member::getId, memberIdList));
        List<MemberDTO> memberDTOList = dozerUtils.mapList(memberPOList, MemberDTO.class);
        return memberDTOList;
    }

    @Override
    public List<FollowerDTO> getFollowerList() {
        Long memberId = AuthUtils.getMemberId();
        List<MemberFollower> memberFollowerPOList = memberFollowerService.list(Wrappers.<MemberFollower>lambdaQuery().eq(MemberFollower::getMemberId, memberId));
        List<FollowerDTO> followerDTOList = dozerUtils.mapList(memberFollowerPOList, FollowerDTO.class);
        return followerDTOList;
    }
}
