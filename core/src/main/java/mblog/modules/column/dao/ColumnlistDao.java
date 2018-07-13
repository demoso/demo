package mblog.modules.column.dao;

import mblog.modules.column.entity.Columnlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
public interface ColumnlistDao extends JpaRepository<Columnlist, Integer>, CrudRepository<Columnlist,Integer> {
    public List<Columnlist> findByIdxstatusOrderByHot(int idx);

    public List<Columnlist> findByAuthorId(long authorId);

    @Modifying
    @Transactional
    @Query("update Columnlist set colname = :colname ,comment=:comment,logo=:logo,classify=:classify where id = :id")
    void updateColumnlist(@Param("colname") String colname, @Param("comment") String comment, @Param("logo") String logo, @Param("classify") String classify, @Param("id") long id);

}
