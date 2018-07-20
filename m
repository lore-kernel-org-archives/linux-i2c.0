From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: davinci: Avoid zero value of CLKH
Date: Sat, 21 Jul 2018 00:18:10 +0200
Message-ID: <20180720221810.67tcrphiu5xuudam@ninjato>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
 <ab965f1d-de6c-75f7-9ebd-35d31ed3de18@ti.com>
 <0c29ccf5-4077-47a2-e7e0-c89ffcf8cb0b@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3798323141560924087=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0c29ccf5-4077-47a2-e7e0-c89ffcf8cb0b@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============3798323141560924087==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xtvwzfx3xciwy4mb"
Content-Disposition: inline


--xtvwzfx3xciwy4mb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 01:43:46PM -0500, Grygorii Strashko wrote:
>=20
>=20
> On 07/17/2018 06:57 AM, Sekhar Nori wrote:
> > On Friday 13 July 2018 08:50 PM, Alexander Sverdlin wrote:
> > > If CLKH is set to 0 I2C clock is not generated at all, so avoid this =
value
> > > and stretch the clock in this case.
> >=20
> > This must be by observation since specification does not seem to state
> > this.
>=20
> It will be good to know (mention) on what hw was it observed?

Some more info would also help me to decide if this is stable material
or not. Is it a bug fix or more theoretical (but still valid, of
course)?


--xtvwzfx3xciwy4mb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSX6IACgkQFA3kzBSg
KbZgXhAAoRxWHQhtKscDrSqORzkVrKwiySmEg1O/4Y7L3MR1E7QamCHlbAWIBbX+
wQMfDhuy4NZJZwClT1pzYsfydc+uBV23FUFmZ7ab32/3B59jqbx8DscOcmf0in3k
tgozleAnBW+3UQtbnAAbSP9WPpgDrmHAbiWjGfIIutWGgRT13DQFxy9au5C8vuEJ
lvHlWwoaa2vhO4Z7nBh0+E8+eVw9Gs8e8jPT9sk9C87AqsXZAjtzW9Cd8B+qAZvE
2kdRurMZrifPwdZGG06ZrlqB6wIfPhNpuvXt5Xgsjqa8zLS/CjdBTlOYf+AEBGm3
Ywh54dilOdNlG1KymNAcEMk2iIujFMwTXdCcAdWgjvl8ANCLI/O3mhCo9nsBwrpV
34WVJvid0/vs+iBw/6el9VTfUXiuHg+BaNJ9sZSEtfeuuJEiht9n8G0L5bYLizDY
v7ZiM2VD9i/V2H2RDDfQ+7x/qG4ES9SIl6jePm4jxrqIWFzgW3Q0RGD8N71rfYT5
qDu0vcLP8peFe3rDbxX0Sw4pikiz0QlXun9VfZbqaGptAMM5TjTM4CH6bMZ2VE9Z
4g4YiMddrjAxuJuaG5UrxYjesUkc5iX3JROjzqq3qjQV7pyhmi46UMOVbu+yOPq9
0IZSiSZxwv+aMMaxe2KkF00v0QT7f4bzNRhEZ7sX5KJX6DQUitI=
=lJsV
-----END PGP SIGNATURE-----

--xtvwzfx3xciwy4mb--


--===============3798323141560924087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3798323141560924087==--
