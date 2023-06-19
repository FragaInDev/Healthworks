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

import com.les.healthworks.model.Atendente;
import com.les.healthworks.model.Especialidade;
import com.les.healthworks.model.Medico;
import com.les.healthworks.persistence.GestorDAO;

@Controller
public class GestorProfiController {
	
	@Autowired
	GestorDAO gDao;
	
	@RequestMapping(name = "gestorProfi", value = "/gestorProfi", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model){
		List<Atendente> atendentes = new ArrayList<>();
		List<Medico> medicos = new ArrayList<>();
		
		try {
			atendentes = gDao.listaAtendentes();
			medicos = gDao.listaMedicos();
		}catch (SQLException | ClassNotFoundException e){
			e.getMessage();
		}finally {
			model.addAttribute("atendente", atendentes);
			model.addAttribute("medico", medicos);
		}
        return new ModelAndView("gestorProfi");
    }
	
	@RequestMapping(value = "/deleteMedico/{crm}/{email}", method = RequestMethod.GET)
    public String deleteMedico(@PathVariable("crm") String crm, @PathVariable("email") String email) throws ClassNotFoundException, SQLException {
		Medico m = new Medico();
		m.setCrm(crm);
		m.setEmail(email);
		gDao.excluiMedico(m);

        return "redirect:/gestorProfi";
    }
	
	@RequestMapping(value = "/deleteAtendente/{cpf}/{email}", method = RequestMethod.GET)
    public String deleteAtendente(@PathVariable("cpf") String cpf, @PathVariable("email") String email) throws ClassNotFoundException, SQLException {
		Atendente a = new Atendente();
		a.setCpf(cpf);
		a.setEmail(email);
        gDao.excluiAtendente(a);
        return "redirect:/gestorProfi";
    }
	
	 @RequestMapping(value = "/editAtendente/{cpf}", method = RequestMethod.GET)
	 public String showEditAtendente(@PathVariable("cpf") String cpf, ModelMap model) throws ClassNotFoundException, SQLException {
		 Atendente a = new Atendente();
		 a.setCpf(cpf);
		 
		 Atendente atendente = gDao.pesquisaAtendenteCpf(a);
	     model.addAttribute("a", atendente);
	     return "editAtendente";
	 }
	 
	 @RequestMapping(value = "/editAtendente", method = RequestMethod.POST)
	 public String updateAtendente(ModelMap model, @RequestParam Map<String, String> params) throws ClassNotFoundException, SQLException {
		 String cpf = params.get("cpf");
		 String nome = params.get("nome");
		 String email = params.get("email");
		 String senha = params.get("senha");
		 String telefone = params.get("telefone");
		 int cargo = Integer.parseInt(params.get("cargo"));
		 String botao = params.get("botao");
		 
		 if (botao.equalsIgnoreCase("atualizar profissional")) {
			 Atendente a = new Atendente();
			 a.setCpf(cpf);
			 a.setNome(nome);
			 a.setEmail(email);
			 a.setSenha(senha);
			 a.setTelefone(telefone);
			 a.setCargo(cargo);
			 
			 gDao.editaAtendente(a);
		 }

		 return "redirect:/gestorProfi";
	 }
	 
	 @RequestMapping(value = "/editMedico/{crm}", method = RequestMethod.GET)
	 public String showEditMedico(@PathVariable("crm") String crm, ModelMap model) throws ClassNotFoundException, SQLException {
		 Medico m = new Medico();
		 m.setCrm(crm);
		 Medico medico = gDao.pesquisaMedico(m);
		 
		 List<Especialidade> espec = gDao.listaEspecialidades();
		 
		 model.addAttribute("especialidade", espec);
		 model.addAttribute("m", medico);
		 
	     return "editMedico";
	 }
	 
	 @RequestMapping(value = "/editMedico", method = RequestMethod.POST)
	 public String updateMedico(ModelMap model, @RequestParam Map<String, String> params) throws ClassNotFoundException, SQLException {
		 String crm = params.get("crm");
		 String cpf = params.get("cpf");
		 String nome = params.get("nome");
		 String email = params.get("email");
		 String senha = params.get("senha");
		 String telefone = params.get("telefone");
		 int cargo = Integer.parseInt(params.get("cargo"));
		 int espec = Integer.parseInt(params.get("espec"));
		 String botao = params.get("botao");
		 
		 if (botao.equalsIgnoreCase("atualizar profissional")) {
			 Medico m = new Medico();
			 m.setCrm(crm);
			 m.setCpf(cpf);
			 m.setNome(nome);
			 m.setEmail(email);
			 m.setSenha(senha);
			 m.setCargo(cargo);
			 m.setEspecialidadeByCodigo(espec);
			 m.setTelefone(telefone);
			 
			 gDao.editaMedico(m);
		 }

		 return "redirect:/gestorProfi";
	 }
	
	
	
	@RequestMapping(name = "gestorProfi", value = "/gestorProfi", method = RequestMethod.POST)
	public ModelAndView profissionais(ModelMap model, @RequestParam Map<String, String> param) throws ClassNotFoundException, SQLException {
		List<Atendente> atendentes = new ArrayList<>();
		List<Medico> medicos = new ArrayList<>();
		
		String botao = param.get("botao");
		
		if (botao.equalsIgnoreCase("buscar atendente")) {
			String n = param.get("ba");
			String nome = n + "%";
			atendentes = gDao.buscaAtendentes(nome);
			medicos = gDao.listaMedicos();
		}else {
			String n = param.get("bm");
			String nome = n + "%";
			medicos = gDao.buscaMedicos(nome);
			atendentes = gDao.listaAtendentes();
		}
		
		model.addAttribute("atendente", atendentes);
		model.addAttribute("medico", medicos);
		
		return new ModelAndView("gestorProfi");
	}
}
