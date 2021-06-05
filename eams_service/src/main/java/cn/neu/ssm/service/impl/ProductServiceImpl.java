package cn.neu.ssm.service.impl;

import cn.neu.ssm.dao.IProductDao;
import cn.neu.ssm.domain.Product;
import cn.neu.ssm.service.IProductService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional
public class ProductServiceImpl implements IProductService{

    @Autowired
    private IProductDao productDao;

    @Override
    public List<Product> findAll(int page, int size) throws Exception {
        //参数pageNum 是页码值   参数pageSize 代表是每页显示条数
        PageHelper.startPage(page,size);
        return productDao.findAll();
    }

    @Override
    public void save(Product product) {
        productDao.save(product);
    }

}
