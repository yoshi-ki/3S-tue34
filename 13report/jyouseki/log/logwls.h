// (c) Michael Buro 1992-2002, licensed under the GNU Public License, version 2

#ifndef LOGWLS_H
#define LOGWLS_H

#include "logm.h"
#include "logmat.h"

int logitfit(
  MATRIX *pX,		/* Merkmalsauspr�gungen 	*/
  MATRIX *pn,		/* Beispielanzahl		*/
  MATRIX *py,		/* davon Anzahl in Klasse 1	*/
  MATRIX *pbeta,	/* gesch�tzter Parametervektor	*/
  REAL   *plogL,	/* -2 log L			*/
  MATRIX *pH,		/* gesch�tzte Kovarianzmatrix	*/
  int	 IterMax,	/* maximale Iterationsanzahl	*/
  REAL   EndRel		/* Abbruchfehler		*/
);


REAL	L(MATRIX *pX, MATRIX *py, MATRIX *pn, MATRIX *pbeta);

int Diskrim(
  MATRIX *pX,		/* Merkmalsauspr�gungen */
  MATRIX *pn,		/* Gesamtanzahl		*/
  MATRIX *py,		/* Klassenzugeh�rigkeit	*/
  bool   SameCov,
  MATRIX *pbeta
);


int Regression(
  MATRIX *pX,		/* Merkmalsauspr�gungen */
  MATRIX *pn,		/* Gesamtanzahl		*/
  MATRIX *py,		/* Klassenzugeh�rigkeit	*/
  MATRIX *pbeta
);



int UniRegression(
  MATRIX *pX,		/* Merkmalsauspr�gungen */
  MATRIX *pn,		/* Gesamtanzahl		*/
  MATRIX *py,		/* Klassenzugeh�rigkeit	*/
  MATRIX *pbeta
);
#endif
