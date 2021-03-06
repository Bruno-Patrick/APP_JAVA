package br.ufac.sgcm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufac.sgcm.model.Profissional;

public class ProfissionalDao implements IDao<Profissional> {

    private Connection conexao;
    private PreparedStatement ps;
    private ResultSet rs;
    private EspecialidadeDao especialidadeDao;
    private UnidadeDao unidadeDao;

    public ProfissionalDao() {
        conexao = ConexaoDB.getConexao();
        especialidadeDao = new EspecialidadeDao();
        unidadeDao = new UnidadeDao();
    }

    @Override
    public List<Profissional> getAll() throws SQLException {
        List<Profissional> listaRegistros = new ArrayList<>();
        String sql = "SELECT * FROM profissional";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) {
            Profissional registro = new Profissional();
            registro.setId(rs.getLong("id"));
            registro.setNome(rs.getString("nome"));
            registro.setRegistroConselho(rs.getString("registro_conselho"));
            registro.setEspecialidade(especialidadeDao.getById(rs.getLong("especialidade_id")));
            registro.setUnidade(unidadeDao.getById(rs.getLong("unidade_id")));
            registro.setEmail(rs.getString("email"));
            registro.setTelefone(rs.getString("telefone"));
            listaRegistros.add(registro);
        }
        return listaRegistros;
    }

    @Override
    public Profissional getById(Long id) throws SQLException {
        Profissional registro = new Profissional();
        String sql = "SELECT * FROM profissional WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setLong(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            registro.setId(rs.getLong("id"));
            registro.setNome(rs.getString("nome"));
            registro.setRegistroConselho(rs.getString("registro_conselho"));
            registro.setEspecialidade(especialidadeDao.getById(rs.getLong("especialidade_id")));
            registro.setUnidade(unidadeDao.getById(rs.getLong("unidade_id")));
            registro.setEmail(rs.getString("email"));
            registro.setTelefone(rs.getString("telefone"));
        }
        return registro;
    }

    @Override
    public List<Profissional> getByAll(String termoBusca) throws SQLException {
        List<Profissional> listaRegistros = new ArrayList<>();
        String sql = "SELECT p.*, e.nome, u.nome FROM profissional p"
            + " LEFT JOIN especialidade e ON e.id = p.especialidade_id"
            + " LEFT JOIN unidade u ON u.id = p.unidade_id"
            + " WHERE p.nome LIKE ?"
            + " OR registro_conselho LIKE ?"
            + " OR e.nome LIKE ?"
            + " OR u.nome LIKE ?"
            + " OR telefone LIKE ?"
            + " OR email LIKE ?";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, "%" + termoBusca + "%");
        ps.setString(2, "%" + termoBusca + "%");
        ps.setString(3, "%" + termoBusca + "%");
        ps.setString(4, "%" + termoBusca + "%");
        ps.setString(5, "%" + termoBusca + "%");
        ps.setString(6, "%" + termoBusca + "%");
        rs = ps.executeQuery();
        while (rs.next()) {
            Profissional registro = new Profissional();
            registro.setId(rs.getLong("id"));
            registro.setNome(rs.getString("nome"));
            registro.setRegistroConselho(rs.getString("registro_conselho"));
            registro.setEspecialidade(especialidadeDao.getById(rs.getLong("especialidade_id")));
            registro.setUnidade(unidadeDao.getById(rs.getLong("unidade_id")));
            registro.setEmail(rs.getString("email"));
            registro.setTelefone(rs.getString("telefone"));
            listaRegistros.add(registro);
        }
        return listaRegistros;
    }

    @Override
    public int insert(Profissional objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "INSERT INTO profissional" +
            " (nome, registro_conselho, especialidade_id, unidade_id, telefone, email)" +
            " VALUES (?, ?, ?, ?, ?, ?)";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getNome());
        ps.setString(2, objeto.getRegistroConselho());
        ps.setLong(3, objeto.getEspecialidade().getId());
        ps.setLong(4, objeto.getUnidade().getId());
        ps.setString(5, objeto.getTelefone());
        ps.setString(6, objeto.getEmail());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int update(Profissional objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "UPDATE profissional SET" +
            " nome = ?," +
            " registro_conselho = ?," +
            " especialidade_id = ?," +
            " unidade_id = ?," +
            " telefone = ?," +
            " email = ?" +
            " WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getNome());
        ps.setString(2, objeto.getRegistroConselho());
        ps.setLong(3, objeto.getEspecialidade().getId());
        ps.setLong(4, objeto.getUnidade().getId());
        ps.setString(5, objeto.getTelefone());
        ps.setString(6, objeto.getEmail());
        ps.setLong(7, objeto.getId());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int delete(Long id) throws SQLException {
        int registrosAfetados = 0;
        String sql = "DELETE FROM profissional WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setLong(1, id);
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }
    
}
