From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Request the SMBUS semaphore inside the mutex
Date: Thu, 9 Feb 2017 17:13:52 +0100
Message-ID: <20170209161351.gckg3l6ooypifou4@ninjato>
References: <20170202191516.4476-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tlytu7k5og7lk7wg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45379 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752376AbdBIQOK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 11:14:10 -0500
Content-Disposition: inline
In-Reply-To: <20170202191516.4476-1-ricardo.ribalda@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel


--tlytu7k5og7lk7wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 08:15:16PM +0100, Ricardo Ribalda Delgado wrote:
> SMBSLVCNT must be protected with the piix4_mutex_sb800 in order to avoid
> multiple buses accessing to the semaphore at the same time.
>=20
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Applied to for-current and added the same fixes tag as the patch to the
resource size, thanks!


--tlytu7k5og7lk7wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliclT8ACgkQFA3kzBSg
KbZz2g//QwAoIRPUfJtAQCKh7mzauKjDjn7Sy6z+RCiKq5Ljga6HQKGLWHOkuD0n
EiDxxDbaVR71Loc8aJsTt9xZIG8yOn+idCUvfJegS/OaxU8FzrHhdS7lFZqAWacH
eQ7aDH1/E6+K2DCXQcrRg79RDn7a6LJm82z3v1ugn0/L4GSycHW0UDCpcdCUVgmb
yNKkDCEnD3O9ILfoEo3n34HlMcuVatkuEX+WbRfwTEWi1wagWEta7dPAbEP2OX1F
pEHcExI5ET6/Oh3yw4QXFrsvrYL4wKGMbte6E+u8ryP25FkePEvyaGsSh+nVeSo7
L8iT8xHY7izY0ov+b0ZK7q4q+Kx4mvee7RZvECoC1cCYcY9UWshTMmWFNUO9U80D
rHRnqwf3PsAe0adW3MSOlJUd3b/OnOGbCLA8QlhCjsOjOP6vMefCqEKN5WuRQXY0
97Te4j3lWaGcHb8LioCOEbEGbNB6kDBE+6WewKrab3FO0lGR212W2zS5sSoJDDk/
qG85kvXFLy5UWtbcn23juE99qw5Lcysfv2HB+qJAvIMo2ArqfXJNyNLD0gFN8NLp
YpW4vUpEBwVzIpxj7g7VapyMyURedoz5dKXCc7ZID8EZFl2H0b3kiWgRMkh8cw5O
B9dMMDYcP9RMOxnGup8BlxxGFT3L4knLLbdBrdUUXl07aE9W5CU=
=MZ/t
-----END PGP SIGNATURE-----

--tlytu7k5og7lk7wg--
