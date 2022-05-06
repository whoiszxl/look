package com.whoiszxl.service.impl;

import com.whoiszxl.entity.Tag;
import com.whoiszxl.mapper.TagMapper;
import com.whoiszxl.service.TagService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 标签表 服务实现类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Service
public class TagServiceImpl extends ServiceImpl<TagMapper, Tag> implements TagService {

}
