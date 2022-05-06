package com.whoiszxl.service;

import com.whoiszxl.cqrs.command.MemberLoginCommand;
import com.whoiszxl.cqrs.command.UpdateMemberCommand;
import com.whoiszxl.cqrs.response.MemberResponse;
import com.whoiszxl.dto.FollowerDTO;
import com.whoiszxl.dto.MemberDTO;
import com.whoiszxl.entity.Member;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 会员表 服务类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
public interface MemberService extends IService<Member> {

    /**
     * 查询当前登录用户的用户信息
     * @return
     */
    MemberResponse memberInfo();

    /**
     * 更新当前登录用户的详细信息
     * @param updateMemberCommand
     */
    void updateMemberInfo(UpdateMemberCommand updateMemberCommand);

    /**
     * 会员登录
     * @param loginCommand
     * @return
     */
    String login(MemberLoginCommand loginCommand);

    /**
     * 会员注册
     * @param loginCommand
     */
    void register(MemberLoginCommand loginCommand);

    /**
     * 禁用用户
     * @param memberId
     */
    void ban(Long memberId);


    /**
     * 通过用户id列表批量获取用户信息
     * @param memberIdList
     * @return
     */
    List<MemberDTO> findMemberInfoByIds(List<Long> memberIdList);

    /**
     * 查询粉丝列表
     * @return
     */
    List<FollowerDTO> getFollowerList();

}
