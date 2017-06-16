/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.ipDaoImp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.ip.Paciente;
import mvc.controlador.entidades.ip.Parroquia;
import mvc.modelo.ipDao.PacienteDao;
import test.list_count;

/**
 *
 * @author kebryan
 */
public class PacienteDaoImp implements PacienteDao {

    C_BD conn;

    @Override
    public List<Paciente> list() {
        this.conn = con_db.open(con_db.MSSQL_IP);
        List<Paciente> list = new ArrayList<>();
        ResultSet rs = this.conn.query("select top 10 * from paciente inner join BD_SM.dbo.historialClinico on idPaciente = paciente.id where estado = '1'");
        try {
            while (rs.next()) {
                Paciente value = new Paciente();
                value.setCedula(rs.getNString("cedula"));
                value.setNombre1(rs.getNString("nombre1"));
                value.setNombre2(rs.getNString("nombre2"));
                value.setApellido1(rs.getNString("apellido1"));
                value.setApellido2(rs.getNString("apellido2"));
                value.setCiudad(rs.getNString("ciudad"));
                value.setDiscapacidad(rs.getInt("discapacidad"));
                value.setDomicilio(rs.getNString("domicilio"));
                value.setEmail(rs.getNString("email"));
                value.setEstadoCivil(rs.getString("estadoCivil"));
                value.setEtnia(rs.getInt("etnia"));
                value.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                value.setId(rs.getInt("id"));
                value.setIdParroquia(new Parroquia(rs.getInt("idParroquia")));
                value.setImagen(rs.getNString("imagen"));
                value.setLugarNacimiento(rs.getNString("lugarNacimiento"));
                value.setNacionalidad(rs.getString("nacionalidad"));
                value.setPaisNacimiento(rs.getNString("paisNacimiento"));
                value.setSexo(rs.getBoolean("sexo"));
                value.setTelefonoDomicilio(rs.getNString("telefonoDomicilio"));
                value.setTelefonoOficina(rs.getNString("telefonoOficina"));
                value.setNombreContacto(rs.getNString("nombreContacto"));
                value.setMovilContacto(rs.getNString("movilContacto"));
                value.setParentezco(rs.getNString("parentezco"));
                list.add(value);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return list;
    }

    @Override
    public Paciente edit(int id) {
        this.conn = con_db.open(con_db.MSSQL_IP);
        ResultSet rs = this.conn.query("select * from paciente where id = '" + id + "'");
        Paciente value = new Paciente();
        try {
            while (rs.next()) {
                value.setCedula(rs.getNString("cedula"));
                value.setNombre1(rs.getNString("nombre1"));
                value.setNombre2(rs.getNString("nombre2"));
                value.setApellido1(rs.getNString("apellido1"));
                value.setApellido2(rs.getNString("apellido2"));
                value.setCiudad(rs.getNString("ciudad"));
                value.setDiscapacidad(rs.getInt("discapacidad"));
                value.setDomicilio(rs.getNString("domicilio"));
                value.setEmail(rs.getNString("email"));
                value.setEstadoCivil(rs.getString("estadoCivil"));
                value.setEtnia(rs.getInt("etnia"));
                value.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                value.setId(rs.getInt("id"));
                value.setIdParroquia(new Parroquia(rs.getInt("idParroquia")));
                value.setImagen(rs.getNString("imagen"));
                value.setLugarNacimiento(rs.getNString("lugarNacimiento"));
                value.setNacionalidad(rs.getString("nacionalidad"));
                value.setPaisNacimiento(rs.getNString("paisNacimiento"));
                value.setSexo(rs.getBoolean("sexo"));
                value.setTelefonoDomicilio(rs.getNString("telefonoDomicilio"));
                value.setTelefonoOficina(rs.getNString("telefonoOficina"));
                value.setNombreContacto(rs.getNString("nombreContacto"));
                value.setMovilContacto(rs.getString("movilContacto"));
                value.setParentezco(rs.getString("parentezco"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return value;
    }

    @Override
    public boolean save(Paciente value) {
        this.conn = con_db.open(con_db.MSSQL_IP);
        String sql = "";
        try {
            if (value.getId() == 0) {
                sql = "INSERT INTO [dbo].[paciente]([cedula],[nombre1],[nombre2],[apellido1],[apellido2],[domicilio],[nacionalidad],[ciudad],[estadoCivil],[telefonoDomicilio],[telefonoOficina],[email],[sexo],[paisNacimiento],[lugarNacimiento],[fechaNacimiento],[etnia],[discapacidad],[idParroquia],[imagen],[nombreContacto],[movilContacto],[parentezco])\n"
                        + "     VALUES\n"
                        + "           ('" + value.getCedula() + "'\n"
                        + "           ,'" + value.getNombre1() + "'\n"
                        + "           ,'" + value.getNombre2() + "'\n"
                        + "           ,'" + value.getApellido1() + "'\n"
                        + "           ,'" + value.getApellido2() + "'\n"
                        + "           ,'" + value.getDomicilio() + "'\n"
                        + "           ,'" + value.getNacionalidad() + "'\n"
                        + "           ,'" + value.getCiudad() + "'\n"
                        + "           ,'" + value.getEstadoCivil() + "'\n"
                        + "           ,'" + value.getTelefonoDomicilio() + "'\n"
                        + "           ,'" + value.getTelefonoOficina() + "'\n"
                        + "           ,'" + value.getEmail() + "'\n"
                        + "           ,'" + test.test.getSexo(value.getSexo()) + "'\n"
                        + "           ,'" + value.getPaisNacimiento() + "'\n"
                        + "           ,'" + value.getLugarNacimiento() + "'\n"
                        + "           ,'" + test.test.SQLSave(value.getFechaNacimiento()) + "'\n"
                        + "           ,'" + value.getEtnia() + "'\n"
                        + "           ,'" + value.getDiscapacidad() + "'\n"
                        + "           ,'" + value.getIdParroquia().getId() + "'\n"
                        + "           ,'" + value.getImagen() + "'\n"
                        + "           ,'" + value.getNombreContacto() + "'\n"
                        + "           ,'" + value.getMovilContacto() + "'\n"
                        + "           ,'" + value.getParentezco() + "')";
            } else {
                sql = "UPDATE [dbo].[paciente]\n"
                        + "   SET [cedula] = '" + value.getCedula() + "'\n"
                        + "      ,[nombre1] = '" + value.getNombre1() + "'\n"
                        + "      ,[nombre2] = '" + value.getNombre2() + "'\n"
                        + "      ,[apellido1] = '" + value.getApellido1() + "'\n"
                        + "      ,[apellido2] = '" + value.getApellido2() + "'\n"
                        + "      ,[domicilio] = '" + value.getDomicilio() + "'\n"
                        + "      ,[nacionalidad] = '" + value.getNacionalidad() + "'\n"
                        + "      ,[ciudad] = '" + value.getCiudad() + "'\n"
                        + "      ,[estadoCivil] = '" + value.getEstadoCivil() + "'\n"
                        + "      ,[telefonoDomicilio] = '" + value.getTelefonoDomicilio() + "'\n"
                        + "      ,[telefonoOficina] = '" + value.getTelefonoOficina() + "'\n"
                        + "      ,[email] = '" + value.getEmail() + "'\n"
                        + "      ,[sexo] = '" + test.test.getSexo(value.getSexo()) + "'\n"
                        + "      ,[paisNacimiento] = '" + value.getPaisNacimiento() + "'\n"
                        + "      ,[lugarNacimiento] = '" + value.getLugarNacimiento() + "'\n"
                        + "      ,[fechaNacimiento] = '" + test.test.SQLSave(value.getFechaNacimiento()) + "'\n"
                        + "      ,[etnia] = '" + value.getEtnia() + "'\n"
                        + "      ,[discapacidad] = '" + value.getDiscapacidad() + "'\n"
                        + "      ,[idParroquia] = '" + value.getIdParroquia().getId() + "'\n"
                        + "      ,[imagen] = '" + value.getImagen() + "'\n"
                        + "      ,[nombreContacto] = '" + value.getNombreContacto() + "'\n"
                        + "      ,[movilContacto] = '" + value.getMovilContacto() + "'\n"
                        + "      ,[parentezco] = '" + value.getParentezco() + "'\n"
                        + " WHERE id = '" + value.getId() + "'";
            }
            conn.execute(sql);
            System.out.println(sql);
            return true;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return false;
        } finally {
            this.conn.close();
        }
    }

    @Override
    public boolean delete(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Paciente> list_Filter(String filter, int pag, int top) {
        this.conn = con_db.open(con_db.MSSQL_IP);
        List<Paciente> list = new ArrayList<>();
        String paginacion = (top != -1) ? "OFFSET " + pag + " ROWS FETCH NEXT " + top + " ROWS ONLY;" : "";
        String sql = ("select historialClinico.id as historia , paciente.* from paciente inner join BD_SM.dbo.historialClinico on idPaciente = paciente.id where estado = '1' and (nombre1 like '%" + filter + "%' or nombre2 like '%" + filter + "%' or apellido1 like '%" + filter + "%' or apellido2 like '%" + filter + "%' or cedula like '%" + filter + "%' or historialClinico.id like '%" + filter + "%') order by id " + paginacion);
        //String sql = "EXEC [dbo].[getPacientes] "+ top +", "+ pag +", '"+filter+"'";
        System.out.println(sql);
        ResultSet rs = this.conn.query(sql); //this.conn.query(sql);
        try {
            while (rs.next()) {
                Paciente value = new Paciente();
                value.setId(rs.getInt("id"));
                value.setHistoriaClinica(rs.getInt("historia"));
                value.setCedula(rs.getNString("cedula"));
                value.setNombre1(rs.getNString("nombre1"));
                value.setNombre2(rs.getNString("nombre2"));
                value.setApellido1(rs.getNString("apellido1"));
                value.setApellido2(rs.getNString("apellido2"));
                value.setCiudad(rs.getNString("ciudad"));
                value.setDomicilio(rs.getNString("domicilio"));
                value.setSexo(rs.getBoolean("sexo"));
                /*value.setDiscapacidad(rs.getInt("discapacidad"));
                value.setEmail(rs.getNString("email"));
                value.setEstadoCivil(rs.getString("estadoCivil"));
                value.setEtnia(rs.getInt("etnia"));
                value.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                value.setIdParroquia(new Parroquia(rs.getInt("idParroquia")));
                value.setImagen(rs.getNString("imagen"));
                value.setLugarNacimiento(rs.getNString("lugarNacimiento"));
                value.setNacionalidad(rs.getString("nacionalidad"));
                value.setPaisNacimiento(rs.getNString("paisNacimiento"));
                value.setTelefonoDomicilio(rs.getNString("telefonoDomicilio"));
                value.setTelefonoOficina(rs.getNString("telefonoOficina"));
                value.setNombreContacto(rs.getNString("nombreContacto"));
                value.setMovilContacto(rs.getNString("movilContacto"));
                value.setParentezco(rs.getNString("parentezco"));*/
                list.add(value);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return list;
    }

    @Override
    public list_count list_count_Filter(String value, int pag, int top) {
        this.conn = con_db.open(con_db.MSSQL_IP);
        list_count l = new list_count();
        List<Paciente> list = new ArrayList<>();
        String sql = "EXEC [dbo].[getPacientes] "+ top +", "+ pag +", '"+value+"'";
        System.out.println(sql);
        ResultSet rs = this.conn.query(sql); //this.conn.query(sql);
        try {
            while (rs.next()) {
                l.setTotal(rs.getInt("registros"));
                Paciente paciente1 = new Paciente();
                paciente1.setId(rs.getInt("id"));
                paciente1.setHistoriaClinica(rs.getInt("historia"));
                paciente1.setCedula(rs.getNString("cedula"));
                paciente1.setNombre1(rs.getNString("nombre1"));
                paciente1.setNombre2(rs.getNString("nombre2"));
                paciente1.setApellido1(rs.getNString("apellido1"));
                paciente1.setApellido2(rs.getNString("apellido2"));
                paciente1.setCiudad(rs.getNString("ciudad"));
                paciente1.setDomicilio(rs.getNString("domicilio"));
                paciente1.setSexo(rs.getBoolean("sexo"));
                list.add(paciente1);
            }
            l.setList(list);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return l;
    }

    @Override
    public Paciente edit_HC(int hc) {
        this.conn = con_db.open(con_db.MSSQL_IP);
        ResultSet rs = this.conn.query("select p.* from BD_IP.dbo.paciente p\n" +
                "inner join BD_SM.dbo.historialClinico hc on hc.idPaciente = p.id\n" +
                "where hc.id = '"+ hc +"'");
        Paciente value = new Paciente();
        try {
            while (rs.next()) {
                value.setCedula(rs.getNString("cedula"));
                value.setNombre1(rs.getNString("nombre1"));
                value.setNombre2(rs.getNString("nombre2"));
                value.setApellido1(rs.getNString("apellido1"));
                value.setApellido2(rs.getNString("apellido2"));
                value.setCiudad(rs.getNString("ciudad"));
                value.setDiscapacidad(rs.getInt("discapacidad"));
                value.setDomicilio(rs.getNString("domicilio"));
                value.setEmail(rs.getNString("email"));
                value.setEstadoCivil(rs.getString("estadoCivil"));
                value.setEtnia(rs.getInt("etnia"));
                value.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                value.setId(rs.getInt("id"));
                value.setIdParroquia(new Parroquia(rs.getInt("idParroquia")));
                value.setImagen(rs.getNString("imagen"));
                value.setLugarNacimiento(rs.getNString("lugarNacimiento"));
                value.setNacionalidad(rs.getString("nacionalidad"));
                value.setPaisNacimiento(rs.getNString("paisNacimiento"));
                value.setSexo(rs.getBoolean("sexo"));
                value.setTelefonoDomicilio(rs.getNString("telefonoDomicilio"));
                value.setTelefonoOficina(rs.getNString("telefonoOficina"));
                value.setNombreContacto(rs.getNString("nombreContacto"));
                value.setMovilContacto(rs.getString("movilContacto"));
                value.setParentezco(rs.getString("parentezco"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return value;
    }

}
