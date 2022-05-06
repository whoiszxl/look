package com.whoiszxl.controller.api;


import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.stp.StpUtil;
import com.whoiszxl.bean.ResponseResult;
import com.whoiszxl.cqrs.command.MemberLoginCommand;
import com.whoiszxl.cqrs.command.UpdateMemberCommand;
import com.whoiszxl.cqrs.response.MemberResponse;
import com.whoiszxl.service.MemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 会员表 前端控制器
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@RestController
@RequestMapping("/api/member")
@Api(tags = "C端:用户相关接口")
public class MemberApiController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/detail")
    @ApiOperation(value = "获取当前登录用户的详细信息", notes = "获取当前登录用户的详细信息", response = MemberResponse.class)
    public ResponseResult<MemberResponse> memberInfo() {
        MemberResponse memberResponse = memberService.memberInfo();
        return ResponseResult.buildSuccess(memberResponse);
    }

    @PutMapping("/update")
    @ApiOperation(value = "更新当前登录用户的详细信息", notes = "更新当前登录用户的详细信息", response = Boolean.class)
    public ResponseResult<Boolean> updateMemberInfo(@RequestBody UpdateMemberCommand updateMemberCommand) {
        memberService.updateMemberInfo(updateMemberCommand);
        return ResponseResult.buildSuccess();
    }

    @PostMapping("/login")
    @ApiOperation(value = "账号密码登录", notes = "账号密码登录", response = ResponseResult.class)
    public ResponseResult<String> login(@RequestBody MemberLoginCommand loginCommand) {
        String token = memberService.login(loginCommand);
        return ResponseResult.buildSuccess("登录成功", token);
    }

    @PostMapping("/phone/register")
    @ApiOperation(value = "手机号注册", notes = "手机号注册", response = ResponseResult.class)
    public ResponseResult<String> register(@RequestBody MemberLoginCommand loginCommand) {
        memberService.register(loginCommand);
        return ResponseResult.buildSuccess();
    }

    @SaCheckLogin
    @GetMapping("/logout")
    @ApiOperation(value = "登出", notes = "登出", response = ResponseResult.class)
    public ResponseResult<String> logout() {
        StpUtil.logout();
        return ResponseResult.buildSuccess();
    }
}

