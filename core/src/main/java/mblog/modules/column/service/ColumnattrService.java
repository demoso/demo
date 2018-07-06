package mblog.modules.column.service;

import mblog.modules.column.dao.ColumnlistAttrDao;
import mblog.modules.column.entity.ColumnlistAttr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ColumnattrService {
    @Autowired
    private ColumnlistAttrDao columnlistAttrDao;

    public List<ColumnlistAttr> findByColumnidOrderByHotAsc(int columnid) {
        return columnlistAttrDao.findByColumnidOrderByHotAsc(columnid);
    }

    @Transactional
    public void post(ColumnlistAttr columnlistAttr) {
        columnlistAttrDao.save(columnlistAttr);
    }

    @Transactional
    public void deleteByColumnid(int columnid) {

        columnlistAttrDao.deleteByColumnid(columnid);

    }


}
