package mblog.modules.column.service;

import mblog.modules.column.dao.ColumnlistDao;
import mblog.modules.column.entity.Columnlist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ColumnService {
    @Autowired
    private ColumnlistDao columnlistDao;

    public List<Columnlist> findByIdxstatusOrderByHot() {
        return columnlistDao.findByIdxstatusOrderByHot(1);
    }

    /*我的专栏*/
    public List<Columnlist> findByAuthorId(long authorId) {
        return columnlistDao.findByAuthorId(authorId);
    }


    @Transactional
    public void post(Columnlist columnlist){
        columnlistDao.save(columnlist);
    }

    @Transactional
    public void delete(int id, long authorId) {
        Columnlist columnlist = columnlistDao.findOne(id);
        if (columnlist != null) {
            // 判断文章是否属于当前登录用户
            Assert.isTrue(columnlist.getAuthorId() == authorId, "认证失败");
            columnlistDao.delete(id);
        }
    }



}
