package com.smartrenova.controller;

import com.smartrenova.domain.Usuario;
import com.smartrenova.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/usuario")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/listado")
    public String listado(Model model) {
        var usuarios = usuarioService.getUsuarios();
        model.addAttribute("usuarios", usuarios);
        model.addAttribute("totalUsuarios", usuarios.size());
        return "/usuario/listado";
    }

    @GetMapping("/nuevo")
    public String nuevo(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "/usuario/modifica";
    }

    @PostMapping("/guardar")
    public String guardar(Usuario usuario) {
        usuarioService.save(usuario);
        return "redirect:/usuario/listado";
    }

    @GetMapping("/modificar/{idUsuario}")
    public String modificar(@PathVariable("idUsuario") Long idUsuario, Model model) {
        var usuario = new Usuario();
        usuario.setIdUsuario(idUsuario);
        usuario = usuarioService.getUsuario(usuario);
        model.addAttribute("usuario", usuario);
        return "/usuario/modifica";
    }

    @GetMapping("/eliminar/{idUsuario}")
    public String eliminar(@PathVariable("idUsuario") Long idUsuario) {
        var usuario = new Usuario();
        usuario.setIdUsuario(idUsuario);
        usuarioService.delete(usuario);
        return "redirect:/usuario/listado";
    }
}
