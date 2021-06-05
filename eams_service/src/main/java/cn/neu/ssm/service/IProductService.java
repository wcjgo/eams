package cn.neu.ssm.service;

import cn.neu.ssm.domain.Product;

import java.util.List;

public interface IProductService {

    public List<Product> findAll(int page, int size) throws Exception;

    void save(Product product) throws Exception;
}
