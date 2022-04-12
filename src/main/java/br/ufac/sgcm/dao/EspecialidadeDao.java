package br.ufac.sgcm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufac.sgcm.model.Especialidade;

public class EspecialidadeDao implements IDao<Especialidade> {

    private Connection conexao;
    private PreparedStatement ps;
    private ResultSet rs;

    public EspecialidadeDao() {
        conexao = ConexaoDB.getConexao();
    }

    @Override
    public List<Especialidade> getAll() {
        List<Especialidade> listaRegistros = new ArrayList<>();
        String sql = "SELECT * FROM especialidade";
        try {
            ps = conexao.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Especialidade registro = new Especialidade();
                registro.setId(rs.getLong("id"));
                registro.setNome(rs.getString("nome"));
                listaRegistros.add(registro);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaRegistros;
    }

    @Override
    public Especialidade getById(Long id) {
        Especialidade registro = new Especialidade();
        String sql = "SELECT * FROM especialidade WHERE id = ?";
        try {
            ps = conexao.prepareStatement(sql);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                registro.setId(rs.getLong("id"));
                registro.setNome(rs.getString("nome"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registro;
    }

    @Override
    public List<Especialidade> getByAll(String termoBusca) throws SQLException {
        List<Especialidade> registros = new ArrayList<>();
        String sql = "SELECT * FROM especialidade WHERE nome LIKE ?";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, "%" + termoBusca + "%");
        rs = ps.executeQuery();
        while(rs.next()) {
            Especialidade registro = new Especialidade();
            registro.setId(rs.getLong("id"));
            registro.setNome(rs.getString("nome"));;
            registros.add(registro);
        }
        return registros;
    }

    @Override
    public int insert(Especialidade objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "INSERT INTO especialidade" +
        " (nome)" + "VALUES (?)";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getNome());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int update(Especialidade objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "UPDATE especialidade SET" +
        " nome = ?" +
        " WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getNome());
        ps.setLong(2, objeto.getId());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int delete(Long id) throws SQLException {
        int registrosAfetados = 0;
        String sql = "DELETE FROM especialidade WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setLong(1, id);
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }
    
}
