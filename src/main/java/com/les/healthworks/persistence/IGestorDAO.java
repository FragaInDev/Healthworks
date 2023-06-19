package com.les.healthworks.persistence;

import java.sql.SQLException;
import java.util.List;

import com.les.healthworks.model.Atendente;
import com.les.healthworks.model.Especialidade;
import com.les.healthworks.model.Medico;

public interface IGestorDAO {
	 public String cadastraAtendente(Atendente a) throws SQLException, ClassNotFoundException;
	 public String editaAtendente(Atendente a) throws SQLException, ClassNotFoundException;
	 public String excluiAtendente(Atendente a) throws SQLException, ClassNotFoundException;
	 public Atendente pesquisaAtendenteCpf(Atendente a) throws SQLException, ClassNotFoundException;
	 public List<Atendente> buscaAtendentes(String nome) throws SQLException, ClassNotFoundException;
	 public List<Atendente> listaAtendentes() throws SQLException, ClassNotFoundException;
	 
	 public String cadastraMedico(Medico m) throws SQLException, ClassNotFoundException;
	 public String editaMedico(Medico m) throws SQLException, ClassNotFoundException;
	 public String excluiMedico(Medico m) throws SQLException, ClassNotFoundException;
	 public Medico pesquisaMedico(Medico m) throws SQLException, ClassNotFoundException;
	 public List<Medico> buscaMedicos(String nome) throws SQLException, ClassNotFoundException;
	 public List<Medico>listaMedicos() throws SQLException, ClassNotFoundException;
	 
	 public Especialidade cadastraEspecialidade(Especialidade e) throws SQLException, ClassNotFoundException;
	 public String editaEspecialidade(Especialidade e) throws SQLException, ClassNotFoundException;
	 public String excluiEspecialidade(Especialidade e) throws SQLException, ClassNotFoundException;
	 public Especialidade pesquisaEspec(Especialidade e) throws SQLException, ClassNotFoundException;
	 public List<Especialidade> buscaEspecs(String nome) throws SQLException, ClassNotFoundException;
	 public List<Especialidade> listaEspecialidades() throws SQLException, ClassNotFoundException;
	 
	 
}
