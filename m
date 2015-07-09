From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Thu, 9 Jul 2015 21:53:09 +0200
Message-ID: <20150709195309.GI4744@katana>
References: <5582870B.7030304@nokia.com>
 <558288B0.1020706@ti.com>
 <5582F049.8070407@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5582F049.8070407-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 12:22:33PM -0400, Murali Karicheri wrote:
> On 06/18/2015 05:00 AM, Sekhar Nori wrote:
> >On Thursday 18 June 2015 02:23 PM, Alexander Sverdlin wrote:
> >>According to KeyStone Architecture I2C User Guide,
> >>
> >>                          module clock frequency
> >>master clock frequency =3D ----------------------
> >>                          (ICCL + 6) + (ICCH + 6)
> >>
> >>i.e. "d" in i2c_davinci_calc_clk_dividers() should be fixed and
> >>not dependent from module clock prescaler PSC on these SoCs.
> >>
> >>Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> >>---
> >>
> >>RFC: If someone from TI has an idea how to improve the coverage of futu=
re Keystone
> >>revisions -- hints/patches are welcome. The current ID check is based on
> >>Davinci/Keystone datasheets and is at least working on real Keystone II.
> >
> >+ Murali who works on Keystone devices in TI.
>=20
> + Grygorii
>=20
> + Grygorii has been involved in the Keystone related enhancement and
> reviewing prior patches. Need to have his ack for this change

Any news?

>=20
> Murali
> >
> >>
> >>  drivers/i2c/busses/i2c-davinci.c |   10 ++++++++++
> >>  1 files changed, 10 insertions(+), 0 deletions(-)
> >>
> >>diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-=
davinci.c
> >>index 4a110af..3d78f6a 100644
> >>--- a/drivers/i2c/busses/i2c-davinci.c
> >>+++ b/drivers/i2c/busses/i2c-davinci.c
> >>@@ -60,6 +60,8 @@
> >>  #define DAVINCI_I2C_IVR_REG	0x28
> >>  #define DAVINCI_I2C_EMDR_REG	0x2c
> >>  #define DAVINCI_I2C_PSC_REG	0x30
> >>+#define DAVINCI_I2C_ICPID1_REG	0x34
> >>+#define DAVINCI_I2C_ICPID2_REG	0x38
> >>  #define DAVINCI_I2C_FUNC_REG	0x48
> >>  #define DAVINCI_I2C_DIR_REG	0x4c
> >>  #define DAVINCI_I2C_DIN_REG	0x50
> >>@@ -203,6 +205,9 @@ static void i2c_davinci_calc_clk_dividers(struct da=
vinci_i2c_dev *dev)
> >>  	 * where if PSC =3D=3D 0, d =3D 7,
> >>  	 *       if PSC =3D=3D 1, d =3D 6
> >>  	 *       if PSC > 1 , d =3D 5
> >>+	 *
> >>+	 * Note:
> >>+	 * d is always 6 on Keystone I2C controller
> >>  	 */
> >>
> >>  	/* get minimum of 7 MHz clock, but max of 12 MHz */
> >>@@ -211,6 +216,11 @@ static void i2c_davinci_calc_clk_dividers(struct d=
avinci_i2c_dev *dev)
> >>  		psc++;	/* better to run under spec than over */
> >>  	d =3D (psc >=3D 2) ? 5 : 7 - psc;
> >>
> >>+	if (davinci_i2c_read_reg(dev, DAVINCI_I2C_ICPID2_REG) =3D=3D 0x2206) {
> >>+		dev_dbg(dev->dev, "Keystone SoC detected\n");
> >>+		d =3D 6;
> >>+	}
> >
> >I think its better to use a different compatible string for i2c on
> >keystone devices rather than using a fixed hardcoded IP version.
> >
> >Thanks,
> >Sekhar
> >
>=20
>=20
> --=20
> Murali Karicheri
> Linux Kernel, Keystone

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntElAAoJEBQN5MwUoCm2Hu8P/3amCQItizJZadQsEEus5RIE
UAqEnEHCmAc9XO0WXoI4c1GYSBCJ1zWvteTVnre+s9HDmNG3oozgAJ+VlieHWTpb
FtNte0XieI09SympTuWVeJw+hsnFWIPiNx/5o/gEOZpgEjlR9F/8T3ktJmnN/Ghh
o1vijenunlZ6qJpb0hyDIeBELppT93XeTsaKUg4RJLiNfOcyHlMAbmbNW3aARjeN
l6IZoArCsF71IJOB1DT1AwGIfEVI7dq5d3p2E9MCRUyU8mUom5RF9eWo09sChDes
rls8k3+GRDMaMEEHX/GHGx0ihtlXCCtGGWsf2LOy7sOQhI58hEWCX6iith0oOrwa
k2Dw7n7QtNHpvLybyrfezZztzK1JGKxJfusudfZJJpWWBQ0qo7nwHJ4bRHkskHVP
yx11XuSG9yQ3CXROiIFFcuNZOu9IGW2139mfawTKLEuDmDbAMELy+XpXWxYLi+3i
VT1RTD0f69ojh4DwJj+ePAZ2Ek80VEPvJZzsdaJQJQ9QDutIOGCQJUKQ6XvrR6sz
IqfUg+azly64JitP06GSP7eao8tmIso7MjjFbolDtoYt+9KvaPxZTLC193m557D7
jcBZpiaeauKvpAupJshYXbIguRUEuC5gptxWsuTEkYUR8916slSMqhZ4YbWt46oN
0kzyKCYk3G7izw98zrOm
=vPFO
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
