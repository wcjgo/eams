package cn.neu.ssm.service.impl;

import cn.neu.ssm.dao.ISysLogDao;
import cn.neu.ssm.domain.SysLog;
import cn.neu.ssm.service.ISysLogService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class SysLogServiceImpl implements ISysLogService {

    @Autowired
    private ISysLogDao sysLogDao;

    @Override
    public List<SysLog> findAll(int page, int size) throws Exception {
        //参数pageNum 是页码值   参数pageSize 代表是每页显示条数
        PageHelper.startPage(page, size);
        List<SysLog> logs = sysLogDao.findAll();
        for (SysLog log : logs) {
            Date visitTime = log.getVisitTime();
            SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月dd日 hh:mm:ss");
            log.setVisitTimeStr(format.format(visitTime));
        }
        return logs;
    }

    @Override
    public void save(SysLog sysLog) throws Exception {
        sysLogDao.save(sysLog);
    }
}
