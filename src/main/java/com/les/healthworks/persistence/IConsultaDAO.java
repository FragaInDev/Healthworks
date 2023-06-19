package com.les.healthworks.persistence;

import java.sql.SQLException;
import java.util.List;

import com.les.healthworks.model.Consulta;
import com.les.healthworks.model.Paciente;

public interface IConsultaDAO {
	public List<Consulta> consultasMedico(String email) throws SQLException, ClassNotFoundException;
	public List<Consulta> pesquisaConsultasMedico(String email, String busca) throws SQLException, ClassNotFoundException;
	public Paciente infoPaciente(int consulta) throws SQLException, ClassNotFoundException;
	public List<Consulta> consultasPaciente(String email) throws SQLException, ClassNotFoundException;
	public List<Consulta> pesquisaConsultasPaciente(String email, String busca) throws SQLException, ClassNotFoundException;
}
