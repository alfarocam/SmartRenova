package com.smartrenova.controller;

import com.smartrenova.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping({"/", "/index"})
    public String index(Model model) {
        // Para que el dropdown del header tenga datos en el home
        model.addAttribute("categorias", categoriaService.getCategorias());
        model.addAttribute("idCategoriaSeleccionada", null);
        return "index"; // templates/index.html
    }
}
