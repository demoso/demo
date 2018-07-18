package mblog.modules.code.dao;

import mblog.modules.code.entity.CodePO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CodeDao extends JpaRepository<CodePO, Long> {
    Page<CodePO> findAllByOrderByIdDesc(Pageable pageable);

    Page<CodePO> findAllByAuthorIdOrderByIdDesc(Pageable pageable, long authorId);
}
