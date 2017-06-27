From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v12 1/2] i2c: designware: add SLAVE mode functions
Date: Tue, 27 Jun 2017 23:35:48 +0200
Message-ID: <20170627213548.iq4jtor4eds4ebm3@ninjato>
References: <cover.1498126241.git.lolivei@synopsys.com>
 <8da0ec338fd4b634b01ecded0117f7bd423c6aaf.1498126241.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ldswiu2xejqciazg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8da0ec338fd4b634b01ecded0117f7bd423c6aaf.1498126241.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ldswiu2xejqciazg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 11:17:32AM +0100, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>   when supported by the architecture.
>=20
> All the SLAVE flow is added but it is not enabled via platform
> driver.
>=20
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>

I fixed this checkpatch warning for you:

WARNING: quoted string split across lines
#391: FILE: drivers/i2c/busses/i2c-designware-slave.c:281:
+		"%#x STAUTS SLAVE_ACTTVITY=3D%#x : RAW_INTR_STAT=3D%#x"
+		" : INTR_STAT=3D%#x\n",

Nice, you fooled two code checkers by having code in comments :) No
need to fix, of course:

    SMATCH
drivers/i2c/busses/i2c-designware-slave.c:318 i2c_dw_irq_handler_slave warn=
: unused return: stat =3D i2c_dw_read_clear_intrbits_slave()
drivers/i2c/busses/i2c-designware-slave.c:329 i2c_dw_irq_handler_slave warn=
: unused return: stat =3D i2c_dw_read_clear_intrbits_slave()
    CPPCHECK
drivers/i2c/busses/i2c-designware-slave.c:329: style: Variable 'stat' is as=
signed a value that is never used.

Build warning:

  CC      drivers/i2c/busses/i2c-designware-slave.o
drivers/i2c/busses/i2c-designware-slave.c:173:5: warning: no previous proto=
type for =E2=80=98i2c_dw_reg_slave=E2=80=99 [-Wmissing-prototypes]
 int i2c_dw_reg_slave(struct i2c_client *slave)

I declared the function static to fix it.

Applied to for-next, thanks!


--ldswiu2xejqciazg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSz7QACgkQFA3kzBSg
KbZwfA/+PSReaqK8zdbVXXDLLwT4dxRQpKTJKi7nl4bd0toCqxixL1savKvKoR1K
b1WTFtiIkbJwm3r/OXvsCmOjFoTcTBLY4kvk08mYkdP8s2DG7xSHxroKQwbeQZYz
OrAJSNFJZqYjvABPsfOAWstRUqa9pbbXyzyynQN0Q9VJ1OVtrQ3BnSKNQdRfwoyM
/83r32KmXyBGgLx7HG36USBY4Nb+Z/uiOEN+0CtqK44xFW0XSZj+QrkfJwxgxr7G
p4IZWKq1iRDP1Z5tX2DUL8qhwKJt+w/ckvD4mOSqgMcshHMLi4kyKdwl6iWjaTcH
Bos2Ce12KOkFf0T2/fIUC4MEjGSmbkRP/BCDPENvI5sR8NjWeoAMeY++KVbmL5Er
A55FDY3x6T0nohQlBlTvRCXoTG7r4zLutauFR4s4mMcaUekqR37nj9WkjinI6rBl
mKadcVUH/uKJ7BEu6sSzitKLEq3FnIuXOh+G4qOGxzWokeQ8XPhTDJeIO1O8NSZQ
V+e/GuBoaucu8xGi9Oz/aYx+2fIa45EeMhAU4pxXQ88n0IYn57cGryzxwFh7CvGl
d/LNnsEs5OuQtrYG9k0X2wWOcfuAU0m0Z8dEtoeyK/aeNivYJrUhyfWFo5Igf4w0
ZsTgdqf/+Rupz09vrVpqVXM/6PGt6MLuoX0H2Lhl585B0eo6NxE=
=FNTb
-----END PGP SIGNATURE-----

--ldswiu2xejqciazg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
