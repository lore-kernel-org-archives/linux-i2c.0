From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: add required clocks property to binding
Date: Sat, 7 Mar 2015 01:13:33 +0100
Message-ID: <20150307001332.GC993@katana>
References: <1425401828-31063-1-git-send-email-mporter@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425401828-31063-1-git-send-email-mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2015 at 11:57:08AM -0500, Matt Porter wrote:
> A clock specifier is required for i.MX I2C and is
> provided in all DTS implementations. Add this to the
> list of required properties in the binding.
>=20
> Signed-off-by: Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Applied to for-current, thanks!


--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+kKsAAoJEBQN5MwUoCm2uZkP/jYOpgOl77bxmzyjlw6M2m31
LC+bUeSrV11bUVGdLb6rlW8OIwCF4O6MmgcgOvOvD30Zwku8kYVYJq0wgFp76yUF
1k5B49TwESp3X6m2z0GiUL5iZOCFFQKVLwZxYbzBAbnj4uRhGnvT7SmiKCtEdfkj
gmdUFoX0wVQEwkplxPwMcVas/xnJSfr0f/ya+pDGHSNUoP7HhkrBgGc5lco5/GJg
0HsLfkvdSUlMovso4roT5KwBXDpS08a4MBOIxKWY4jPCNPEN5bpowHGFKCszoPZF
YnkeoW7Z2+EakBFZAlsIMCQWDzNdDWxRzm8eo7VVCRLNsb4zd2MEM98EZqEHd8q2
2+V+j0vjLHEytsrfzxTbNfOBR3g4cq/8p5PvqUDFIn1SVFxkgwEpciWLhdGOtD8z
EqxbHtYaLf3lEAGtPFpdPjurrGfhx9vC0HtGGI7whPL+f0vwT8kFcy+RkzuF9SWB
SGKI6E4/sg+QKtjzn3laPdmKwLsykmOS6bgrQ0gEz7m6R0dGNztSseZTFpysf9U4
qHz+aRRFno/HSmLjWT46rhesCAG1uhQMoFlRzQB/zMUEInWgQiljgeq0/h92SLt0
MIaM5lGGbCJ/90FmW36WxfZq33nkXaCYpgbvEG09S+VdEeNPfdbEYHDJpbQlvQA9
NbzHe/wsi2JcmKL0L4iY
=Ds04
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
