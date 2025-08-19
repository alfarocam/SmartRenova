package com.smartrenova.service;

import com.smartrenova.domain.*;
import com.smartrenova.repository.*;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ItemService {

    @Autowired private HttpSession session;

    @SuppressWarnings("unchecked")
    public List<Item> getItems() {
        var lista = (List<Item>) session.getAttribute("listaItems");
        if (lista == null) {
            lista = new ArrayList<>();
            session.setAttribute("listaItems", lista);
        }
        return lista;
    }

    public Item getItem(Item item) {
        for (Item i : getItems()) {
            if (i.getIdProducto().equals(item.getIdProducto())) return i;
        }
        return null;
    }

    public void save(Item item) {
        var existente = getItem(item);
        if (existente == null) { item.setCantidad(1); getItems().add(item); }
        else { existente.setCantidad(existente.getCantidad() + 1); }
    }

    public void update(Item item) {
        var i = getItem(item);
        if (i != null) i.setCantidad(item.getCantidad());
    }

    public void delete(Item item) {
        getItems().removeIf(x -> x.getIdProducto().equals(item.getIdProducto()));
    }

    public double getTotal() {
        double total = 0.0;
        for (Item i : getItems()) {
            total += i.getCantidad() * (i.getPrecio() == null ? 0.0 : i.getPrecio());
        }
        return total;
    }

    @Autowired private UsuarioRepository usuarioRepository;
    @Autowired private ProductoRepository productoRepository;
    @Autowired private FacturaRepository facturaRepository;
    @Autowired private VentaRepository   ventaRepository;

    @SuppressWarnings("unchecked")
    public void facturar() {
        // TODO: reemplazar por usuario autenticado cuando integres seguridad
        var usuario = usuarioRepository.findById(1L).orElse(null); // sebas
        if (usuario == null) return;

        Factura factura = facturaRepository.save(new Factura(usuario.getIdUsuario()));

        List<Item> lista = (List<Item>) session.getAttribute("listaItems");
        if (lista != null) {
            double total = 0;
            for (Item i : lista) {
                var producto = productoRepository.getReferenceById(i.getIdProducto());
                int cant = i.getCantidad();
                int exist = producto.getExistencias() == null ? 0 : producto.getExistencias();
                if (exist >= cant) {
                    ventaRepository.save(new Venta(
                        factura.getIdFactura(),
                        i.getIdProducto(),
                        i.getPrecio() == null ? 0.0 : i.getPrecio(),
                        cant
                    ));
                    producto.setExistencias(exist - cant);
                    productoRepository.save(producto);
                    total += cant * (i.getPrecio() == null ? 0.0 : i.getPrecio());
                }
            }
            factura.setTotal(total);
            facturaRepository.save(factura);
            lista.clear();
        }
    }
}
