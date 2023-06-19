package com.les.healthworks.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.les.healthworks.model.Consulta;
import com.les.healthworks.model.Especialidade;
import com.les.healthworks.model.Medico;
import com.les.healthworks.persistence.AtendenteDAO;
import com.les.healthworks.persistence.GestorDAO;

@Controller
public class ConsultaAddController {
	
	@Autowired
	AtendenteDAO aDao; 
	
	@Autowired
	GestorDAO gDao;
	
	@RequestMapping(name = "consultaAdd", value = "/consultaAdd", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model) throws ClassNotFoundException, SQLException{
		List<Especialidade> espec = gDao.listaEspecialidades();
		List<Medico> medico = gDao.listaMedicos();
		
		model.addAttribute("especialidade", espec);
		model.addAttribute("medico", medico);
        return new ModelAndView("consultaAdd");
    }
	
	@RequestMapping(name = "consultaAdd", value = "/consultaAdd", method = RequestMethod.POST)
    public ModelAndView adicionarConsulta(@RequestParam Map<String, String> params, ModelMap model) throws SQLException, ClassNotFoundException{
		
		String cpf = params.get("cpf");
		String data = params.get("data");
		String hora = params.get("hora");
		String medico = params.get("medico");
		int espec = Integer.parseInt(params.get("espec"));
		String botao = params.get("botao");
		
		if(botao.equalsIgnoreCase("adicionar consulta")) {
			Consulta c = new Consulta();
			
			c.setPaciente(cpf);
			c.setData(data);
			c.setHora(hora);
			c.setMedico(medico);
			c.setEspecialidadeByCodigo(espec);
			
			aDao.cadastraConsulta(c);
			
		}
		
        return new ModelAndView("consultaAdd");
    }
}
