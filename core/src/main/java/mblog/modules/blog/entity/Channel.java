/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 Demoso. All Rights Reserved
|   http://www.demoso.net
|
+---------------------------------------------------------------------------
*/
package mblog.modules.blog.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;

/**
 * 模块/内容分组
 * @author langhsu
 *
 */
@Entity
@Table(name = "mto_channels")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Channel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	/**
	 * 名称
	 */
	private String name;

	/**
	 * 唯一关键字
	 */
	@Column(name = "key_", unique = true)
	private String key;

	private int status;

    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
