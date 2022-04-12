package br.ufac.sgcm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufac.sgcm.model.Atendimento1;

public class AtendimentoDao implements IDao<Atendimento1> {

    private Connection conexao;
    private PreparedStatement ps;
    private ResultSet rs;
    private EspecialidadeDao especialidadeDao;
    private PacienteDao pacienteDao;
    private ProfissionalDao profissionalDao;
    

    private UnidadeDao unidadeDao;

    public AtendimentoDao() {
        conexao = ConexaoDB.getConexao();
        especialidadeDao = new EspecialidadeDao();
        unidadeDao = new UnidadeDao();
    }

    @Override
    public List<Atendimento1> getAll() throws SQLException {
        List<Atendimento1> listaRegistros = new ArrayList<>();
        String sql = "SELECT * FROM atendimento";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) {
            Atendimento1 registro = new Atendimento1();
            registro.setId(rs.getLong("id"));
            registro.setData(rs.getString("data"));
            registro.setHora(rs.getString("hora"));
            registro.setStatus(rs.getString("status"));
            registro.setEspecialidade(especialidadeDao.getById(rs.getLong("convenio_id")));
            registro.setPaciente(pacienteDao.getById(rs.getLong("paciente_id")));
            registro.setProfissional(profissionalDao.getById(rs.getLong("profissional_id")));
            listaRegistros.add(registro);
        }
        return listaRegistros;
    }

    @Override
    public Atendimento1 getById(Long id) throws SQLException {
        Atendimento1 registro = new Atendimento1();
        String sql = "SELECT * FROM atendimento WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setLong(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            registro.setId(rs.getLong("id"));
            registro.setData(rs.getString("data"));
            registro.setHora(rs.getString("hora"));
            registro.setStatus(rs.getString("status"));
            registro.setEspecialidade(especialidadeDao.getById(rs.getLong("convenio_id")));
            registro.setPaciente(pacienteDao.getById(rs.getLong("paciente_id")));
            registro.setProfissional(profissionalDao.getById(rs.getLong("profissional_id")));
        }
        return registro;
    }

    //modificar o getByAll
    @Override
    public List<Atendimento1> getByAll(String termoBusca) throws SQLException {
        List<Atendimento1> listaRegistros = new ArrayList<>();
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
            Atendimento1 registro = new Atendimento1();
            registro.setId(rs.getLong("id"));
            registro.setData(rs.getString("data"));
            registro.setHora(rs.getString("hora"));
            registro.setStatus(rs.getString("status"));
            registro.setEspecialidade(especialidadeDao.getById(rs.getLong("convenio_id")));
            registro.setPaciente(pacienteDao.getById(rs.getLong("paciente_id")));
            registro.setProfissional(profissionalDao.getById(rs.getLong("profissional_id")));
            listaRegistros.add(registro);
        }
        return listaRegistros;
    }

    @Override
    public int insert(Atendimento1 objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "INSERT INTO profissional" +
            " (data, hora, status, convenio_id, paciente_id, profissional_id)" +
            " VALUES (?, ?, ?, ?, ?, ?)";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getData());
        ps.setString(2, objeto.getHora());
        ps.setString(2, objeto.getStatus());
        ps.setLong(3, objeto.getEspecialidade().getId());
        ps.setLong(4, objeto.getPaciente().getId());
        ps.setLong(4, objeto.getProfissional().getId());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int update(Atendimento1 objeto) throws SQLException {
        int registrosAfetados = 0;
        String sql = "UPDATE atendimento SET" +
            " data = ?," +
            " hora = ?," +
            " status = ?," +
            " convenio_id = ?," +
            " paciente_id = ?," +
            " profissional_id = ?" +
            " WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, objeto.getData());
        ps.setString(2, objeto.getHora());
        ps.setString(2, objeto.getStatus());
        ps.setLong(3, objeto.getEspecialidade().getId());
        ps.setLong(4, objeto.getPaciente().getId());
        ps.setLong(4, objeto.getProfissional().getId());
        ps.setLong(7, objeto.getId());
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    @Override
    public int delete(Long id) throws SQLException {
        int registrosAfetados = 0;
        String sql = "DELETE FROM atendimento WHERE id = ?";
        ps = conexao.prepareStatement(sql);
        ps.setLong(1, id);
        registrosAfetados = ps.executeUpdate();
        return registrosAfetados;
    }

    
}
