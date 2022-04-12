package br.ufac.sgcm.controller;

import java.sql.SQLException;
import java.util.List;

import br.ufac.sgcm.dao.AtendimentoDao;
import br.ufac.sgcm.model.Atendimento1;

public class AtendimentoController implements IController<Atendimento1>  {

    private AtendimentoDao dao;

    public AtendimentoController() throws ClassNotFoundException, SQLException {
        dao = new AtendimentoDao();
    }

    public List<Atendimento1> getAll() throws SQLException {
        return dao.getAll();
    }

    public Atendimento1 getById(Long id) throws SQLException {
        return dao.getById(id);
    }

    public List<Atendimento1> getByAll(String termoBusca) throws SQLException {
        return dao.getByAll(termoBusca);
    }

    public int save(Atendimento1 item) throws SQLException {
        int registrosAfetados = 0;
        if (item.getId() == null) {
            registrosAfetados = dao.insert(item);
        } else {
            registrosAfetados = dao.update(item);
        }
        return registrosAfetados;
    }

    public int delete(Long id) throws SQLException {
        return dao.delete(id);
    }

}
