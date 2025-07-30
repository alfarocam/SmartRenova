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
@Table(name = "categoria")
public class Categoria implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_categoria")
    private Long idCategoria;

    @Column(name = "descripcion")
    private String descripcion;

    @Column(name = "ruta_imagen")
    private String rutaImagen;

    @Column(name = "activo")
    private Boolean activo;
}
