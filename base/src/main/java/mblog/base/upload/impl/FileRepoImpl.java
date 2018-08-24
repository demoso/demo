/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 Demoso. All Rights Reserved
|   http://www.demoso.net
|
+---------------------------------------------------------------------------
*/
package mblog.base.upload.impl;

import org.springframework.stereotype.Service;

/**
 * @author langhsu
 *
 */
@Service
public class FileRepoImpl extends AbstractFileRepo {
	@Override
	public String getRoot() {
		return appContext.getRoot();
	}
}
