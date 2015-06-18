From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v1] i2c: imx: add runtime pm support to improve the
 performance
Date: Thu, 18 Jun 2015 06:24:29 +0200
Message-ID: <20150618042427.GA1611@katana>
References: <1433987404-28957-1-git-send-email-b54642@freescale.com>
 <20150617214839.GG20984@pengutronix.de>
 <CY1PR0301MB0858E745717A1A7317909A2FCFA50@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB0858E745717A1A7317909A2FCFA50-YrwGdl+PljlUWoKpOwApjpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > +	if (pm_runtime_suspended(i2c_imx->adapter.dev.parent))
> > > +		return IRQ_NONE;
> > > +
> > I don't claim to understand the runtime pm stuff, but I agree to the
> > previous reviewer that this smells fishy. If this is required it needs a
> > comment why.
> >=20
> In fact, I agree you two reviewers' consideration. As I said, this is jus=
t to avoid system hang in worse case.
> Of course, I still don't catch the worse case. So I will remove this pm s=
tuff.

So, there is a worst case where the system can hang now which is not
present in the current version of this driver (i.e. before your patch)?


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgkf6AAoJEBQN5MwUoCm2zTIP/0mBp3ylL7lzMa+fb4VvFWKz
I2mJ5RDGyaGEDZGiO7dU+YLIML+UCMs6gbbcX6tmRk6zCmEUAn1jELBJ7Wm27epy
WZxG1qXYjkJpwAI782QCLw+5BoSiR/8CrrfA6tilAOJHaDpZnsBzxbZKcRrdQg2p
ACdMgeGfXsvbXUNyWOocyvU5gqg1Bc0sSIefjZuKyiAkZJzD/8ElxCUslAGNT4ID
IqVR8gqClBV1CHkoogWMb34hCdEd1lJ4Xl/Uzb//Kk/bY/CcKHK2HEeODCSIYOdU
coeZhLHhhYluMwaWGoNhK1rMzBAiWsUvLgtJI1sQDqOZs2uc0CO8MhAjGAc2Mcmi
hNpyUt/h+Y+acJ5FbMUk5oTCwYey/zlTFyxP6fndn3DlAEROsDfRjbLYhjbukPBv
iE/ZOPiICruh0pWx8nbn68PkdpAxVA1zXK6VmK9avfbJCVp14S+o3dHxxVjABjmu
5QHUvPtjXstFjAj/PnSyFRlh7WnoXNicKbRdnj4sOGkYEXhFCzdDaeZn4KKGz3z3
Qeynt+RSKxucPvEcXLgAhEC4A84H4BGVDZtMLHiweWYUw548FoXIg+QsCY2B8s8O
6U318nM7AHNglH4R5+hTQVCpfP8yU4XANxr1AM7ibxbDFelbIraL/Nr/3PcLy7Mg
877yjhfVwi8eUHaX+St5
=kH3C
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
