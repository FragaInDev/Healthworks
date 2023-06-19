package com.les.healthworks.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.les.healthworks.model.Consulta;
import com.les.healthworks.model.Paciente;

@Repository
public class ConsultaDAO implements IConsultaDAO {
	
	@Autowired
	GenericDAO gDao;

	@Override
	public List<Consulta> consultasMedico(String email) throws SQLException, ClassNotFoundException {
		List<Consulta> consulta = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT cod, data, hora, paciente FROM fn_listarconsultasmedico(?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Consulta co = new Consulta();
			co.setCod(rs.getInt("cod"));
			co.setData(rs.getString("data"));
			co.setHora(rs.getString("hora"));;
			co.setPaciente(rs.getString("paciente"));
			
			consulta.add(co);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return consulta;
	}
	
	@Override
	public List<Consulta> pesquisaConsultasMedico(String email, String busca) throws SQLException, ClassNotFoundException {
		List<Consulta> consulta = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT cod, data, hora, paciente FROM fn_listarconsultasmedico(?) WHERE paciente LIKE ? OR data = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, email);
		ps.setString(2, busca);
		ps.setString(3, busca);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Consulta co = new Consulta();
			co.setCod(rs.getInt("cod"));
			co.setData(rs.getString("data"));
			co.setHora(rs.getString("hora"));;
			co.setPaciente(rs.getString("paciente"));
			
			consulta.add(co);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return consulta;
	}
	
	@Override
	public Paciente infoPaciente(int consulta) throws SQLException, ClassNotFoundException {
		Paciente p = new Paciente();
		Connection c = gDao.getConnection();
		String sql = "SELECT nome, dataNasc, genero, altura, peso, tipoSangue FROM fn_info(?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, consulta);
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()) {
			p.setNome(rs.getString("nome"));
			p.setDataNasc(rs.getDate("dataNasc"));
			p.setGenero(rs.getString("genero"));
			p.setAltura(rs.getInt("altura"));
			p.setPeso(rs.getDouble("peso"));
			p.setTipoSanguineo(rs.getString("tipoSangue"));;
		}
		
		return p;
	}

	@Override
	public List<Consulta> consultasPaciente(String email) throws SQLException, ClassNotFoundException {
		List<Consulta> consulta = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT data, hora, medico, especialidade FROM fn_pacientelistaconsultas(?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Consulta co = new Consulta();
			co.setData(rs.getString("data"));
			co.setHora(rs.getString("hora"));;
			co.setMedico(rs.getString("medico"));
			co.setEspecialidadeByNome(rs.getString("especialidade"));
			
			consulta.add(co);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return consulta;
	}

	@Override
	public List<Consulta> pesquisaConsultasPaciente(String email, String busca) throws SQLException, ClassNotFoundException{
		List<Consulta> consulta = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT data, hora, medico, especialidade FROM fn_pacientelistaconsultas(?) WHERE medico LIKE ? OR data = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, email);
		ps.setString(2, busca);
		ps.setString(3, busca);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Consulta co = new Consulta();
			co.setData(rs.getString("data"));
			co.setHora(rs.getString("hora"));;
			co.setMedico(rs.getString("medico"));
			co.setEspecialidadeByNome(rs.getString("especialidade"));
			
			consulta.add(co);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return consulta;
	}
	
}
