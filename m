From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: st: add include for pinctrl
Date: Thu, 23 Apr 2015 18:33:01 +0200
Message-ID: <20150423163301.GB4689@katana>
References: <1429789322-27260-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429789322-27260-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 01:42:02PM +0200, Wolfram Sang wrote:
> The driver uses pinctrl directly and thus should include the appropriate
> header. Sort the headers while we are here to have a better view what is
> included and what is not.
>=20
> Reported-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Improved the sorting some more and applied to for-current, thanks!


--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOR69AAoJEBQN5MwUoCm26hcP/3rTD0jt6MxWtMNuwM/6ooHx
l+bWF4fFJDtjGUY8qH6ENLFNCG5BKnZlHKr6LKbn5x1kldHH46tDjz6FopY44EcB
BTAn6e2uM6rJ8W/Ai44XN6P8mBO1jv66dqxiJDVBOuuu0JlO+w5EY1CZhGXiyOlw
xY576ly4JmMwmlyDMX44DG2XWKgmm4eWwBGHOXMm4L+ZdfcVjvz3LURvGleRFsGq
Ky6igGyuTPTpsZihVCdpg8mcYGrMprOelgUI9C3jrsxFXk/cT3JRO16iIeq/o5S1
lsZhFlQhKaiSg1crEQSSq1rlWH1Tn0d3b8R0aGSLkRYGwHkQL8LpQfFvli66Jwqt
q01/l8qoaoliVMs9k3s3XoF78xplTJtgY5D0Nr8BnzY1tJ9x8EituH/8XFJjHx27
y6iwVEt7xEkDfRq20WcdQohZRV3xDm4RzXrnIOyHIhxpOk4fXxJCaCxQvBPiZegX
VfKDf5k5bJeJEmrZNG4irw7/FfRmJw8uaEc8tH7GCCpy4iFa4TdWgq+X0FhdGYWz
b8RrNzB6chbvTj7XO2mHv7NfVFr5mMMu/F1DmJk2EEmdin8n1Ks3Nk3lF3uMhDXj
mw36AlVwfsfKsz6PrLzH406PFANVb/1Ks2mym6NV8mkKXFDugKIl1yPimmBwIvL3
0wBdgO+MhJsb6bgVfJFk
=VLit
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
