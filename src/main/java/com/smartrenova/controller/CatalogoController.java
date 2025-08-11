package com.smartrenova.controller;

import com.smartrenova.domain.Producto;
import com.smartrenova.service.CategoriaService;
import com.smartrenova.service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CatalogoController {

    @Autowired private CategoriaService categoriaService;
    @Autowired private ProductoService  productoService;

    @GetMapping({"/catalogo"})
    public String catalogo(Model model) {
        model.addAttribute("categorias", categoriaService.getCategorias());
        model.addAttribute("productos",  productoService.getProductosActivos());
        model.addAttribute("tituloCategoria", "Todas las categorías");
        model.addAttribute("idCategoriaSeleccionada", null);
        return "catalogo/listado";
    }

    @GetMapping("/catalogo/categoria/{id}")
    public String catalogoPorCategoria(@PathVariable Long id, Model model) {
        model.addAttribute("categorias", categoriaService.getCategorias());
        model.addAttribute("productos",  productoService.getProductosPorCategoria(id));
        model.addAttribute("tituloCategoria", "Categoría seleccionada");
        model.addAttribute("idCategoriaSeleccionada", id);
        return "catalogo/listado";
    }

    // === Buscador ===
    @GetMapping("/catalogo/buscar")
    public String buscar(@RequestParam(name = "q", required = false) String q, Model model) {
        model.addAttribute("categorias", categoriaService.getCategorias());
        model.addAttribute("productos",  productoService.buscar(q));
        model.addAttribute("tituloCategoria", (q == null || q.isBlank())
                ? "Resultados" : "Resultados para: \"" + q.trim() + "\"");
        model.addAttribute("idCategoriaSeleccionada", null);
        return "catalogo/listado";
    }

    @GetMapping("/producto/{id}")
    public String detalle(@PathVariable Long id, Model model) {
        var p = new Producto(); p.setIdProducto(id);
        model.addAttribute("producto", productoService.getProducto(p));
        return "producto/detalle";
    }
}

