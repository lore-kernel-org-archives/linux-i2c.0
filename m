From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: designware: Keep pm_runtime_enable/_disable
 calls in sync
Date: Sat, 12 Dec 2015 18:06:06 +0100
Message-ID: <20151212170606.GC1530@katana>
References: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56772 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbbLLRGJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Dec 2015 12:06:09 -0500
Content-Disposition: inline
In-Reply-To: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2015 at 01:48:43PM +0200, Jarkko Nikula wrote:
> On an hardware shared I2C bus (certain Intel Baytrail SoC platforms) the
> runtime PM disable depth keeps increasing over repeated modprobe/rmmod
> cycle because pm_runtime_disable() is called without checking should it
> be disabled already because of bus sharing.
>=20
> This hasn't made any other harm than dev->power.disable_depth keeps
> increasing but keep it sync by calling pm_runtime_disable() only when
> runtime PM is not disabled.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbFP+AAoJEBQN5MwUoCm2/fEP/jTTsPBxC/nL08dNSRPARAO+
yBb1ihQ3F7kM2iUNl2QJqYsPbh1k3eLC6Pgzb1yWaye/YLt4BZRZ77MgyhXG5lqH
RTo/hVLDM6FUG4R+/v9mliBs9ZKocV9YymLfCgYXiz6nqHTeguGgScj4DY6OnmB1
2A8WayHnHf8AP3tCss/eX0FJHwU/9H2Dl85IZG8O4ZqmmEVBf5Kux+/kJxarAoNS
NtHq2TYMaP0b8bBgpTOm7l1bVGPlm4+sywM2kPZTBZt31RyScCRk7cVFq4IxvrWk
TRFqCse9V2shh6IYvBAK3OcPHBxnl7rK8ummkHtjNRJ+aIki8Y+I8DFdh/m++OPS
xYtRPIc4OKTbzv456zWZl8ga4HXG5IzrcqPidXSIVNHtNwAaqCT98We/I+C95eDg
HWUptJqtoA9McDrphkxn3ZqBzQ3RRA8FLXusnIVV0EXcxoVKzm7HYGzfp4m+he/d
9jOz73YVfqRqEoGIbVWD7GJ2w4XLJ4Mlp6cMAKSfEptC3p0uC81HWcU9QlyESvKp
GI6wZHkRM5c6P7voG703fdsBgye7DgnOND9DQYrY/nodYyMiPLaPEThMDNchrjsO
XzTSSxZaYPzKbD0gBazNltAFqREzIrRbMb+qDWvBATZV4PYNKxrKgBlMm7NLQRSz
QaFDl7FLlJ/I1Rp6UlB3
=N7Ik
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
