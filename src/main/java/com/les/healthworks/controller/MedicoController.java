package com.les.healthworks.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.les.healthworks.model.Consulta;
import com.les.healthworks.model.Paciente;
import com.les.healthworks.model.Usuario;
import com.les.healthworks.persistence.ConsultaDAO;

@Controller
public class MedicoController {
	
	@Autowired
	ConsultaDAO cDao;
	
	@RequestMapping(value = "/medico", method = RequestMethod.GET)
	 public ModelAndView showConsultasMedico(@RequestParam("email") String email, ModelMap model) throws ClassNotFoundException, SQLException {
		List<Consulta> consultas = new ArrayList<>();
		Usuario u = new Usuario();
		u.setEmail(email);
		
		try {
			consultas = cDao.consultasMedico(email);
		} catch (Exception e) {
			e.getMessage();
		} finally {
			model.addAttribute("param", u);
			model.addAttribute("consulta", consultas);
		}
		
		return new ModelAndView("medico");
	}
	
	@RequestMapping(value = "/medico", method = RequestMethod.POST)
	 public String buscaCM(@RequestParam Map<String, String> param, ModelMap model) throws ClassNotFoundException, SQLException {
		List<Consulta> consultas = new ArrayList<>();
		String email = param.get("email");
		String barra = param.get("barra");
		String botao = param.get("botao");
		
		if(botao.equalsIgnoreCase("buscar")) {
			try {
				if(barra.contains("/")){
					consultas = cDao.pesquisaConsultasMedico(email, barra);
				}else {
					String busca = barra + "%";
					consultas = cDao.pesquisaConsultasMedico(email, busca);
				}
			} catch (Exception e) {
				e.getMessage();
			} finally {
				model.addAttribute("consulta", consultas);
			}
		}	
		return "medico";
	}
	
	@RequestMapping(value = "/info/{cod}", method = RequestMethod.GET)
	public String showInfo(@PathVariable("cod") int cod, ModelMap model) throws ClassNotFoundException, SQLException {
		
		Paciente paciente = cDao.infoPaciente(cod);
		model.addAttribute("p", paciente);
		
		return "info";
	}
}
