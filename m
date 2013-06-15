From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
Date: Sat, 15 Jun 2013 13:36:10 +0200
Message-ID: <20130615113609.GB2938@katana>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130614140719.GC2929@katana>
 <20130614151252.GR16699@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130614151252.GR16699@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2013 at 05:12:52PM +0200, Maxime Ripard wrote:
> Hi Wolfram,
>=20
> On Fri, Jun 14, 2013 at 04:07:20PM +0200, Wolfram Sang wrote:
> > On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > This patchset adds support for the I2C controller found on most of the
> > > Allwinner SoCs, especially the already supported A10 and A13, and the
> > > yet to come A31.
> > >=20
> > > This driver leverages the Marvel mv64xxx i2c controller driver, that =
has
> > > an almost identical logic, with a slightly different register layout.
> >=20
> > \o/ Yay, that's more like it. Thanks for the rework!
> >=20
> > > It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
> >=20
> > I'd love to get some Tested-by or other tags for Marvell hardware. Any
> > volunteers?
>=20
> Yes, I'd be more comfortable with Tested-by from Marvell users. I'll
> probably be able to get my hands on a Marvell board on monday, if no one
> tested it yet.

Applied to for-next, thanks, especially for respinning the driver! Also
thanks to the testers! Great community work here \o/


--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvFGpAAoJEBQN5MwUoCm2PNAQAJpDeeIqoHP73hdxmLHZ7pJl
hOAZslKHg9fBMNhzuX8H44zwV2HLU6B/AxKXqaY+WW33rWatRHswh+/dXXhmUGpn
mjFEkvaaKYwtpg4HzQTsxFuN32VKgRm0HQx7Ob+gU0GmylFwRPd0vRsmKR7h4Lxd
Ci04mRYdmNh9KzdYO4RPP32U8RWRjadHYKUV+o3o+wIwJgS9zfTcLzORaEDgEIeU
urS72Q6jm1L+Yojm1c9vVLZDBeJMtvdYSLF4ooBTOrS2f1E/pq5R7/hcHLhITZGk
9Ap74bj2T4Pxb89n1fmdp03eEXGlaQiCeRi9/c1Yxx5eFn3KMzGxI/6hQ8YEu7Xa
/+fGoA9Ml0w4HAjvT6/V9QEyuDx94rMZOBAjpAXDE7ak4Nk+LZwbCL/ID8+KhnRC
lt6N+iQf6xMAUicsl52lxfvpWakUbb0zP2S8bOrP2AL/VhuAl8YocJo7UO+LmhlE
8qbZqXVJ7m83vQxzWTNeHDGWhp8vlI6cvcS7gfqsA1vhtumR4TB9HtoZLAqkRFwq
aqL9YzDwfDrZ2gxyqKprGYDhvMD+78rQ6WPDE6VQoMptmDsytV3wi1orD1NHdFbB
JfrSjCb5Nm/sWPRF3R3yKCGFUvB74PKVC4n9cpWUhGDC8JPiuFBvRsZZ51aKTbWx
+quUEPQm72JB1VdTE9gm
=m5dh
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
