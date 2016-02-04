From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: mux: demux-pinctrl: add driver
Date: Thu, 4 Feb 2016 20:45:26 +0100
Message-ID: <20160204194526.GC1958@tetsubishi>
References: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
 <1452695369-29413-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452695369-29413-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2016 at 03:29:28PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>=20
> This driver allows an I2C bus to switch between multiple masters. This
> is not hot-switching because connected I2C slaves will be
> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affecting your use case.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Squashed with patch 1 and applied to for-next, thanks!


--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWs6pWAAoJEBQN5MwUoCm2nb0P/0CH19u6z2zi4Hjz0YLWMB+E
LridHIIQpwHr6QuU9ld9pPKREEdcIEaGyHNDw+v5Qy+ekLdEFL9lcJFa+grCfi36
qLBC31CnF+NpXa/kOlJErSwxolBwyVOhRiZF5aC4M/+LO9JajBkCjTKSNgPE8GmD
neVOeimltztK1I4Hm/5OTwQZC4SxNJKh/0osbqq+jyorybq3WzyNe8up2dyX89nV
PITCTyY3ZxjKh6x3TqmUb+mVACAQoX+Z62ycyJ5GAwQQieM4CXMwTLZ9hqwBYvbF
iGutYsymc8lsWAiIEMecAh0ghqDY1Y/EJNT7oCAX8TS/5+4+06CW1ezHaA6qzvLk
os9QfqVPuLbceFWTbkVyaVuQ7fi0liSjRMSZixJptBLWv5QyJXhjfXTv1m4+4/LB
LIv6x8LlSWR1An4jTAzrbXc74ivl7/FaG+buqX+vqb21o1X0U+3zidPRfEcgCehl
khSjFFXz8ArJDDQzaBeQgTGFBQB1cpTgKvOo2kXriSvng5u2RFKRInHcr5pMnWLf
gGdW0pC2yTT7vNhaIqV2bVQP/X7TkOkiwSwQWBqDxn2gXkAFfquJ9f6WaXFcK/Fx
PFQRxJHe1QfyLttCiULV+eyG0xBWQdL69nMxAB+bW/LKFSnIt2NJAmAGQAmfS6cw
HWyg9XwDmnLj62XhDB7o
=nkJo
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
