/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 mtons. All Rights Reserved
|   http://www.mtons.com
|
+---------------------------------------------------------------------------
*/
package mblog.modules.blog.service.impl;

import mblog.modules.blog.dao.ClassifyDao;
import mblog.modules.blog.entity.Classify;
import mblog.modules.blog.service.ClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author langhsu
 */
@Service
@Transactional(readOnly = true)
public class ClassifyServiceImpl implements ClassifyService {
    @Autowired
    private ClassifyDao classifyDao;

    @Override
    public List<Classify> findByAuthorIdOrderByCreatedDesc(long authorId) {
        List<Classify> list = classifyDao.findByAuthorIdOrderByCreatedDesc(authorId);
        return list;
    }

    @Override
    public Classify getById(int id) {
        return classifyDao.findOne(id);
    }

    @Override
    @Transactional
    public void delete(int id) {
        classifyDao.delete(id);
    }

}
