package mblog.modules.blog.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

/**
 * 分类创建信息
 *
 * @author
 */
@Entity
@Table(name = "mto_classify")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Classify {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    /**
     * 分类名字
     */
    @Column(name = "classname", length = 128)
    private String classname;


    @Column(name = "authorid")
    private long authorId;


    @Column(name = "created")
    private Date created;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public long getAuthorId() {
        return authorId;
    }

    public void setAuthorId(long authorId) {
        this.authorId = authorId;
    }


    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

}
