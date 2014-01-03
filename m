From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: propagate irq error code in probe
Date: Fri, 3 Jan 2014 17:38:28 +0100
Message-ID: <20140103163828.GJ7132@katana>
References: <1386885091-23188-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QxN5xOWGsmh5a4wb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386885091-23188-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 10:51:31PM +0100, Wolfram Sang wrote:
> smatch rightfully says:
> drivers/i2c/busses/i2c-imx.c:610 i2c_imx_probe() info: why not propagate =
'irq' from platform_get_irq() instead of (-2)?
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--QxN5xOWGsmh5a4wb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxueEAAoJEBQN5MwUoCm2UhYP/0tleH82MVP+jOuJIDneBcFd
gnpbS+UFLoCTPv27haNFo5bbuaolaF9yDg+0V23kB1t1F9rZGYklTlYGJBSZLWi3
QsE0+ZYVRxUYtn0KcB6L1ntRSCMbzMGi83kWOuCcBqejZtrkMPOugcZeB2cbxNeF
3mVLmKkfNBBtY8/d3x6+q8QWdeWharWHNECMKpqPCceyvfI84BBVHJgSmD8Tswu1
aAIRaFfaYTQQgwOqDppST6SgE2GqudBCNhjatf2ecpcfQ3X0Xr/xDkuy7hTif/hJ
i+So/D1zU8nql4+3GESbqUgHQ5c9QsFk21LQi3goq6+yj0mIUFrqcLAvAAwCTG65
1OpDfAokCSzp7qH5xmTc8HYuLGT0ekOYIJWjmR7+p9IYblp8Y3e0AnnwpIs2SUv+
SwHsLqVJFNCFPtYv5oM6vA7X6jWu2T7SbcR3iKhJDotGFFzPNJhKQkLgHt0o6ZiO
WZlNU9/lU+D8rJwGc7NkxQW18u1UpgMwfa6GFMQIycQe16iirrRHA7vjPuxkrUaZ
OvK6ZVumdFNPnkWJ052z9e2BTqfol6Qhrt2wgtVzU2QzNLDD/3koTBwaI1D0/VAj
LzpPV85XfUclSW3XSxN7QVvAnYzzMZKnxIBksk180iKae8lLkxZEE0bkeqjP1U0B
1qdsY2TxpszLwTBgy7km
=wQbo
-----END PGP SIGNATURE-----

--QxN5xOWGsmh5a4wb--
