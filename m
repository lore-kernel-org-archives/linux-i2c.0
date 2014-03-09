From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: bfin_twi: remove unnecessary Blackfin SSYNC
 from the driver
Date: Sun, 9 Mar 2014 08:47:50 +0100
Message-ID: <20140309074750.GB2575@katana>
References: <1390899322-1184-1-git-send-email-sonic.adi@gmail.com>
 <1390899322-1184-2-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390899322-1184-2-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2014 at 04:55:22PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> Put necessary SSYNC code into blackfin twi arch header. The generic TWI
> driver should not contain any architecture specific code.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHBymAAoJEBQN5MwUoCm2RVwP/2WSrFNtBq1GbttN+2n3VCax
kYkVZ9woZydjUTOkmgvXte4maKULERCDFGXur/RC2plj+BnXd2PaWdKxBhhYSgFJ
8vDLibxTxr4UMlQNoZhXC1OnMgOPaBd1dF7yPZ2BevvExLcCDMlbe6WJV0orNrxa
1qu9hq/g5Tl7qhxGVYRBKrJ/Tyryk2l2hnxmCp0azHpzFKMF4M1KlVlZhM5dAF5e
Q0AcuqDt348u0HBcs63gM248oMNywn3ByfXK3JHS72m9mi+pVBEMGrd7MDs5Yu4U
TgPATbOBFZJMzZmRCN7tfstIK7F16hm3yr8sfOdJVrr3pWO5cAy4+FKqpjo3pQYv
eStesla6GnD1DRaKY+cActpa+ywHuSL/+T54m2W9Q2aRwJ5m0fup+FIv5a0ZjPGE
uC7Cp4m0/RyDdvjnGRMJXlryRQPAYEl/VS9izIpa93R3IIoI1JaYjnDcRm/vf9V8
+PPH8Lx9muN7oGaY354DvFjY3QLsQzHlPkyfvckHw62FDmB3dRzGfjdwpDgpXC1g
0k2wLEQ5tzj06Fb/AQII6u0IQziS/vkeqcPnW6vl391HvVHeU358SPOtvAqLvSop
oYqGsw68zTGMDMFwV/v8NTbD6ayySmwTyZGfEwzsnuckE6ZK6+YrW0zS1BihqAU3
iuMup9ocMkVY0v7/M9bF
=13+t
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
