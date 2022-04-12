package br.ufac.sgcm.controller;

import java.sql.SQLException;
import java.util.List;

import br.ufac.sgcm.dao.UnidadeDao;
import br.ufac.sgcm.model.Unidade;

public class UnidadeController implements IController<Unidade> {

    private UnidadeDao dao;

    public UnidadeController() {
        dao = new UnidadeDao();
    }

    @Override
    public List<Unidade> getAll() throws SQLException {
        return dao.getAll();
    }

    @Override
    public Unidade getById(Long id) throws SQLException {
        return dao.getById(id);
    }

    @Override
    public List<Unidade> getByAll(String termoBusca) throws SQLException {
        return dao.getByAll(termoBusca);
    } 

    @Override
    public int save(Unidade objeto) throws SQLException {
        int registrosAfetados = 0;

        if (objeto.getId() == null) {
            registrosAfetados = dao.insert(objeto);
        } else {
            registrosAfetados = dao.update(objeto);
        }

        return registrosAfetados;
    }

    @Override
    public int delete(Long id) throws SQLException {
        return dao.delete(id);
    }
    
}
