package com.les.healthworks.model;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class Especialidade{

	private int codigo;
	private String nome;
	
	public Especialidade(int codigo, String nome) {
		this.codigo = codigo;
        this.nome = nome;
	}
	
	public String toString() {
		return nome;
	}
}
