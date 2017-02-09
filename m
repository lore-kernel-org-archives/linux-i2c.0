From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Request the SMBUS semaphore inside the mutex
Date: Thu, 9 Feb 2017 17:09:26 +0100
Message-ID: <20170209160926.fmxmnjb7oqf27pww@ninjato>
References: <20170202191516.4476-1-ricardo.ribalda@gmail.com>
 <20170203161739.7264f85b@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x6wbq47qzmz4x36l"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45399 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753276AbdBIQUS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 11:20:18 -0500
Content-Disposition: inline
In-Reply-To: <20170203161739.7264f85b@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel


--x6wbq47qzmz4x36l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jean,

> Thanks for the quick fix.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

I wonder: why do you use Signed-off instead of Reviewed-by recently?


--x6wbq47qzmz4x36l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliclDYACgkQFA3kzBSg
KbYzNg/8Dg/fRLsSAeEYFX8zNm0H3jipnL8t/mOfwcPsiC0+kavrWKP7HHNAip6i
oz1ROYzbrN58PGrln5v0+7Ml3QmpswTKyQ2TWpkiZ4e5vWjCBdYoQrW8M50bBX22
vPSI0q0GQNqS2k+LWCcVwfT/uFJPORS6CZt9hsETiVgLFw9A5ZgAHqQEvxfgXAGN
E+m0kokf5kGvfHenvYXF0QrQ4BBhxvvTiXsDJi2yQJFrccIu45JMZmQOnVFQAXGz
iwN3WAJuAzF5VfyK+MU3WQJOph+/kHTszJEBz4GKYrD7Cipg6ssBKh7URjBPrS+L
hKAKO0hYWgF4r+uwHqYjCascxKSiQ3rICa3Pkf9OWgmo6sw2OCn+KKfw6SVrW5Ho
1uxR27vUq11jHss4Lp3hKMacbQ2aO6jlYVkqaqFL7z9q4EYJAG3Q9BkU6Sb5INZ9
geccn+Ivl7yhq/LiDQ7B9lQGLIJW6U7uE2Nrx/tJ55cWFNBM20vjS8S8vK4cD6Kl
BoCzGGAK3Bm5x7SYXQens5JpT1CfaQ6FCWaOMzwqDasZIljBp+Yw15IRkbZRxDXW
FOvYnRVx1KNSqpyCMd6k6ePkbvESq6oZVO2KUWPag9JpmFpsxDeV4e0EltuT6TnM
diXzmAE5o/BQ7Fa5fzZPGVkh9Pe1h0tszVITtwTW2c3xUPGHUvs=
=Cx6q
-----END PGP SIGNATURE-----

--x6wbq47qzmz4x36l--
