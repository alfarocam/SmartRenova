package com.smartrenova.controller;

import com.smartrenova.domain.Producto;
import com.smartrenova.service.ProductoService;
import com.smartrenova.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
//
@Controller
@RequestMapping("/producto")
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/listado")
    public String listado(Model model) {
        var productos = productoService.getProductos();
        model.addAttribute("productos", productos);
        model.addAttribute("totalProductos", productos.size());
        return "/producto/listado";
    }

    @GetMapping("/nuevo")
    public String nuevo(Model model) {
        model.addAttribute("producto", new Producto());
        model.addAttribute("categorias", categoriaService.getCategorias());
        return "/producto/modifica";
    }

    @PostMapping("/guardar")
    public String guardar(Producto producto) {
        productoService.save(producto);
        return "redirect:/producto/listado";
    }

    @GetMapping("/modificar/{idProducto}")
    public String modificar(@PathVariable("idProducto") Long idProducto, Model model) {
        var producto = new Producto();
        producto.setIdProducto(idProducto);
        producto = productoService.getProducto(producto);
        model.addAttribute("producto", producto);
        model.addAttribute("categorias", categoriaService.getCategorias());
        return "/producto/modifica";
    }

    @GetMapping("/eliminar/{idProducto}")
    public String eliminar(@PathVariable("idProducto") Long idProducto) {
        var producto = new Producto();
        producto.setIdProducto(idProducto);
        productoService.delete(producto);
        return "redirect:/producto/listado";
    }
}
