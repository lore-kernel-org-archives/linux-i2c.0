From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Add support for Intel DNV
Date: Fri, 23 Oct 2015 22:11:14 +0200
Message-ID: <20151023201114.GD1520@katana>
References: <1444740099-137792-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36697 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbbJWULT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 16:11:19 -0400
Content-Disposition: inline
In-Reply-To: <1444740099-137792-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 03:41:39PM +0300, Mika Westerberg wrote:
> Intel DNV SoC has the same legacy SMBus host controller than Intel
> Sunrisepoint PCH. It also has same iTCO watchdog on the bus.
>=20
> Add DNV PCI ID to the list of supported devices.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-next, thanks!


--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKpRiAAoJEBQN5MwUoCm2ucUQALT3yrM7NqxDu1pPRVMPqsev
aE4ierjIyu6OWdE47ZB4q3QkjxXqCjzC+gTZj0Tro6JaLBBHU8ni5eBMkH8MVIBO
lXnp+OgJx+pdf4dP04kvjHMxIpWQ4tZ87S2/eXokC1CRZcXgSjkdUTqWpcDUMjM0
lGk2zDK5G/eNHMCfFLdE7YS8ZvDRfalDqsOpmbkAcmERdQWDKuy0JgeLWIYDpVdb
THF3JLgK5YuiRR6yfOh4vy88KB1JL198qA8xbT32Q7yCOcWlBLsjd2DD47y5BgrB
SkDKhPwCQms+9ujkvqJHzP7xRqyKBazfEt1e2S3Tkc0+5D52ebs6hmWZIwJ6yfin
6wimsRBtDfMt2bixHvaqjKWV7oB8QR5TGN6YhcHQ/2KLb4ZJ7tr59sPjWpBqshdf
3vLdvfXuO9ljGU3kkIXK+REA8YCDs1Oysb8X+a/kAHIAUkv5w41wLX4p8abDdJyE
6y4TXW3BBnrt+R7yMLg0DxVqnWtvbpKibwNUBA9Vupnk1vMu/0Adt6JxqsUEYDQ9
QDL/RkOXnkpakPtpAu/PKdGNpIUnumhMdsui12ba2dpr8IRmMT6/YJwNuI0V2IQH
Sx90LHDbIAQAg9hou45b3V0aVw1/9E7dc1euOfJqHKW2saBGBdi2zonAptj73ZlT
+3ROygpOD7KXfoun3UCl
=bIon
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
