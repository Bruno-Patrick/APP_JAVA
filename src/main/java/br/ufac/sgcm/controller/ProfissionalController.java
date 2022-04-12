package br.ufac.sgcm.controller;

import java.sql.SQLException;
import java.util.List;

import br.ufac.sgcm.dao.ProfissionalDao;
import br.ufac.sgcm.model.Especialidade;
import br.ufac.sgcm.model.Profissional;
import br.ufac.sgcm.model.Unidade;

public class ProfissionalController implements IController<Profissional> {

    private ProfissionalDao dao;
    private EspecialidadeController especialidadeController;
    private UnidadeController unidadeController;

    public ProfissionalController() {
        dao = new ProfissionalDao();
        especialidadeController = new EspecialidadeController();
        unidadeController = new UnidadeController();
    }

    @Override
    public List<Profissional> getAll() throws SQLException {
        return dao.getAll();
    }

    @Override
    public Profissional getById(Long id) throws SQLException {
        return dao.getById(id);
    }

    @Override
    public List<Profissional> getByAll(String termoBusca) throws SQLException {
        return dao.getByAll(termoBusca);
    }

    @Override
    public int save(Profissional objeto) throws SQLException {
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

    public List<Especialidade> getEspecialidades() throws SQLException {
        return especialidadeController.getAll();
    }

    public Especialidade getEspecialidade(Long id) throws SQLException {
        return especialidadeController.getById(id);
    }

    public List<Unidade> getUnidades() throws SQLException {
        return unidadeController.getAll();
    }

    public Unidade getUnidade(Long id) throws SQLException {
        return unidadeController.getById(id);
    }
    
}
