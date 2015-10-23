From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-dev: Fix typo in ioctl name reference
Date: Fri, 23 Oct 2015 23:25:07 +0200
Message-ID: <20151023212506.GK1520@katana>
References: <20150908110549.411e99a8@endymion.delvare>
 <20150910180012.GA2893@katana>
 <20150910233036.0d2c9f35@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBYU9MM4gf8jKg2V"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36979 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbbJWVZK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 17:25:10 -0400
Content-Disposition: inline
In-Reply-To: <20150910233036.0d2c9f35@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>


--gBYU9MM4gf8jKg2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > -#define  I2C_RDRW_IOCTL_MAX_MSGS	42
> > > +#define  I2C_RDWR_IOCTL_MAX_MSGS	42
> > > +/* Originally defined with a typo, keep if for now for compatibility=
 */
> >=20
> > I would drop the 'for now' and keep it forever. A define doesn't hurt
> > and if it increases backwards compatibility, why not? I will also do
> > s/if/it/. No need to resend.
>=20
> Sorry for the typo and thanks for catching it. "for now" or not is up
> to you, my idea was that it probably wasn't used in user-space yet so
> getting rid of it shouldn't hurt, while keeping it would encourage
> people to use the wrong one instead of the good one. So on second
> thought a better strategy may be to NOT keep the compatibility in the
> first place.

I really don't want to break userspace. And since this #define is in the
uapi headers, I rather be safe than sorry. There might be programs using
it we don't know about.

So:

Applied to for-next, thanks!

> can be reported to the user just the same. IMHO I2C_RDWR_IOCTL_MAX_MSGS
> should not have been made visible from user-space in the first place.

Yes.


--gBYU9MM4gf8jKg2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKqWyAAoJEBQN5MwUoCm2L4gP/i5oG9kt7sLGv7Y2xZppxEd8
kFCmuEqp1f5+46YoWxeghiP+1M4vBtwViDU1tg+TFQJeoGq6+trZ5niHnNwc4nsW
A2CqTCwuflmUtZYBngIjjR8iMAzNl0NAz2h/SYpzhq/JAbfOHUaswFNaab9t/9la
tsKrPWmPUOTRmLdKGYcqovAtLhouBG7m2PjDsJPlRln4obyZi1kCSM5MKc4w+kE0
1eV/ElJI6MrB8Ulqlm2CYY0G94I45DD/MjE7Dyk5BGQYUm84dpbN92dxeopvAJgk
B+/Dp1YxCPr+tIUGHPuJyXzhUGxh8oHwwBqrSoBA/5keLjTCo0kfcl16WZN3bmer
3v/Wnq3ks9ohg4nN4/KRIl71dIZKg1iDJz09+XsfSs7pW1O2A1fb+n5rnjdRCviW
3kTzKqwdjPalQM65cPCFKfut7IgLEK4Y6B3V3d2s9srbgtCkFu6UeS6T3sCxgOC4
X6hoyRxDSSAmHCLHSq+qCzGrtEbDKi09/uB8DRTEtOeb3JfdHWLfjUOb2KYejl4T
IUcS5WLkX0xydtxYT8AX/v6zcYhFFQ0djEEckOq3DV3L7fSkYN/UoqfJFDljaS3t
13btnAlnWMZGCUF+xevuzouOB9rpDBy8RLUr1v83UzbBWupqJHEhnka5BVdi626q
BZ5ygymD/kgk6b1qSxyL
=Q/D5
-----END PGP SIGNATURE-----

--gBYU9MM4gf8jKg2V--
