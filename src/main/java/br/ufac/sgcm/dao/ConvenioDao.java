package br.ufac.sgcm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufac.sgcm.model.Atendimento;

public class ConvenioDao implements IDao<Atendimento> {

    private Connection conexao;
    private PreparedStatement ps;
    private ResultSet rs;

    public ConvenioDao() throws ClassNotFoundException, SQLException {
        conexao = ConexaoDB.getConexao();
        System.out.println(conexao);
    }

    @Override
    public List<Atendimento> getAll() throws SQLException {
        List<Atendimento> registros = new ArrayList<>();
        String sql = "SELECT * FROM convenio";
            ps = conexao.prepareStatement(sql);
            rs = ps.executeQuery();
        while (rs.next()) {
            Atendimento registro = new Atendimento();
            registro.setId(rs.getLong("id"));
            registro.setNome(rs.getString("nome"));
            registro.setRazaoSocial(rs.getString("razao_social"));
            registro.setCnpj(rs.getString("cnpj"));
            registro.setRepresentante(rs.getString("representante"));
            registro.setEmail(rs.getString("email"));
            registro.setTelefone(rs.getString("telefone"));
            registro.setAtivo(rs.getBoolean("ativo"));
            registros.add(registro);
        }
        return registros;
    }

    @Override
    public Atendimento getById(Long id) throws SQLException {
        Atendimento registro = new Atendimento();
        String sql = "SELECT * FROM convenio WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setLong(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            registro.setId(rs.getLong("id"));
            registro.setNome(rs.getString("nome"));
            registro.setRazaoSocial(rs.getString("razao_social"));
            registro.setCnpj(rs.getString("cnpj"));
            registro.setRepresentante(rs.getString("representante"));
            registro.setEmail(rs.getString("email"));
            registro.setTelefone(rs.getString("telefone"));
            registro.setAtivo(rs.getBoolean("ativo"));
        }
        return registro;
    }

    @Override
    public List<Atendimento> getByAll(String termoBusca) throws SQLException {
        List<Atendimento> registros = new ArrayList<>();
        String sql = "SELECT * FROM convenio WHERE nome LIKE ?"
            + " OR razao_social LIKE ?"
            + " OR cnpj LIKE ?"
            + " OR representante LIKE ?"
            + " OR email LIKE ?"
            + " OR telefone LIKE ?";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, "%" + termoBusca + "%");
        ps.setString(2, "%" + termoBusca + "%");
        ps.setString(3, "%" + termoBusca + "%");
        ps.setString(4, "%" + termoBusca + "%");
        ps.setString(5, "%" + termoBusca + "%");
        ps.setString(6, "%" + termoBusca + "%");
        rs = ps.executeQuery();
        while (rs.next()) {
            Atendimento registro = new Atendimento();
            registro.setId(rs.getLong("id"));
            registro.setNome(rs.getString("nome"));
            registro.setRazaoSocial(rs.getString("razao_social"));
            registro.setCnpj(rs.getString("cnpj"));
            registro.setRepresentante(rs.getString("representante"));
            registro.setEmail(rs.getString("email"));
            registro.setTelefone(rs.getString("telefone"));
            registro.setAtivo(rs.getBoolean("ativo"));
            registros.add(registro);
        }
        return registros;
    }

    @Override
    public int insert(Atendimento objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "INSERT INTO convenio"
            + " (nome, razao_social, cnpj, representante, email, telefone, ativo)"
            + " VALUES (?, ?, ?, ?, ?, ?, ?)";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getNome());
        ps.setString(2, objeto.getRazaoSocial());
        ps.setString(3, objeto.getCnpj());
        ps.setString(4, objeto.getRepresentante());
        ps.setString(5, objeto.getEmail());
        ps.setString(6, objeto.getTelefone());
        ps.setBoolean(7, objeto.isAtivo());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int update(Atendimento objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "UPDATE convenio SET"
            + " nome = ?,"
            + " razao_social = ?,"
            + " cnpj = ?,"
            + " representante = ?,"
            + " email = ?,"
            + " telefone = ?,"
            + " ativo = ?"
            + " WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getNome());
        ps.setString(2, objeto.getRazaoSocial());
        ps.setString(3, objeto.getCnpj());
        ps.setString(4, objeto.getRepresentante());
        ps.setString(5, objeto.getEmail());
        ps.setString(6, objeto.getTelefone());
        ps.setBoolean(7, objeto.isAtivo());
        ps.setLong(8, objeto.getId());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int delete(Long id) throws SQLException {
        int registrosAfetados = 0;
        String sql = "DELETE FROM convenio WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setLong(1, id);
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }
    
}
