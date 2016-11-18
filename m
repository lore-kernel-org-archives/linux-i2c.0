From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [v4] i2c: designware: Implement support for SMBus block read and
 write
Date: Fri, 18 Nov 2016 02:07:12 +0100
Message-ID: <20161118010712.GA29479@katana>
References: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tnhuynh@apm.com
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2016 at 09:56:33AM +0700, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
>=20
> Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
> However, I2C Designware Core Driver doesn't handle the case at the moment.
> The below patch supports this feature.
>=20
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLlQ/AAoJEBQN5MwUoCm292cP/02sOAt7C2Fcok184dQ9X1mc
YQgaE/og1Uj4CYzN6JLvg9KAxsuIeuBpRMRvyaObGkia06ahflh8ews0ydruVjwt
INL1jEQQbaoac6qoRS2Yj1pkvKesNm0i6wM6ZYK/3S4yjSl4aXgQcPr9glW78Q7F
7ck+099rndIRg6m6VQ9KRrmpSLeT1q+jIXDrUlwSd/KU9omndLva2ruhV55i9nId
UfMuAVRJBP1l6ghxF+EKm5TIMONk9AJLxjK59kMObhIRxiWFn889gDr5pcFW2OiP
J0s7+Mxx4lziVj6fqDHU5aWEts9t92ufgsitgEtQBZ5QwfRXTLKYGxY5te43JNQ0
ZTzYtZC7nEaSqdxzaoPG81F8DNsPiPeB7kCIGETz0n2SXNS0NDdTayGaWIOlFWq8
0wY2nX6G5Uk71LrCG1m6PbICXNqDRZH9iPg6jKEQdz7gTWRylrnvnfrXRVoNsxOp
UadK6OgxeHETwaobNTsdOoacf5rKauS94E/VQMPVfeB6FhoQ84uAv9w5UUuho091
jgihVVPBkDiJnFppLbdilOLszh4zyf028iK4/85hsTyTuqzLgtqvON8IGYIpB+Wd
xsjpydfFjP5bqLWNnlC8+YL6d6P1i/8+BRZSPgOHd6kKqvwLlnmm9NbabG54xZjc
L7R3JwKIPjrN32jcKIuo
=do+p
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
