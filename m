From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v9 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Mon, 9 Feb 2015 13:10:36 +0100
Message-ID: <20150209121036.GB2491@katana>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-3-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423373126-30024-3-git-send-email-rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 09:25:25PM -0800, Ray Jui wrote:
> Add initial support to the Broadcom iProc I2C controller found in the
> iProc family of SoCs.
>=20
> The iProc I2C controller has separate internal TX and RX FIFOs, each has
> a size of 64 bytes. The iProc I2C controller supports two bus speeds
> including standard mode (100kHz) and fast mode (400kHz)
>=20
> Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Applied to for-next, thanks!

Next time, please send new patches as seperate threads, not as a reply
to the old series.


--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2KO8AAoJEBQN5MwUoCm2IxYQAIUBpRjsEXvWL7cPD7Q5uQUB
POE1NiAW5AdONPqMsmx7TWKE7InbrYohX9ILdi9FQl9vH90tbd5+NOG28H9zQBOW
+ip2//QXLUd2lozZVd4qQeY1ctmP9wLSDfUQFBxdvycXG7pj4GllrRogxvb1Q+Yf
KmIwDoKNSfbWJG6JMM7SE1P6C1BsVOGMCixEHOzXyyl/1Eg1ULaNqpuV6/fYDAXt
D4fGwMRfGvrBksex4e0STq7J+TPEU8T1cHVAZll+1o0+kTNw4M6fqExl2wTs51gS
xrSnYkDaLnH5oCEfaeDS8GU1R6CJdcpVuNvwN6fdYO8zquZqbhyFHEekRL/86Gk+
0sDTxUQtB02KeE6EOAc1JKsHCjYSJWeva09Rl96QFZb25Ig+mqmb/civ8a4QT9XB
AQva4Ej6LDFo0zhhoR+dj5OII0YVyThQHYKGI+fLX2ovbqDNffN9cvVSTElQy1ve
N+9c9AupqDira9mO7gm8/DLKnkDfwFGGz8c/p49zJncb6ThPWTa1UXaKS9l3swnz
cuMpSJMIIHNfgPNnUTMWT37x2EIixHoTsIFuURx385OoCOWnEue9nI722sBGdrxj
ZQYStWChOVl3eWjF7LkgSALOXkm0PgNCRbaZ458YqqkyJXOldWSwUl7VJYzC1NsD
Vas3lZt+2p14ge45Yqun
=2ImL
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
