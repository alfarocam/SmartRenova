package com.smartrenova.domain;
import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author CamilaAlfaro 06/07/2025
 */

@Data
@Entity
@Table(name = "producto")
public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_producto")
    private Long idProducto;

    @ManyToOne
    @JoinColumn(name = "id_categoria")
    private Categoria categoria;

    @Column(name = "descripcion")
    private String descripcion;

    @Column(name = "detalle")
    private String detalle;

    @Column(name = "precio")
    private Double precio;

    @Column(name = "existencias")
    private Integer existencias;

    @Column(name = "ruta_imagen")
    private String rutaImagen;

    @Column(name = "activo")
    private Boolean activo;
}
