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
import com.les.healthworks.model.Especialidade;
import com.les.healthworks.model.Medico;
import com.les.healthworks.persistence.AtendenteDAO;
import com.les.healthworks.persistence.GestorDAO;

@Controller
public class ConsultaController {
	@Autowired
	AtendenteDAO aDao;
	
	@Autowired
	GestorDAO gDao;
	
	@RequestMapping(name = "consultas", value = "/consultas", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model){
		List<Consulta> consultas = new ArrayList<>();
		
		try {
			consultas = aDao.listaConsultas();
		}catch (SQLException | ClassNotFoundException e){
			e.getMessage();
		}finally {
			model.addAttribute("consulta", consultas);
		}
        return new ModelAndView("consultas");
    }
	
	@RequestMapping(value = "/deleteConsulta/{cod}", method = RequestMethod.GET)
    public String deleteConsulta(@PathVariable("cod") int cod) throws ClassNotFoundException, SQLException {
		Consulta c = new Consulta();
		c.setCod(cod);

        aDao.excluiConsulta(c);
        return "redirect:/consultas";
    }
	
	@RequestMapping(value = "/editConsulta/{cod}", method = RequestMethod.GET)
	 public String showEditConsulta(@PathVariable("cod") int cod, ModelMap model) throws ClassNotFoundException, SQLException {
		List<Especialidade> espec = gDao.listaEspecialidades();
		List<Medico> medico = gDao.listaMedicos();
		
		Consulta c = new Consulta();
		c.setCod(cod);
		
		Consulta consulta = aDao.pesquisaConsulta(c);
		
		model.addAttribute("especialidade", espec);
		model.addAttribute("medico", medico);
	    model.addAttribute("c", consulta);
	    return "editConsulta";
	 }
	
	@RequestMapping(value = "/editConsulta", method = RequestMethod.POST)
	 public String updateConsulta(ModelMap model, @RequestParam Map<String, String> params) throws ClassNotFoundException, SQLException {
		
		int cod = Integer.parseInt(params.get("cod"));
		String cpf = params.get("cpf");
		String data = params.get("data");
		String hora = params.get("hora");
		String medico = params.get("medico");
		int espec = Integer.parseInt(params.get("espec"));
		String botao = params.get("botao");
		
		if(botao.equalsIgnoreCase("salvar")) {
			Consulta c = new Consulta();
			
			c.setCod(cod);
			c.setPaciente(cpf);
			c.setData(data);
			c.setHora(hora);
			c.setMedico(medico);
			c.setEspecialidadeByCodigo(espec);
			
			aDao.editaConsulta(c);
	
		}

		return "redirect:/consultas";
	 }
	
	@RequestMapping(name = "consultas", value = "/consultas", method = RequestMethod.POST)
    public ModelAndView pesquisarConsulta(@RequestParam Map<String, String> params, ModelMap model) throws SQLException, ClassNotFoundException{
		List<Consulta> c = new ArrayList<>();
		String barra = params.get("barra");
		String botao = params.get("botao");
		
		if(botao.equalsIgnoreCase("buscar")) {
			try {
				if(barra.contains("/")) {
					c = aDao.buscaConsultas(barra);
				}else {
					String busca = barra + "%";
					c = aDao.buscaConsultas(busca);
				}
				
			}catch (SQLException | ClassNotFoundException e){
				e.getMessage();
			}finally {
				model.addAttribute("consulta", c);
			}
		}
        return new ModelAndView("consultas");
	}
	
}
