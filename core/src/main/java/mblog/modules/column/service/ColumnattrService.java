package mblog.modules.column.service;

import mblog.modules.column.dao.ColumnlistAttrDao;
import mblog.modules.column.dao.ColumnlistDao;
import mblog.modules.column.entity.Columnlist;
import mblog.modules.column.entity.ColumnlistAttr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ColumnattrService {
    @Autowired
    private ColumnlistAttrDao columnlistAttrDao;
    @Autowired
    private ColumnlistDao columnlistDao;

    public List<ColumnlistAttr> findByColumnidOrderByHotAsc(int columnid) {
        return columnlistAttrDao.findByColumnidOrderByHotAsc(columnid);
    }

    @Transactional
    public void post(ColumnlistAttr columnlistAttr) {
        columnlistAttrDao.save(columnlistAttr);
    }

    @Transactional
    public void deleteByColumnid(int columnid, long authorId) {
        Columnlist columnlist = columnlistDao.findOne(columnid);
        if (columnlist != null) {
            // 判断文章是否属于当前登录用户
            Assert.isTrue(columnlist.getAuthorId() == authorId, "认证失败");
            columnlistAttrDao.deleteByColumnid(columnid);
        }
    }

    @Transactional
    public void deleteByColumnidAndUrl(int columnid, String url) {

        columnlistAttrDao.deleteByColumnidAndUrl(columnid, url);
        System.out.println("deleteByColumnidAndUrl");

    }


}
