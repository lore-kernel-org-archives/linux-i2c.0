From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 3/3] i2c: xilinx: Use devm_* functions
Date: Sun, 13 Oct 2013 20:19:01 +0200
Message-ID: <20131013181900.GB5713@katana>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1381401561.git.michal.simek@xilinx.com>
 <9691811c34ee339b1f5e3ed2acdea0796fc80788.1381401561.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9691811c34ee339b1f5e3ed2acdea0796fc80788.1381401561.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, g@katana.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2013 at 12:39:38PM +0200, Michal Simek wrote:
> From: Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>=20
> Simplified the probe and remove functions using devm_* functions
>=20
> Signed-off-by: Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v3:
> - Remove error message which is already shown by devm_ioremap_resource
> - Fix dev_get_platform recasting to simple (void *)

It IS a void pointer which you don't need to cast at all...


--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSWuQUAAoJEBQN5MwUoCm2pysP/2Zq8NFJSthNInmEa2gH7vtj
djxeuD1+WeFi6Cj7SwW3XiRlLFaoyB6zCMp3dXmA3+h7VS03IiudRhWcvQ1IzQDW
2fY8UUbeZW+IN0OXOTAw7UyMmyZK74pN8l1rb+9eMRIhj2WGoGfHPyUN2673aQE2
UNyV52MNRdhOP41joZxuBfLj7+1GZAUGsJandLdvCS5gkYo7LtVpXoUz1PyWiUxE
rxbTzkb1LKZlXi5dP4Zn1BiCLVvGjUUlwoI2hfRNKvOgDfn0WJG8mi6dOO9H5xk6
B39+sEvq4xFB9o9TlMgrRmi+7HI6MHM4uaqa63+6Mpgsr/3gFa+CB8FYvT3Cvuev
f+5IXwZwX5VFuBznn47GsMqPm4oT3VzYrTJSfrjCIO2QJSBzyOHhXjw5a30aEdrm
wGMwzV6cXTnv2Vi31aK0RB04zSwflCR4R11Psq3ZT6r1/8FTkpkARx3ppZ2cEhE9
gE0z72Q3sZyF714mY94j7FvPqrZ4RS586xDX7Ec94N2iqG8WTaBQboDpADKnYvLl
YuaOX2J1RsyFELctc3weTq38LXg7OC2vOY/bVoU2CfID1k0Fo284a52f/rqUFp+N
e0lqnkMJXowp+7UdCzhaaFlTUchSFkB1r15uBLr6ZWAoZNYurlvqQ2ZfsQLofcMw
qWXPfj2o/AwYiOoC+KJM
=U15n
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
