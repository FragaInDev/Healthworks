package com.les.healthworks.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class GestorController {
	
	@RequestMapping(name = "gestor", value = "/gestor", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model){
        return new ModelAndView("gestor");
    }
}
