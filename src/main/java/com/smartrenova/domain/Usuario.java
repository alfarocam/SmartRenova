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
@Table(name = "usuario")
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Long idUsuario;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "apellidos")
    private String apellidos;

    @Column(name = "correo")
    private String correo;

    @Column(name = "telefono")
    private String telefono;

    @Column(name = "ruta_imagen")
    private String rutaImagen;

    @Column(name = "activo")
    private Boolean activo;
}
