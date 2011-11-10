From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Thu, 10 Nov 2011 22:10:02 +0200
Message-ID: <20111110201000.GB17468@legolas.emea.dhcp.ti.com>
References: <cover.1320934086.git.n.voss@weinmann.de>
 <f29b091aaf5165d602f7ddd3980de748c1c27688.1320934707.git.n.voss@weinmann.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f29b091aaf5165d602f7ddd3980de748c1c27688.1320934707.git.n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2011 at 11:49:46AM +0100, Nikolaus Voss wrote:
> This driver has the following properties compared to the old driver:
> 1. Support for multiple interfaces.
> 2. Interrupt driven I/O as opposed to polling/busy waiting.
> 3. Support for _one_ repeated start (Sr) condition, which is enough
>    for most real-world applications including all SMBus transfer types.
>    (The hardware does not support issuing arbitrary Sr conditions on the
>     bus.)
>=20
> Tested on Atmel G45 with BQ20Z80 battery SMBus client.
>=20
> Signed-off-by: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>

FWIW:

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOvC+YAAoJEIaOsuA1yqREg3sQAKyTNZkFNeLjnflHsnBWeGcr
H1ZLLMnDLQUPCmzFSrywge68Ox3b7cNOPRKzo22/f0ubDNEYohg7ji+35ejJTYQl
bTW/hS6UxUyrMYHlPvIBS+Gqlr7uHwpe1z5CKGf05dH7A4rdL/Dk2PF3Hqmrt50j
XYAUdfRyYPUgcfrZo/AkDZISIUIrR+qaOrzQo7HdQ0EVMxmD4ThWckTASrYFYDa0
qgxZvoxZwxtb9TDFpF6XZg33hd1FPeadnRCEgyGRLWtoMpQc0633xrzyLALwBo1q
oYl18m9Dj+EiGS3sv1EZlNCPqjmsOCxXDZt+lYgcscw0zZmatpgK/Xh36yzsycpq
uM59L7drfhZzsnFHHcShFr95eE3wfYAAcdnKvTvRFUjH65D5dDsxL8NlD8O1cfn+
uwLwDfZlLonX//O94kFFBAfqm+HqGrXGs+Fk0Yx+ERuqT4k7oS/3QKL+jqOYZ1ZK
1SviZRBpsC4ra6xsTqTFqI0gtj7gErsk65UqQJfc0y378kSm1aODGnsVa9FmBr8m
qE3GnPXsHQ01t3OOmlr6ei5lrrptBI79Soas2EohBZYs2W9LmkPY7/9oWNdJwPXr
iEFBhizpcmAxVpMMdQ2JTehON4M920jO6zIIRy9E0xu2KQDiL8qYIhXdV+2gI6IV
mCbTS4raAEZwuZFSbJ/T
=HaU4
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
