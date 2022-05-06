package com.whoiszxl.client;

import com.whoiszxl.dto.FollowerDTO;
import com.whoiszxl.dto.MemberDTO;
import com.whoiszxl.feign.MemberApiClient;
import com.whoiszxl.service.MemberService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * TODO
 *
 * @author zhouxiaolong
 * @date 2022/5/6
 */
@RestController
public class MemberApiClientImpl implements MemberApiClient {

    @Autowired
    private MemberService memberService;

    @Override
    public List<FollowerDTO> memberFollowerList() {
        return memberService.getFollowerList();
    }

    @Override
    public List<MemberDTO> findMemberInfoByIds(List<Long> memberIdList) {
        return memberService.findMemberInfoByIds(memberIdList);
    }
}
