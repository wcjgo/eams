package cn.neu.ssm.controller;

import cn.neu.ssm.domain.Product;
import cn.neu.ssm.service.IProductService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.security.RolesAllowed;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private IProductService productService;

    //产品添加
    @RequestMapping("/save.do")
    @PreAuthorize("hasRole('ROLE_USER')")
    public String save(Product product) throws Exception {
        productService.save(product);
        return "redirect:findAll.do";
    }

    //查询全部产品
    @RequestMapping("/findAll.do")
    @RolesAllowed("USER")
    public ModelAndView findAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page, @RequestParam(name = "size", required = true, defaultValue = "4") Integer size) throws Exception {
        ModelAndView mv = new ModelAndView();
        List<Product> ps = productService.findAll(page,size);
        PageInfo pageInfo = new PageInfo(ps);
        //mv.addObject("productList", ps);
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("product-page-list");
        return mv;

    }
}
