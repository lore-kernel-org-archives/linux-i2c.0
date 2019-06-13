From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] i2c: bcm2835: Model Divider in CCF
Date: Thu, 13 Jun 2019 09:50:35 +0200
Message-ID: <20190613075035.GA952@kunai>
References: <20190529042912.12956-1-nh6z@nh6z.net>
 <20190608171443.14484-1-nh6z@nh6z.net>
 <20190612104107.ndbo55ii2w3ahtzr@ninjato>
 <2E838B63-DD8D-40AC-AA31-7C0FEF8B4424@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5415126838266335312=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2E838B63-DD8D-40AC-AA31-7C0FEF8B4424@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, swarren@wwwdotorg.org, NWDR Team <team@nwdigitalradio.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============5415126838266335312==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Applied to for-next, thanks for keeping at this!
>=20
> Thanks for your patience with this.  I know it=E2=80=99s hard to deal with
> newer folks sometimes, but I really appreciate your forbearance.

For me, it was not hard but technically interesting. The solution to
have a CCF driver embedded in a master driver might come useful in the
future again. So, thanks again everyone!


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0CAEcACgkQFA3kzBSg
KbaNzBAAhtuYUWBJQnLoUF/+8qEPgUSZwpVqbMV50CdW2Pxy58COjEmlVe/uiqvh
BfTyj5kSdSwqtp52oSILSpMXYzEoThEY30ssv6nARanw/LmMc4/VJ3lOtpuHL/6D
im9o4osWaUfcBJKmOChoZQ16gB5C0iYUhPBsi+IEq3Gy5hv/cE0CDGHmNC4yv3Zs
0o4uUNtQdlamHVO2pXGKeUavCqM/2qZvhI64JCFxuvL1H72FCFAo1bePRyzX3VNj
2ZL99io1J9VqUeIg7FkwfwZA/On6ngtC16tFNXsgguVeBlRrwZXKLMribxWwkPlO
6j9aJ9dk6zXLvcKT0CsFSw7NAW1ltr4g1rPTSA8n5Jy6289gtDhmpb5dghls6R2X
2ocSATm8q8kpPRIhl3UNQcjvLwkRD7J2KK57wH4GI6gqnpyRwT32V1O4vTJCJeoA
o+L8bJSxdfSTq40VQC7IdSE0XnsddhFuLVlPebiQK54XTWCxdAYKyE1PsM7n7Rem
akUDVH2FHBK3dMWZJGiVoJNTIVtvAW8HTBwTI72nsEzmaLUZUIqT0uyxDicNWXtc
xKP6HSgRwoEaMBhS2SiZT5HfFXZlzN2uKU4WlwGXSdqjKg4Jv5th19FtejmZpEfh
7hdig75Xj8Pe9INcHyjfqKFZcDvUwuwa2KudNjsdxd8mEqQqFzk=
=5B77
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--


--===============5415126838266335312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5415126838266335312==--
