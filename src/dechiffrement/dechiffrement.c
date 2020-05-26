#include <gmp.h>
#include <stdio.h>
#include "../structure/structure.h"
#include "../calcul/calcul.h"
#include "../chiffrement/gestion_block.h"
#include "oaep_1.h"
#include <stdlib.h>
#include "dechiffrement.h"


message* dechiffrement(message *c, cle_prive *prive) {

	// Initialisation
	message * m;
	block * b; 
	b = creer_block_oaep_1(c);
	for(int i = 0; i < (b->nb_block); i++) {
        int h=mpz_sizeinbase(b->tab[i],2);
	printf("la taille de merde crer %d \n",h);
    }
	// Code
	// RSA
	for (int i = 0; i < b->nb_block; i++) {
		mpz_powm(b->tab[i], b->tab[i], prive->d, prive->n);
		
	}
	
	// OAEP^(-1)
	oaep_1(b);
			
	m = recupere_message_oaep_1(b);
		for(int i = 0; i < (b->nb_block); i++) {
        int h=mpz_sizeinbase(b->tab[i],2);
	printf("la taille de crer-1  %d \n",h);
    }		
	for(int i = 0; i < (b->nb_block); i++) {
        mpz_clear(b->tab[i]);
    }
    free(b->tab);

	return m;
	

	
}
