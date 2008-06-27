From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Grouping i2c bus drivers
Date: Fri, 27 Jun 2008 15:44:36 +0200
Message-ID: <20080627134436.GC3931@pengutronix.de>
References: <20080627145236.2a20aaad@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3886481146372671881=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080627145236.2a20aaad-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============3886481146372671881==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Fri, Jun 27, 2008 at 02:52:36PM +0200, Jean Delvare wrote:
> Hi all,
>=20
> As was mentioned previously, I have decided to group the i2c bus
> drivers to make it easier for the users to know what they need (and also
> for me to know what drivers might be affected by a given problem.) Here
> is the list I have at the moment. There are still many drivers in the
> "Other" category. I suspect that many of these should move to the
> "Embedded" category, but I don't know for sure. So I would welcome
> comments and suggestions for improvements.

=46rom my first glimpse:

>=20
> # PC SMBus host controller drivers
> obj-$(CONFIG_I2C_ALI1535)	+=3D i2c-ali1535.o
> obj-$(CONFIG_I2C_ALI1563)	+=3D i2c-ali1563.o
> obj-$(CONFIG_I2C_ALI15X3)	+=3D i2c-ali15x3.o
> obj-$(CONFIG_I2C_AMD756)	+=3D i2c-amd756.o
> obj-$(CONFIG_I2C_AMD756_S4882)	+=3D i2c-amd756-s4882.o
> obj-$(CONFIG_I2C_AMD8111)	+=3D i2c-amd8111.o
> obj-$(CONFIG_I2C_I801)		+=3D i2c-i801.o
> obj-$(CONFIG_I2C_NFORCE2)	+=3D i2c-nforce2.o
> obj-$(CONFIG_I2C_NFORCE2_S4985)	+=3D i2c-nforce2-s4985.o
> obj-$(CONFIG_I2C_PIIX4)		+=3D i2c-piix4.o
> obj-$(CONFIG_I2C_SIS5595)	+=3D i2c-sis5595.o
> obj-$(CONFIG_I2C_SIS630)	+=3D i2c-sis630.o
> obj-$(CONFIG_I2C_SIS96X)	+=3D i2c-sis96x.o
> obj-$(CONFIG_I2C_VIA)		+=3D i2c-via.o
> obj-$(CONFIG_I2C_VIAPRO)	+=3D i2c-viapro.o
>=20
> # Mac SMBus host controller drivers
> obj-$(CONFIG_I2C_HYDRA)		+=3D i2c-hydra.o
> obj-$(CONFIG_I2C_POWERMAC)	+=3D i2c-powermac.o
>=20
> # Embebbed system I2C/SMBus host controller drivers
> obj-$(CONFIG_I2C_AT91)		+=3D i2c-at91.o
> obj-$(CONFIG_I2C_DAVINCI)	+=3D i2c-davinci.o
> obj-$(CONFIG_I2C_GPIO)		+=3D i2c-gpio.o
> obj-$(CONFIG_I2C_IXP2000)	+=3D i2c-ixp2000.o
> obj-$(CONFIG_I2C_OMAP)		+=3D i2c-omap.o
> obj-$(CONFIG_I2C_PXA)		+=3D i2c-pxa.o
> obj-$(CONFIG_I2C_S3C2410)	+=3D i2c-s3c2410.o
> obj-$(CONFIG_I2C_VERSATILE)	+=3D i2c-versatile.o
>=20
> # External I2C/SMBus adapter drivers
> obj-$(CONFIG_I2C_PARPORT)	+=3D i2c-parport.o
> obj-$(CONFIG_I2C_PARPORT_LIGHT)	+=3D i2c-parport-light.o
> obj-$(CONFIG_I2C_TAOS_EVM)	+=3D i2c-taos-evm.o
> obj-$(CONFIG_I2C_TINY_USB)	+=3D i2c-tiny-usb.o
>=20
> # Graphics adapter I2C/DDC channel drivers
> obj-$(CONFIG_I2C_VOODOO3)	+=3D i2c-voodoo3.o
>=20
> # Other I2C/SMBus bus drivers
> obj-$(CONFIG_I2C_ACORN)		+=3D i2c-acorn.o
> obj-$(CONFIG_I2C_AU1550)	+=3D i2c-au1550.o
> obj-$(CONFIG_I2C_BLACKFIN_TWI)	+=3D i2c-bfin-twi.o
Embedded.

> obj-$(CONFIG_I2C_ELEKTOR)	+=3D i2c-elektor.o
It is not SMBus, but still PC (ISA).

> obj-$(CONFIG_I2C_CPM)		+=3D i2c-cpm.o
Embedded.

> obj-$(CONFIG_I2C_IBM_IIC)	+=3D i2c-ibm_iic.o
> obj-$(CONFIG_I2C_IOP3XX)	+=3D i2c-iop3xx.o
> obj-$(CONFIG_I2C_ISCH)		+=3D i2c-isch.o
> obj-$(CONFIG_I2C_MPC)		+=3D i2c-mpc.o
Embedded.

> obj-$(CONFIG_I2C_MV64XXX)	+=3D i2c-mv64xxx.o
> obj-$(CONFIG_I2C_OCORES)	+=3D i2c-ocores.o
> obj-$(CONFIG_I2C_PASEMI)	+=3D i2c-pasemi.o
> obj-$(CONFIG_I2C_PCA_ISA)	+=3D i2c-pca-isa.o
It is not SMBus, but still PC (ISA).

> obj-$(CONFIG_I2C_PCA_PLATFORM)	+=3D i2c-pca-platform.o
External means probably: Connected via some bus? This one is just memory
mapped...

> obj-$(CONFIG_I2C_PMCMSP)	+=3D i2c-pmcmsp.o
> obj-$(CONFIG_I2C_PNX)		+=3D i2c-pnx.o
> obj-$(CONFIG_I2C_SH7760)	+=3D i2c-sh7760.o
Embedded.

> obj-$(CONFIG_I2C_SH_MOBILE)	+=3D i2c-sh_mobile.o
Embedded.

> obj-$(CONFIG_I2C_SIBYTE)	+=3D i2c-sibyte.o
PC? Looking at MODULE_DESCRIPTION.

> obj-$(CONFIG_I2C_SIMTEC)	+=3D i2c-simtec.o
> obj-$(CONFIG_I2C_STUB)		+=3D i2c-stub.o
> obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o
> obj-$(CONFIG_SCx200_I2C)	+=3D scx200_i2c.o
>=20
> (Of course, Kconfig has similar groups.)
>=20
> Thanks,
> --=20
> Jean Delvare
>=20
> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIZO7ED27XaX1/VRsRAjvkAKCLy+ELwmBaTYkaE4tAWvx87zdJqACdELzm
i9xThfJ8bNvpkE/aq+QzWdY=
=dpfi
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--


--===============3886481146372671881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3886481146372671881==--
