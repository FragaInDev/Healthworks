package com.les.healthworks.persistence;

import java.sql.SQLException;
import java.util.List;

import com.les.healthworks.model.Consulta;
import com.les.healthworks.model.Paciente;

public interface IAtendenteDAO {
	public String cadastraPaciente(Paciente p) throws SQLException, ClassNotFoundException;
	public String editaPaciente(Paciente p) throws SQLException, ClassNotFoundException;
	public String excluiPaciente(Paciente p) throws SQLException, ClassNotFoundException;
	public Paciente pesquisaPaciente(Paciente p) throws SQLException, ClassNotFoundException;
	public List<Paciente> buscaPacientes(String nome) throws SQLException, ClassNotFoundException;
	public List<Paciente> listaPacientes() throws SQLException, ClassNotFoundException;
	 
	public String cadastraConsulta(Consulta co) throws SQLException, ClassNotFoundException;
	public String editaConsulta(Consulta co) throws SQLException, ClassNotFoundException;
	public String excluiConsulta(Consulta co) throws SQLException, ClassNotFoundException;
	public Consulta pesquisaConsulta(Consulta co) throws SQLException, ClassNotFoundException;
	public List<Consulta> buscaConsultas(String busca) throws SQLException, ClassNotFoundException;
	public List<Consulta> listaConsultas() throws SQLException, ClassNotFoundException;
}
