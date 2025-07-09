package com.smartrenova.controller;

import com.smartrenova.domain.Categoria;
import com.smartrenova.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/categoria")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/listado")
    public String listado(Model model) {
        var lista = categoriaService.getCategorias();
        model.addAttribute("categorias", lista);
        model.addAttribute("totalCategorias", lista.size());
        return "/categoria/listado";
    }

    @GetMapping("/nuevo")
    public String nuevo(Model model) {
        model.addAttribute("categoria", new Categoria());
        return "/categoria/modifica";
    }

    @PostMapping("/guardar")
    public String guardar(Categoria categoria) {
        categoriaService.save(categoria);
        return "redirect:/categoria/listado";
    }

    @GetMapping("/modificar/{idCategoria}")
    public String modificar(@PathVariable("idCategoria") Long idCategoria, Model model) {
        var categoria = new Categoria();
        categoria.setIdCategoria(idCategoria);
        categoria = categoriaService.getCategoria(categoria);
        model.addAttribute("categoria", categoria);
        return "/categoria/modifica";
    }

    @GetMapping("/eliminar/{idCategoria}")
    public String eliminar(@PathVariable("idCategoria") Long idCategoria) {
        var categoria = new Categoria();
        categoria.setIdCategoria(idCategoria);
        categoriaService.delete(categoria);
        return "redirect:/categoria/listado";
    }
}
