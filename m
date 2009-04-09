From: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
Subject: Re: [PATCH] Let PCA9564 recover from unacked data byte (state 0x30)
Date: Thu, 9 Apr 2009 11:18:48 +0200
Message-ID: <20090409091847.GA539@ngeserver2.localdomain>
References: <20090407103847.GA13586@ngeserver2.localdomain> <20090407210409.GA21933@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090407210409.GA21933-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, Apr 07, 2009 at 11:04:09PM +0200, Wolfram Sang wrote:
> On Tue, Apr 07, 2009 at 12:38:56PM +0200, Enrik Berkhan wrote:
> > Currently, the i2c-algo-pca driver does nothing if the chip enters =
state
> > 0x30 (Data byte in I2CDAT has been transmitted; NOT ACK has been
> > received).  Thus, the i2c bus connected to the controller gets stuc=
k
> > afterwards.
> >=20
> > I have seen this kind of error on a custom board in certain load
> > situations most probably caused by interference or noise.
> >=20
> > A possible reaction is to let the controller generate a STOP condit=
ion.
> > This is documented in the controller data sheet and the same is don=
e for
> > other NACK states as well.
> >=20
> > Signed-off-by: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
> > ---
> >  drivers/i2c/algos/i2c-algo-pca.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > Index: drivers/i2c/algos/i2c-algo-pca.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- drivers/i2c/algos/i2c-algo-pca.c.orig	2009-04-07 11:23:08.00000=
0000 +0200
> > +++ drivers/i2c/algos/i2c-algo-pca.c	2009-04-07 11:24:56.000000000 =
+0200
> > @@ -270,10 +270,12 @@ static int pca_xfer(struct i2c_adapter *
> > =20
> >  		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK =
has been received */
> >  			DEB2("NOT ACK received after data byte\n");
> > +			pca_stop(adap);
>=20
> This looks okay.
>=20
> >  			goto out;
> > =20
> >  		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes=
 */
> >  			DEB2("Arbitration lost\n");
> > +			// XXX pca_start()? pca_reset()?
>=20
> (No // comments, see CodingStyle)

Yes, of course. Read that as "RFC" :)

> I think we should do something here, too. The manual says something a=
bout doing
> another start. What about doing this and adding a comment that possib=
ly a reset
> is another thing to try in case of problems?

That sounds good. Updated version will follow.

Enrik
--=20
Enrik Berkhan
Electronics Design Engineer
GE Oil & Gas
PII Pipeline Solutions

T +49 7244 732 476
=46 +49 7244 732 304
E enrik.berkhan-JJi787mZWgc@public.gmane.org

PII Pipetronix GmbH, Lorenzstra=DFe 10, 76297 Stutensee, Deutschland
Gesch=E4ftsf=FChrer: David Allen, Werner van Wickeren
Sitz der Gesellschaft: Stutensee
Amtsgericht Mannheim HRB 702297
USt-ID: DE 244323981, Steuer-Nr.: 5930/0173
Deutsche Bank Karlsruhe, BLZ 660 700 04, Kto: 1 435 700 00
