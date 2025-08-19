package com.smartrenova.controller;

import com.smartrenova.domain.Item;
import com.smartrenova.domain.Producto;
import com.smartrenova.service.ItemService;
import com.smartrenova.service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/carrito")
public class CarritoController {

    @Autowired private ItemService itemService;
    @Autowired private ProductoService productoService;

    @GetMapping("/listado")
    public String listado(Model model) {
        model.addAttribute("listaItems", itemService.getItems());
        model.addAttribute("carritoTotal", itemService.getTotal());
        return "/carrito/listado"; // (puedes crear una vista simple de respaldo)
    }

    @PostMapping("/guardar")
    public String guardar(Item item) {
        itemService.update(item);
        return "redirect:/carrito/listado";
    }

    @GetMapping("/eliminar/{idProducto}")
    public String eliminar(@PathVariable Long idProducto) {
        var item = new Item(); item.setIdProducto(idProducto);
        itemService.delete(item);
        return "redirect:/carrito/listado";
    }

    @GetMapping("/modificar/{idProducto}")
    public String modificar(@PathVariable Long idProducto, Model model) {
        var item = new Item(); item.setIdProducto(idProducto);
        item = itemService.getItem(item);
        model.addAttribute("item", item);
        return "/carrito/modifica";
    }

    @GetMapping("/agregar/{idProducto}")
    public String agregar(@PathVariable Long idProducto) {
        var p = new Producto(); p.setIdProducto(idProducto);
        p = productoService.getProducto(p);
        if (p != null) itemService.save(new Item(p));
        return "redirect:/carrito/listado";
    }

    @PostMapping("/facturar")
    public String facturar() {
        itemService.facturar();
        return "redirect:/"; // al terminar te llevo al home; cámbialo si quieres
    }
}
