From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Fri, 16 Nov 2012 14:29:39 +0100
Message-ID: <20121116132939.GB7313@pengutronix.de>
References: <20090407082052.477328750@denx.de>
 <20090407082231.500525932@denx.de>
 <509A8F0F.4070806@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <509A8F0F.4070806-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2012 at 10:40:47AM -0600, Timur Tabi wrote:
> Wolfgang,
>=20
> I know it's been 3 1/2 years since you wrote this code, but I think I
> found a bug.
>=20
> On Tue, Apr 7, 2009 at 3:20 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> w=
rote:
> > This patch makes the I2C bus speed configurable by using the I2C node
> > property "clock-frequency". If the property is not defined, the old
> > fixed clock settings will be used for backward comptibility.
> >
> > The generic I2C clock properties, especially the CPU-specific source
> > clock pre-scaler are defined via the OF match table:
> >
> >   static const struct of_device_id mpc_i2c_of_match[] =3D {
> >         ...
> >         {.compatible =3D "fsl,mpc8543-i2c",
> >          .data =3D &(struct fsl_i2c_match_data) {
> >                         .setclock =3D mpc_i2c_setclock_8xxx,
> >                         .prescaler =3D 2,
> >                 },
> >         },
> >
> > The "data" field defines the relevant I2C setclock function and the
> > relevant pre-scaler for the I2C source clock frequency.
> >
> > It uses arch-specific tables and functions to determine resonable
> > Freqency Divider Register (fdr) values for MPC83xx, MPC85xx, MPC86xx,
> > MPC5200 and MPC5200B.
> >
> > The i2c->flags field and the corresponding FSL_I2C_DEV_* definitions
> > have been removed as they are obsolete.
> >
> > Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
>=20
> ...
>=20
> > +u32 mpc_i2c_get_sec_cfg_8xxx(void)
> > +{
> > +       struct device_node *node =3D NULL;
> > +       u32 __iomem *reg;
> > +       u32 val =3D 0;
> > +
> > +       node =3D of_find_node_by_name(NULL, "global-utilities");
> > +       if (node) {
> > +               const u32 *prop =3D of_get_property(node, "reg", NULL);
> > +               if (prop) {
> > +                       /*
> > +                        * Map and check POR Device Status Register 2
> > +                        * (PORDEVSR2) at 0xE0014
> > +                        */
> > +                       reg =3D ioremap(get_immrbase() + *prop + 0x14, =
0x4);
> > +                       if (!reg)
> > +                               printk(KERN_ERR
> > +                                      "Error: couldn't map PORDEVSR2\n=
");
> > +                       else
> > +                               val =3D in_be32(reg) & 0x00000080; /* s=
ec-cfg */
>=20
> I'm looking at the MPC8544 reference manual, and PORDEVSR2[SEC_CFG] is
> in position 26, which means that this line should be "& 0x20", not "&
> 0x80".
>=20
> Can you check this for me and let me know if I'm right?

Ping. Somebody wants to send a patch?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCmP8MACgkQD27XaX1/VRss9ACcDBwoplcF9mGHPhE+5nKL5+89
xDAAn2uSiYoDEEFpRBtv2aZ5+k8qv4QP
=tW2o
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
