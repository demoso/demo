package mblog.modules.column.dao;

import mblog.modules.column.entity.ColumnlistAttr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ColumnlistAttrDao extends JpaRepository<ColumnlistAttr, Integer>, CrudRepository<ColumnlistAttr,Integer> {
    public List<ColumnlistAttr> findByColumnidOrderByHotAsc(int columnid);

    public void deleteByColumnid(int columnid);
}
