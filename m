From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Check the return value from
 stmp_reset_block()
Date: Thu, 15 Aug 2013 12:00:22 +0200
Message-ID: <20130815100022.GC2987@katana>
References: <1373505568-21477-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373505568-21477-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 10:19:28PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> stmp_reset_block() may fail, so let's check its return value and propagat=
e it in
> the case of error.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-next, thanks!

Marek: can you base your pio rework on top of this patch, too?

Thanks.

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDKa2AAoJEBQN5MwUoCm2kdwP/3qiTe4RvXwNpM8YboQiEohh
NR08JlmBow4Oj45ee/jSY5N131N12o8Xk7Ls+tROKU7+jFDsqLhTcC55f0R/EL3R
szAIB4HYMuHdsppO0ebMVxSfJjgRiSXG667mv+jHXTZVFHWg5zLTEH60qyTQnZAi
5WRkeVFmzUxF5aW8acIXwDPyaKtu+8uaM6klMpjpOiVRAwAR/0+FJM/+fwlPSc3g
w0mLdZ6Q/j9i8+3JAdIJACjcFQqLqp19MiwlTU5TJ6NpAsN5011auMIFYE1XLbl1
vDYGD62bLyTIzkWyKC0ct7++Mt3fjmwM0S6y//OimoXeMCPNxMvFQ5X5+B2BCjYW
WPcQeGT4FpQIBN0Hrhc3yP+irbEpVFUW3rIeEu0bFrUuQ4nQnOQxjtguv2s+/NWw
6D0w366u9VuvhCjV80iqX/7cTO1EPDPG9o+b+ry8nV1L8lX0sZ8S4p3Q/smhjL77
8GKJTbzn4zlBeUP+DAHOiaOkhZl3d/cCEHGC1qHyIKa0o8w8kRUiOrwqfQrxmRqq
CJFEhVG3AJv8Ywkdv4aEtvPNou/z+ide6ImlJDTexLsbRr3XmIwSwni6ur8C0aUC
RWaKT6JehZmeRTHVx+kMi9nqtde1Poj80m2quztcIvCAYl0Oq9/9oso7vySYv9/n
8s87UzHzeRzY1/WF6QhE
=UFgr
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
