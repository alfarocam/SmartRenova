package com.smartrenova.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
@SuppressWarnings("serial")
public class Item extends Producto {
    private int cantidad;

    public Item() {}

    public Item(Producto p) {
        super.setIdProducto(p.getIdProducto());
        super.setCategoria(p.getCategoria());
        super.setDescripcion(p.getDescripcion());
        super.setDetalle(p.getDetalle());
        super.setPrecio(p.getPrecio());      // Double
        super.setExistencias(p.getExistencias()); // Integer
        super.setRutaImagen(p.getRutaImagen());
        super.setActivo(p.getActivo());
        this.cantidad = 0;
    }
}
