package br.ufac.sgcm.controller;

import java.sql.SQLException;
import java.util.List;

import br.ufac.sgcm.dao.PacienteDao;
import br.ufac.sgcm.model.Paciente;

public class PacienteController implements IController<Paciente> {
    
    private PacienteDao dao;

    public PacienteController() {
        dao = new PacienteDao();
    }

    @Override
    public List<Paciente> getAll() {
        return dao.getAll();
    }

    @Override
    public Paciente getById(Long id) {
        return dao.getById(id);
    }

    @Override
    public List<Paciente> getByAll(String termoBusca) throws SQLException {
        return dao.getByAll(termoBusca);
    }

    public int save(Paciente objeto) throws SQLException {
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