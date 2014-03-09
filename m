From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: move bits macros and structs in blackfin twi
 header from arch include to generic include
Date: Sun, 9 Mar 2014 08:41:40 +0100
Message-ID: <20140309074140.GA2575@katana>
References: <1390899322-1184-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390899322-1184-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2014 at 04:55:21PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> The ADI TWI peripheral is not binding to the Blackfin processor only.
> The bits macros and structs should be put in the generic include header.
> And update head file path in drivers accordingly.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHBs0AAoJEBQN5MwUoCm2cWEQAKR21jVzup8TMlqaEFQQBpIV
1l4NDZO18qUsUkhMTOa3kkOhnwKJmHQmXwaGVIKl0A5m1t1qHukH1vuIcJLqybmi
/9LhMMor4+HH9HDovEcP2vqb+hZzj8B4bEHqLZme/+AgLxWzhumKTfdCrHUNsEhu
voDQBmQxfTS6y93ron66K3XhrXSg8773Y1DlA73NMcJS9N3Px/2NviVoH5kTeM1Z
VPZqH0XaLQ8UmYpdQJsJw4SIlEYOaxmrprPzPNBcVHk8Qtgtx9m6R+9QOrDNC/5F
MtZeg7/G3gQw2JqGf2MdH5dR/4kzJ0fXrcsRA39nnpcNRHSaYr3R7JA5p8a6Daj+
DvULm0pgCN8GxKz8m34WG2oXHfNBJ7RzrdR/pS1EikncUalyGC6Ap4UWWm1Qzg7i
67ET6dLHdi7kWaxBjIMAByPBHNLbZT2K5DrUgNwCAJv3BSJa+upvfxcRa+qqqmMA
7mQwsLZUHMA3fJs1787KwmOy8kkama6jUgEOXnt2fg8OQY8JTFtNiehyrwzs5dhU
JrWffO2FUHuz+cZyMO2h+y4xfc1fQrqr/nYGUL6YKnr+SNa3M/J51gX3AsmCnxfh
zCfQgJvfu+zPYOR0OLjdp8XMvhmxwd8PuQhFyyl6lX6xCXlQwRAIlhYTfL23TRT1
mS8Wjtdokrgqt2xQh27S
=5JMQ
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
