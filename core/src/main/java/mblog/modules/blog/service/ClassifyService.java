/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 Demoso. All Rights Reserved
|   http://www.demoso.net
|
+---------------------------------------------------------------------------
*/
package mblog.modules.blog.service;

import mblog.modules.blog.entity.Classify;

import java.util.List;

/**
 * 栏目管理
 *
 * @author langhsu
 */
public interface ClassifyService {
    List<Classify> findByAuthorIdOrderByCreatedDesc(long authorId);

    Classify getById(int id);

    void delete(int id);

    void save(Classify classify);
}
