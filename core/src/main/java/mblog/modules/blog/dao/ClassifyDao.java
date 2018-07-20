package mblog.modules.blog.dao;

import mblog.modules.blog.entity.Classify;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ClassifyDao extends JpaRepository<Classify, Integer> {

    List<Classify> findByAuthorIdOrderByCreatedDesc(long authorId);
}
