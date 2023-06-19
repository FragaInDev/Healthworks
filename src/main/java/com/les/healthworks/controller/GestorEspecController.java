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

import com.les.healthworks.model.Especialidade;
import com.les.healthworks.persistence.GestorDAO;

@Controller
public class GestorEspecController {

	@Autowired
	GestorDAO gDao;
	
	@RequestMapping(name = "gestorEspec", value = "/gestorEspec", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model){
		List<Especialidade> especs = new ArrayList<>();
		
		try {
			especs = gDao.listaEspecialidades();
		}catch (SQLException | ClassNotFoundException e){
			e.getMessage();
		}finally {
			model.addAttribute("especialidade", especs);
		}
        return new ModelAndView("gestorEspec");
    }
	
	@RequestMapping(value = "/deleteEspec/{codigo}", method = RequestMethod.GET)
    public String deleteEspec(@PathVariable("codigo") int cod) throws ClassNotFoundException, SQLException {
		Especialidade e = new Especialidade(cod, null);
		//e.setCodigo(cod);
        gDao.excluiEspecialidade(e);
        return "redirect:/gestorEspec";
    }
	
	@RequestMapping(value = "/editEspec/{codigo}/{espec-nome}", method = RequestMethod.GET)
	public String showEditEspec(@PathVariable("codigo") String codigo, @PathVariable("espec-nome") String nome, ModelMap model) throws ClassNotFoundException, SQLException {
		Especialidade e = new Especialidade(Integer.parseInt(codigo), null);
		//e.setCodigo(Integer.parseInt(codigo));
		
		Especialidade espec = gDao.pesquisaEspec(e);
	    model.addAttribute("e", espec);
	    return "editEspec";
	}
	
	@RequestMapping(value = "/editEspec", method = RequestMethod.POST)
	public String updateEspec(ModelMap model, @RequestParam Map<String, String> params) throws ClassNotFoundException, SQLException {
		int codigo = Integer.parseInt(params.get("cod"));
		String nome = params.get("espec-nome");
		String botao = params.get("botao");
		
		if(botao.equalsIgnoreCase("salvar")) {
			Especialidade e = new Especialidade(codigo, nome);
			//e.setCodigo(codigo);
			//e.setNome(nome);
			gDao.editaEspecialidade(e);
		}
		
	    return "redirect:/gestorEspec";
	}
	
	@RequestMapping(name = "gestorEspec", value = "/gestorEspec", method = RequestMethod.POST)
	public ModelAndView especialidades(ModelMap model, @RequestParam Map<String, String> param) throws ClassNotFoundException, SQLException {
		String nome = param.get("espec-nome");
		String botao = param.get("botao");
		
		List<Especialidade> espec = new ArrayList<>();
		
		if(botao.equalsIgnoreCase("Adicionar")) {
			Especialidade e = new Especialidade(0, nome);
			
			//e.setNome(nome);
			
			gDao.cadastraEspecialidade(e);
			
			espec = gDao.listaEspecialidades();
		}
		
		model.addAttribute("especialidade", espec);
		
		return new ModelAndView("gestorEspec");
	}
}
