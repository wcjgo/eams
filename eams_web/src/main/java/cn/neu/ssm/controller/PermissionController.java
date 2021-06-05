package cn.neu.ssm.controller;

import cn.neu.ssm.domain.Permission;
import cn.neu.ssm.service.IPermissionService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private IPermissionService permissionService;
    @RequestMapping("/deletePermission")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String deletePermission(String id) throws Exception {
        permissionService.deleteById(id);
        return "redirect:findAll.do";
    }

    @RequestMapping("/findById")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ModelAndView findById(String id) throws Exception {
      Permission permission=  permissionService.findById(id);
      ModelAndView mv=new ModelAndView();
      mv.setViewName("permission-show");
      mv.addObject("permission",permission);
      return mv;
    }

    @RequestMapping("/save.do")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String save(Permission permission) throws Exception {
        permissionService.save(permission);
        return "redirect:findAll.do";
    }
    @RequestMapping("/findAll.do")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ModelAndView findAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page, @RequestParam(name = "size", required = true, defaultValue = "4") Integer size) throws Exception {
        ModelAndView mv=new ModelAndView();
        List<Permission> permissionList = permissionService.findAll(page, size);
        //PageInfo就是一个分页Bean
        PageInfo pageInfo = new PageInfo(permissionList);
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("permission-list");
        return mv;
    }
}
