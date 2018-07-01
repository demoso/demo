package mblog.modules.column.dao;
import mblog.modules.column.entity.Columnlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import java.util.List;
public interface ColumnlistDao extends JpaRepository<Columnlist, Integer>, CrudRepository<Columnlist,Integer> {
    public List<Columnlist> findByIdxstatusOrderByHot(int idx);
}
