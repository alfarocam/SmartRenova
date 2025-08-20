package com.smartrenova.domain;
import com.smartrenova.domain.Item;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;


@ControllerAdvice
@Component
public class GlobalModel {

    @SuppressWarnings("unchecked")
    @ModelAttribute
    public void addCartData(HttpSession session, Model model) {
        List<Item> lista = (List<Item>) session.getAttribute("listaItems");
        if (lista == null) {
            lista = new ArrayList<>();
            session.setAttribute("listaItems", lista);
        }
        double total = 0.0;
        int count = 0;
        for (Item i : lista) {
            double precio = (i.getPrecio() == null ? 0.0 : i.getPrecio());
            total += precio * i.getCantidad();
            count += i.getCantidad();              
        }
        model.addAttribute("listaItems", lista);
        model.addAttribute("carritoTotal", total);
        model.addAttribute("carritoCount", count);  
    }
}
