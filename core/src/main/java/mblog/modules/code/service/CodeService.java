/*
+--------------------------------------------------------------------------
|   Mblog [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 mtons. All Rights Reserved
|   http://www.mtons.com
|
+---------------------------------------------------------------------------
*/
package mblog.modules.code.service;


import mblog.modules.code.dao.CodeDao;
import mblog.modules.code.data.Code;
import mblog.modules.code.entity.CodePO;
import mblog.modules.user.data.UserVO;
import mblog.modules.user.service.UserService;
import mblog.modules.utils.BeanMapUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author langhsu
 */
@Service
public class CodeService {
    @Autowired
    private CodeDao codeDao;

    @Autowired
    private UserService userService;

    @Transactional
    public long saveCode(Code Code) {
        CodePO po = new CodePO();
        BeanUtils.copyProperties(Code, po);
        po.setCreated(new Date());
        codeDao.save(po);
        return po.getId();
    }

    @Transactional
    public Code get(long id) {
        CodePO po = codeDao.findOne(id);
        Code d = new Code();
        if (po != null) {
            BeanUtils.copyProperties(po, d);
        }
        return d;
    }

    private List<Code> toCodes(List<CodePO> codes) {
        List<Code> rets = new ArrayList<>();
        HashSet<Long> uids = new HashSet<>();
        codes.forEach(po -> {
            uids.add(po.getAuthorId());
            rets.add(BeanMapUtils.copy(po));
        });
        // 加载用户信息
        buildUsers(rets, uids);
        return rets;
    }


    @Transactional(readOnly = true)
    @Cacheable
    public Page<Code> paging(Pageable pageable) {
        Page<CodePO> page = codeDao.findAllByOrderByIdDesc(pageable);
        return new PageImpl<>(toCodes(page.getContent()), pageable, page.getTotalElements());
    }

    private void buildUsers(Collection<Code> codes, Set<Long> uids) {
        Map<Long, UserVO> userMap = userService.findMapByIds(uids);

        codes.forEach(p -> p.setAuthor(userMap.get(p.getAuthorId())));
    }

}
