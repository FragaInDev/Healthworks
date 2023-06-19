package com.les.healthworks.controller;

import java.sql.Date;
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

import com.les.healthworks.model.Paciente;
import com.les.healthworks.persistence.AtendenteDAO;

@Controller
public class AtendenteController {
	
	@Autowired
	AtendenteDAO aDao;
	
	@RequestMapping(name = "atendente", value = "/atendente", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model){
		List<Paciente> p = new ArrayList<>();
		
		try {
			p = aDao.listaPacientes();
		}catch (SQLException | ClassNotFoundException e){
			e.getMessage();
		}finally {
			model.addAttribute("paciente", p);
		}
        return new ModelAndView("atendente");
    }
	
	@RequestMapping(value = "/deletePaciente/{cpf}/{email}", method = RequestMethod.GET)
    public String deleteEspec(@PathVariable("cpf") String cpf, @PathVariable("email") String email) throws ClassNotFoundException, SQLException {
		Paciente p = new Paciente();
		p.setCpf(cpf);
		p.setEmail(email);
		//e.setCodigo(cod);
        aDao.excluiPaciente(p);
        return "redirect:/atendente";
    }
	
	@RequestMapping(value = "/editPaciente/{cpf}", method = RequestMethod.GET)
	 public String showEditPaciente(@PathVariable("cpf") String cpf, ModelMap model) throws ClassNotFoundException, SQLException {
		Paciente p = new Paciente();
		p.setCpf(cpf);
		
		Paciente paciente = aDao.pesquisaPaciente(p);
		
	    model.addAttribute("p", paciente);
	    return "editPaciente";
	 }
	
	@RequestMapping(value = "/editPaciente", method = RequestMethod.POST)
	 public String updatePaciente(ModelMap model, @RequestParam Map<String, String> params) throws ClassNotFoundException, SQLException {
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
		
		if(botao.equalsIgnoreCase("salvar")) {
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
			
			aDao.editaPaciente(p);
		}

		 return "redirect:/atendente";
	 }
	
	@RequestMapping(name = "atendente", value = "/atendente", method = RequestMethod.POST)
	public ModelAndView pacientes(ModelMap model, @RequestParam Map<String, String> param) throws ClassNotFoundException, SQLException {
		List<Paciente> pacientes = new ArrayList<>();
		String botao = param.get("botao");
		
		if (botao.equalsIgnoreCase("buscar")) {
			String n = param.get("ba");
			String nome = n + "%";
			pacientes = aDao.buscaPacientes(nome);
		}
		
		model.addAttribute("paciente", pacientes);
		
		return new ModelAndView("atendente");
	}
	
}
