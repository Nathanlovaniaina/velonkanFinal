package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalendrierController {
    @GetMapping("/calendrier")
    public String afficherCalendrier() {
        return "calendrier-content";
    }
} 