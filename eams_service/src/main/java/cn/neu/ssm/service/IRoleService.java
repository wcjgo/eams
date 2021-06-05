package cn.neu.ssm.service;

import cn.neu.ssm.domain.Permission;
import cn.neu.ssm.domain.Role;

import java.util.List;

public interface IRoleService {

    public List<Role> findAll(int page, int size) throws Exception;

    void save(Role role) throws Exception;

    Role findById(String roleId) throws  Exception;

    List<Permission> findOtherPermissions(String roleId) throws Exception;

    void addPermissionToRole(String roleId, String[] permissionIds) throws Exception;

    void deleteRoleById(String roleId) throws Exception;
}
