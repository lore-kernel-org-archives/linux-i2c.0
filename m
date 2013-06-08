From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 03/13] i2c: i2c-mxs: Let device core handle pinctrl
Date: Sat, 8 Jun 2013 09:15:21 +0200
Message-ID: <20130608071521.GA3052@katana>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
 <1367863561-11534-3-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5Bju3v4gXayzZ6vMjr9WrSqcYWN+6fnyKMc3AaoYt44Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bju3v4gXayzZ6vMjr9WrSqcYWN+6fnyKMc3AaoYt44Gg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2013 at 05:58:31PM -0300, Fabio Estevam wrote:
> Hi Wolfram,
>=20
> On Mon, May 6, 2013 at 3:05 PM, Fabio Estevam
> <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > Since commit ab78029 (drivers/pinctrl: grab default handles from device=
 core),
> > we can rely on device core for handling pinctrl.
> >
> > So remove devm_pinctrl_get_select_default() from the driver.
> >
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > Cc: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> Any comments on this one?

Yes, with series like this, you really need a cover-letter and CC it to
all people involved. And mention there if you want these patches go via
a specific tree or each patch via the corresponding subsystem tree. And
mention if the patches are depending on each other. Otherwise I don't
really know what to do with these patches.


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRstoJAAoJEBQN5MwUoCm2CSkP/027B4onX0IaN1Ed1mUHtXKq
J0AYF9w7mgvrIXyZWd5js3Gish+FYQvDVVFOGtP6o4gG52pyDNQA+Y5TJTlIW+G8
XyYAH9wBCOvj0agYYk6IOohf2PdGva802XSGOMZ4dUGhPU5KpIm88qKz1LrviP5Y
2aRtfuvnCMLWyXSpPciY/0aSGVWVanPF3eB5bMmIMiXTK/cZx/jC6LVeiDBTQ0//
tIwRHYtnhljP8vhlGjffLS2ASRpV16+Wbrakr7WkuP22uxXRWWyUMCF/rzNEuDXP
UBJ2UFyuEnNUl99sPSrUYVM0Wc+Fv9lZYAFnqTKa+AghfaF4jUmbzkuz+6I6L4qE
zwk4u+G6bIbXo8h1SuUUpOvpPGS43s55C0JMG/uHzXvQt2uzfPx8tbfJwmKEh7FZ
pEKaRhKSCx8d00Q8dNdCcemyYPqaaJl3mLq2B8Y7gi9kVBw9ZC+u2gWhuYA+zjjW
8V1W5x0NlGqpjpgJ0B2LJBUBFCtJpExHJo9yZPMa/+0HXk1ZLkRmpxSxMocQmbUQ
En86dsPAVpappel1PoaY3fNvt6IMIRof8hwgIDDNPDxPKIbxLu0LslGmfoEXp2L5
Fg8DlzQEcZr8zSNUKoXKGiiHIe50BD4k1zvPPoYzBAn6cy652TVWrLzKeu0nrJ32
4v8ru867JviQEwMCRgBM
=hxaU
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
