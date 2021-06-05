package cn.neu.ssm.service;

import cn.neu.ssm.domain.SysLog;

import java.util.List;

public interface ISysLogService {

    public void save(SysLog sysLog) throws Exception;

    List<SysLog> findAll(int page, int size) throws Exception;
}
