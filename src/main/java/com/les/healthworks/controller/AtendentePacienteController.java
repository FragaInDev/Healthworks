package com.les.healthworks.controller;

import java.sql.Date;
import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.les.healthworks.model.Paciente;
import com.les.healthworks.persistence.AtendenteDAO;

@Controller
public class AtendentePacienteController {
	
	@Autowired
	AtendenteDAO aDao;
	
	@RequestMapping(name = "atendenteAddPaci", value = "/atendenteAddPaci", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model){
        return new ModelAndView("atendenteAddPaci");
    }
	
	@RequestMapping(name = "atendenteAddPaci", value = "/atendenteAddPaci", method = RequestMethod.POST)
    public ModelAndView adicionarPaciente(@RequestParam Map<String, String> params, ModelMap model) throws SQLException, ClassNotFoundException{
		
		String sus = params.get("sus");
		String cpf = params.get("cpf");
		String nome = params.get("nome");
		Date dataNasc = Date.valueOf(params.get("dataNasc"));
		String email = params.get("email");
		String senha = params.get("senha");
		String telefone = params.get("telefone");
		String genero = params.get("genero");
		String tipoSangue = params.get("tipoSangue");
		Double peso = Double.parseDouble(params.get("peso"));
		int altura = Integer.parseInt(params.get("altura"));
		String botao = params.get("botao");
		
		if(botao.equalsIgnoreCase("adicionar paciente")) {
			Paciente p = new Paciente();
			
			p.setCpf(cpf);
			p.setCartaoSUS(sus);
			p.setNome(nome);
			p.setDataNasc(dataNasc);
			p.setEmail(email);
			p.setSenha(senha);
			p.setTelefone(telefone);
			p.setGenero(genero);
			p.setTipoSanguineo(tipoSangue);
			p.setPeso(peso);
			p.setAltura(altura);
			
			aDao.cadastraPaciente(p);
		}
		
        return new ModelAndView("atendenteAddPaci");
    }
}
