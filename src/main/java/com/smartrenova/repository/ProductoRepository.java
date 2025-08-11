package com.smartrenova.repository;

import com.smartrenova.domain.Producto;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoRepository extends JpaRepository<Producto, Long> {

    List<Producto> findByActivoTrueOrderByPrecioAsc();

    List<Producto> findByCategoria_IdCategoriaAndActivoTrueOrderByPrecioAsc(Long idCategoria);

    // Para el buscador (por descripción, máx 50 resultados)
    List<Producto> findTop50ByActivoTrueAndDescripcionContainingIgnoreCaseOrderByPrecioAsc(String q);
}
