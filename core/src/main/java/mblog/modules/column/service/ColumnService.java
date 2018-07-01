package mblog.modules.column.service;

import mblog.modules.column.entity.Columnlist;
import mblog.modules.column.dao.ColumnlistDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ColumnService {
    @Autowired
    private ColumnlistDao columnlistDao;

    public List<Columnlist> findAll(){
        return columnlistDao.findByIdxstatusOrderByHot(1);

    }

    @Transactional
    @CacheEvict(allEntries = true)
    public void post(Columnlist columnlist){
        columnlistDao.save(columnlist);
    }



}
