package com.whoiszxl.controller.api;


import cn.dev33.satoken.annotation.SaCheckLogin;
import com.whoiszxl.bean.ResponseResult;
import com.whoiszxl.cqrs.response.IndexBannerResponse;
import com.whoiszxl.dozer.DozerUtils;
import com.whoiszxl.service.BannerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 轮播表 前端控制器
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@RestController
@RequestMapping("/api/banner")
@Api(tags = "C端:轮播图相关接口")
public class BannerApiController {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private DozerUtils dozerUtils;

    @SaCheckLogin
    @PostMapping("/app/index")
    @ApiOperation(value = "获取app主页Banner数据", notes = "获取app主页Banner数据", response = IndexBannerResponse.class)
    public ResponseResult<IndexBannerResponse> appIndex() {
        IndexBannerResponse indexBannerResponse = bannerService.getIndexBanner();
        return ResponseResult.buildSuccess(indexBannerResponse);
    }


}

