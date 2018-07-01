package mblog.modules.column.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

/**
 * 模块/专栏信息
 * @author langhsu
 *
 */
@Entity
@Table(name = "mto_columnlist")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Columnlist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;


    /**
     * 专栏名字
     */
    @Column(name = "colname")
    private String colname;
    /**
     * 简介
     */
    @Column(name = "comment")
    private String comment;

    @Column(name = "logo")
    private String logo;

    @Column(name = "authorid")
    private long authorId;

    @Column(name = "classify")
    private String classify;

    @Column(name = "hot")
    private int hot;

    @Column(name = "idxstatus")
    private int idxstatus;

    @Column(name = "created")
    private Date created;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }



    public String getColname() {
        return colname;
    }

    public void setColname(String colname) {
        this.colname = colname;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getClassify() {
        return classify;
    }

    public void setClassify(String classify) {
        this.classify = classify;
    }
    public long getAuthorId() {
        return authorId;
    }

    public void setAuthorId(long authorId) {
        this.authorId = authorId;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }

    public int getIdxstatus() {
        return idxstatus;
    }

    public void setIdxstatus(int idxstatus) {
        this.idxstatus = idxstatus;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

}
