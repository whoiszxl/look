package com.whoiszxl.service;

import com.whoiszxl.cqrs.response.IndexBannerResponse;
import com.whoiszxl.entity.Banner;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 轮播表 服务类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
public interface BannerService extends IService<Banner> {

    /**
     * 获取app首页banner与nav
     * @return
     */
    IndexBannerResponse getIndexBanner();

}
