From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5 v4] i2c/gpio: add DT support
Date: Tue, 13 Mar 2012 20:46:17 +0100
Message-ID: <20120313194616.GE2488@pengutronix.de>
References: <1331642024-19869-1-git-send-email-plagnioj@jcrosoft.com>
 <20120313140822.GD2488@pengutronix.de>
 <20120313164756.GF18320@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120313164756.GF18320-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 05:47:56PM +0100, Jean-Christophe PLAGNIOL-VILLARD =
wrote:
> On 15:08 Tue 13 Mar     , Wolfram Sang wrote:
> > On Tue, Mar 13, 2012 at 01:33:40PM +0100, Jean-Christophe PLAGNIOL-VILL=
ARD wrote:
> >=20
> > > update to use devm_kzalloc for private data
> >=20
> > Hmm, you need really to work on the commit messages, not everybody is
> > familiar with DT and its implications:
> >=20
> > "To achieve DT support, we need to populate a custom platform_data in a
> > private struct from DT information. To simplify code, the adapter and
> > algorithm are also put into the private struct."
> >=20
> ok I put this can I get the Ack ?

Yes.

> I need to send the pull asap

Please, no rush. Makes it too easy for bugs to slip in...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9fpAgACgkQD27XaX1/VRtfrwCgjVpsMEEXLYxWL6OH9cDM4fF2
KywAoMiaxI1BJmb0XiHiXs+8GKco5DOE
=LBlQ
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
