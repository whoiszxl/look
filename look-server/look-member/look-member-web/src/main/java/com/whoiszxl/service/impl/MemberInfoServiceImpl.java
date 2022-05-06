package com.whoiszxl.service.impl;

import com.whoiszxl.entity.MemberInfo;
import com.whoiszxl.mapper.MemberInfoMapper;
import com.whoiszxl.service.MemberInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 会员详情表 服务实现类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Service
public class MemberInfoServiceImpl extends ServiceImpl<MemberInfoMapper, MemberInfo> implements MemberInfoService {

}
