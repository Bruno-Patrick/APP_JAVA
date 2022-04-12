package br.ufac.sgcm.controller;

import java.sql.SQLException;
import java.util.List;

import br.ufac.sgcm.dao.EspecialidadeDao;
import br.ufac.sgcm.model.Especialidade;

public class EspecialidadeController implements IController<Especialidade> {

    private EspecialidadeDao dao;

    public EspecialidadeController() {
        dao = new EspecialidadeDao();
    }

    @Override
    public List<Especialidade> getAll() throws SQLException {
        // TODO Auto-generated method stub
        return dao.getAll();
    }

    @Override
    public Especialidade getById(Long id) throws SQLException {
        // TODO Auto-generated method stub
        return dao.getById(id);
    }

    @Override
    public List<Especialidade> getByAll(String termoBusca) throws SQLException {
        return dao.getByAll(termoBusca);
    }
    
    @Override
    public int save(Especialidade objeto) throws SQLException {
        // TODO Auto-generated method stub
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
