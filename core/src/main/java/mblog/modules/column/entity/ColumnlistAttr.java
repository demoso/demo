package mblog.modules.column.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

/**
 * 模块/专栏文章列表
 * @author langhsu
 *
 */
@Entity
@Table(name = "mto_columnlist_attr")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ColumnlistAttr {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "columnid")
    private int columnid;

    @Column(name = "url")
    private String url;

    @Column(name = "title")
    private String title;

    @Column(name = "css_type")
    private String csstype;

    @Column(name = "hot")
    private int hot;

    @Column(name = "created")
    private Date created;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getColumnid() {
        return columnid;
    }

    public void setColumnid(int columnid) {
        this.columnid = columnid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCsstype() {
        return csstype;
    }

    public void setCsstype(String csstype) {
        this.csstype = csstype;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }
}
