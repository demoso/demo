package mblog.boot;

import mblog.base.context.AppContext;
import mblog.base.lang.Consts;
import mblog.base.print.Printer;
import mblog.modules.blog.entity.Classify;
import mblog.modules.blog.entity.Config;
import mblog.modules.blog.service.ChannelService;
import mblog.modules.blog.service.ClassifyService;
import mblog.modules.blog.service.ConfigService;
import mblog.modules.column.entity.Columnlist;
import mblog.modules.column.service.ColumnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;
import java.util.*;

/**
 * 加载配置信息到系统
 *
 */
@Component
public class ContextStartup implements ApplicationRunner, Ordered, ServletContextAware {
    @Autowired
    private ConfigService configService;
    @Autowired
    private ChannelService channelService;
    @Autowired
    private AppContext appContext;
    @Autowired
    ClassifyService classifyService;
    @Autowired
    private ColumnService columnService;

    private ServletContext servletContext;

    @Override
    public void run(ApplicationArguments applicationArguments) throws Exception {
        Timer timer = new Timer("init config");
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                Printer.info("initialization ...");

                resetSiteConfig(true);
                resetChannels();
                bandMap();

                Printer.info("OK, completed");
            }
        }, 1 * Consts.TIME_MIN);
    }

    @Override
    public int getOrder() {
        return 2;
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /**
     * 重置站点配置
     */
    public void resetSiteConfig(boolean exit) {
        List<Config> configs = configService.findAll();

        Map<String, String> map = new HashMap<>();

        if (null == configs || configs.isEmpty()) {
            Printer.error("------------------------------------------------------------");
            Printer.error("-  ERROR:The SQL file is not imported. (sql/db_mblog.sql)  -");
            Printer.error("-         Please import the SQL file and try again.        -");
            Printer.error("------------------------------------------------------------");

            if (exit) {
                System.exit(1);
            }
        } else {
            configs.forEach(conf -> {
                servletContext.setAttribute(conf.getKey(), conf.getValue());
                map.put(conf.getKey(), conf.getValue());
            });

            appContext.setConfig(map);
        }
    }

    /**
     * 重置栏目缓存
     */
    public void resetChannels() {
        servletContext.setAttribute("channels", channelService.findAll(Consts.STATUS_NORMAL));
    }

    public void bandMap() {
        Map<String, List<Columnlist>> map = new HashMap<>();
        //专栏list
        List<Columnlist> columnlists = columnService.findByIdxstatusOrderByHot(1);
        //分类list
        List<Classify> classifies = classifyService.findByAuthorIdOrderByCreatedDesc(0);
        //根据分类来遍历
        for (Classify classify : classifies) {
            List<Columnlist> listcol = new ArrayList<Columnlist>();
            //重新新封装
            for (Columnlist columnlist : columnlists) {
                if (classify.getId() == columnlist.getClassid()) {
                    listcol.add(columnlist);
                }
            }
            if (listcol.size() != 0)
                map.put(classify.getClassname(), listcol);
        }
        servletContext.setAttribute("classify_column_map", map);
    }
}
