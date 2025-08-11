package com.smartrenova.service;

import com.smartrenova.domain.Producto;
import com.smartrenova.repository.ProductoRepository;
import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductoService {

    @Autowired
    private ProductoRepository productoRepository;

    @Transactional(readOnly = true)
    public List<Producto> getProductos() {
        return productoRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Producto getProducto(Producto producto) {
        return productoRepository.findById(producto.getIdProducto()).orElse(null);
    }

    @Transactional
    public void save(Producto producto) {
        productoRepository.save(producto);
    }

    @Transactional
    public void delete(Producto producto) {
        productoRepository.delete(producto);
    }

    @Transactional(readOnly = true)
    public List<Producto> getProductosActivos() {
        return productoRepository.findByActivoTrueOrderByPrecioAsc();
    }

    @Transactional(readOnly = true)
    public List<Producto> getProductosPorCategoria(Long idCategoria) {
        return productoRepository.findByCategoria_IdCategoriaAndActivoTrueOrderByPrecioAsc(idCategoria);
    }

    // === Buscador ===
    @Transactional(readOnly = true)
    public List<Producto> buscar(String q) {
        if (q == null || q.trim().isEmpty()) {
            return Collections.emptyList();
        }
        return productoRepository
                .findTop50ByActivoTrueAndDescripcionContainingIgnoreCaseOrderByPrecioAsc(q.trim());
    }
}

