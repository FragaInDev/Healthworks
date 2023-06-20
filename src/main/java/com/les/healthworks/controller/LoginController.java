package com.les.healthworks.controller;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.les.healthworks.model.Usuario;
import com.les.healthworks.persistence.LoginDAO;

@Controller
public class LoginController {
	 @Autowired
	 private LoginDAO uDao;

	 @RequestMapping(name = "index", value = "/index", method = RequestMethod.GET)
	 public ModelAndView init(ModelMap model){
		 return new ModelAndView("index");
	 }

	 @RequestMapping(name = "index", value = "/index", method = RequestMethod.POST)
	 public String autenticar(@RequestParam Map<String, String> params, ModelMap model) throws SQLException, ClassNotFoundException {
		 Usuario u = new Usuario();

	     String email = params.get("email");
	     String senha = params.get("senha");
	     String botao = params.get("btn");

	     String view = "";

	     if (botao.equalsIgnoreCase("logar")){
	     u = uDao.getLogin(email, senha);
	         
	     System.out.println(u.getEmail());
	            

	    	if (u.getTipo().equalsIgnoreCase("G")){
	    		view = "redirect:/gestor";
	    	}else if (u.getTipo().equalsIgnoreCase("A")){
	    		view = "redirect:/atendente";
	    	}else if (u.getTipo().equalsIgnoreCase("M")){
	    		view = "redirect:/medico?email=" + email;
	    	}else if (u.getTipo().equalsIgnoreCase("P")){
	    		view = "redirect:/paciente?email=" + email;
	    	}
	     
	     }
	        return view;
	    }
}

