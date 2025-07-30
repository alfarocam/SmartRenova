/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.smartrenova.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class sobreNosotrosController {

    @GetMapping("/sobreNosotros")
    public String sobreNosotros() {
        return "sobreNosotros/sobreNosotros";
    }
}