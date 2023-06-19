package com.les.healthworks.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Medico extends Pessoa{

	private String crm;
	private int cargo;
	private Especialidade especialidade;
	
	public void setEspecialidadeByCodigo(int codigo) {
        this.especialidade = new Especialidade(codigo, null);
    }

    public void setEspecialidadeByNome(String nome) {
        this.especialidade = new Especialidade(0, nome);
    }
    
    public int getEspecialidadeCodigo() {
        return especialidade != null ? especialidade.getCodigo() : 0;
    }

    public String getEspecialidadeNome() {
        return especialidade != null ? especialidade.getNome() : null;
    }
}
