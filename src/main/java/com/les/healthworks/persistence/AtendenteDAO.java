package com.les.healthworks.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.les.healthworks.model.Consulta;
import com.les.healthworks.model.Paciente;

@Repository
public class AtendenteDAO implements IAtendenteDAO{
	
	@Autowired
	GenericDAO gDao;
	
//----------------------------- [PACIENTE] ---------------------------------//
	private String manterPaciente(String op, Paciente paciente) throws ClassNotFoundException, SQLException{
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_manter_paciente(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, op);
		cs.setString(2, paciente.getCpf());
		cs.setString(3, paciente.getNome());
		cs.setString(4, paciente.getCartaoSUS());
		cs.setDate(5, paciente.getDataNasc());
		cs.setString(6, paciente.getEmail());
		cs.setString(7, paciente.getTelefone());
		cs.setString(8, paciente.getGenero());
		cs.setString(9, paciente.getTipoSanguineo());
		cs.setDouble(10, paciente.getPeso());
		cs.setInt(11, paciente.getAltura());
		cs.setString(12, paciente.getSenha());
		cs.registerOutParameter(13, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(13);
		
		cs.close();
		c.close();
		
		return saida;
		
	}

	@Override
	public String cadastraPaciente(Paciente p) throws SQLException, ClassNotFoundException {
		String saida = manterPaciente("I", p);
		return saida;
	}

	@Override
	public String editaPaciente(Paciente p) throws SQLException, ClassNotFoundException {
		String saida = manterPaciente("U", p);
		return saida;
	}

	@Override
	public String excluiPaciente(Paciente p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_manter_paciente(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "D");
		cs.setString(2, p.getCpf());
		cs.setNull(3, Types.VARCHAR);
		cs.setNull(4, Types.INTEGER);
		cs.setNull(5, Types.DATE);
		cs.setString(6, p.getEmail());
		cs.setNull(7, Types.VARCHAR);
		cs.setNull(8, Types.VARCHAR);
		cs.setNull(9, Types.VARCHAR);
		cs.setNull(10, Types.DOUBLE);
		cs.setNull(11, Types.DOUBLE);
		cs.setNull(12, Types.VARCHAR);
		cs.registerOutParameter(13, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(13);
		
		cs.close();
		c.close();
		
		return saida;
	}

	@Override
	public Paciente pesquisaPaciente(Paciente p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT cpf, nome, cartaoSus, dataNasc, email, telefone, genero, tipoSangue, peso, altura FROM fn_pesquisarpaciente(?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, p.getCpf());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			p.setNome(rs.getString("nome"));
			p.setCartaoSUS(rs.getString("cartaoSUS"));
			p.setDataNasc(rs.getDate("dataNasc"));
			p.setEmail(rs.getString("email"));
			p.setTelefone(rs.getString("telefone"));
			p.setGenero(rs.getString("genero"));
			p.setTipoSanguineo(rs.getString("tipoSangue"));
			p.setPeso(rs.getDouble("peso"));
			p.setAltura(rs.getInt("altura"));
		}
		rs.close();
		ps.close();
		c.close();
		return p;
	}

	@Override
	public List<Paciente> listaPacientes() throws SQLException, ClassNotFoundException {
		List<Paciente> paciente = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT cpf, nome, cartaoSus, dataNasc, email, telefone, genero, tipoSangue, peso, altura FROM fn_listarpaciente()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Paciente p = new Paciente();
			p.setCpf(rs.getString("cpf"));
			p.setNome(rs.getString("nome"));
			p.setCartaoSUS(rs.getString("cartaoSUS"));
			p.setDataNasc(rs.getDate("dataNasc"));
			p.setEmail(rs.getString("email"));
			p.setTelefone(rs.getString("telefone"));
			p.setGenero(rs.getString("genero"));
			p.setTipoSanguineo(rs.getString("tipoSangue"));
			p.setPeso(rs.getDouble("peso"));
			p.setAltura(rs.getInt("altura"));
			
			paciente.add(p);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return paciente;
	}
	
	@Override
	public List<Paciente> buscaPacientes(String nome) throws SQLException, ClassNotFoundException {
		List<Paciente> paciente = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT cpf, nome, cartao_sus, dataNasc, email, telefone, genero, tipoSangue, peso, altura FROM Paciente WHERE nome LIKE ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Paciente p = new Paciente();
			p.setCpf(rs.getString("cpf"));
			p.setNome(rs.getString("nome"));
			p.setCartaoSUS(rs.getString("cartao_sus"));
			p.setDataNasc(rs.getDate("dataNasc"));
			p.setEmail(rs.getString("email"));
			p.setTelefone(rs.getString("telefone"));
			p.setGenero(rs.getString("genero"));
			p.setTipoSanguineo(rs.getString("tipoSangue"));
			p.setPeso(rs.getDouble("peso"));
			p.setAltura(rs.getInt("altura"));
			
			paciente.add(p);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return paciente;
	}
	

//----------------------------- [CONSULTA] ---------------------------------//
	
	private String manterConsulta(String op, Consulta consulta) throws ClassNotFoundException, SQLException{
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_manter_consulta(?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, op);
		cs.setInt(2, consulta.getCod());
		cs.setInt(3, consulta.getEspecialidadeCodigo());
		cs.setString(4, consulta.getMedico());
		cs.setString(5, consulta.getPaciente());
		cs.setString(6, consulta.getData());
		cs.setString(7, consulta.getHora());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(8);
		
		cs.close();
		c.close();
		
		return saida;
		
	}

	@Override
	public String cadastraConsulta(Consulta co) throws SQLException, ClassNotFoundException {
		String saida = manterConsulta("I", co);
		return saida;
	}

	@Override
	public String editaConsulta(Consulta co) throws SQLException, ClassNotFoundException {
		String saida = manterConsulta("U", co);
		return saida;
	}

	@Override
	public String excluiConsulta(Consulta co) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_manter_consulta(?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "D");
		cs.setInt(2, co.getCod());
		cs.setNull(3, Types.INTEGER);
		cs.setNull(4, Types.INTEGER);
		cs.setNull(5, Types.VARCHAR);
		cs.setNull(6, Types.VARCHAR);
		cs.setNull(7, Types.VARCHAR);
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(8);
		
		cs.close();
		c.close();
		
		return saida;
	}

	@Override
	public Consulta pesquisaConsulta(Consulta co) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT data, hora, cpf, crm, especialidade FROM Consulta WHERE codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, co.getCod());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			co.setData(rs.getString("data"));
			co.setHora(rs.getString("hora"));
			co.setPaciente(rs.getString("cpf"));
			co.setMedico(rs.getString("crm"));
		}
		rs.close();
		ps.close();
		c.close();
		return co;
	}

	@Override
	public List<Consulta> listaConsultas() throws SQLException, ClassNotFoundException {
		List<Consulta> consulta = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, data, hora, paciente, medico, especialidade FROM fn_listarconsultas()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Consulta co = new Consulta();
			
			co.setCod(rs.getInt("codigo"));
			co.setData(rs.getString("data"));
			co.setHora(rs.getString("hora"));;
			co.setPaciente(rs.getString("paciente"));
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
	public List<Consulta> buscaConsultas(String busca) throws SQLException, ClassNotFoundException {
		List<Consulta> consulta = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, data, hora, paciente, medico, especialidade FROM fn_buscaconsultas(?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, busca);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Consulta co = new Consulta();
			co.setCod(rs.getInt("codigo"));
			co.setData(rs.getString("data"));
			co.setHora(rs.getString("hora"));
			co.setPaciente(rs.getString("paciente"));
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
