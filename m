From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: Apply errata delay only in standard mode
Date: Sat, 17 Mar 2018 21:20:57 +0100
Message-ID: <20180317202057.da5jyueigjjom5oz@ninjato>
References: <20180314170340.11951-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5803059655258115420=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180314170340.11951-1-gregory.clement@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@bootlin.com>, linux-i2c@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--===============5803059655258115420==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n3jf4bpcppfbcwwy"
Content-Disposition: inline


--n3jf4bpcppfbcwwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 06:03:40PM +0100, Gregory CLEMENT wrote:
> The errata FE-8471889 description has been updated. There is still a
> timing violation for repeated start. But the errata now states that it
> was only the case for the Standard mode (100 kHz), in Fast mode (400 kHz)
> there is no issue.
>=20
> This patch limit the errata fix to the Standard mode.
>=20
> It has been tesed successfully on the clearfog (Aramda 388 based board).
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Applied to for-next, thanks!


--n3jf4bpcppfbcwwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqteKkACgkQFA3kzBSg
Kbbtkg//ec5kuA2r1/YJF4ON7wc5bWgpPmExSVchPwoiiNvtWFG/weWxZHdw1TXv
FKSKLGARwi1jJ8vgSi2PtgSlo7U6OA94lhNRpP1wQzGNJJxNW3rGwIJ60BPG4/0O
0y0DIGsZx0LlZbtJmsLvAVF1PERCJ1b7VPCe4gXMiJMlLNzoq3uBgYVlYzWaJtuo
iKaQ8Ffmb1aZjXmco5c+JUPFaynDYUraigD1pJ26+XF19ubS9IolBpBwLjeG6iqk
SDT4rTAMCb/lEpsym53lpHTPZ9rpoGdZKnG2mEqPwzE/iSMM2OR5vP4Y6yKk3SoY
cWSCn7taYdwj8SEloz43ftmIj70UP8OFqtvf2zJUbMByDNtqePvKb+addW0heDE7
uBZ3GnFDITaIyP3Jo6yOER0wVlEObochJyCvwcfa+aMZkM/u+v/DyE03AxyWPKpG
HBX/thEKX2kCy1HT3S1Ld5HzUmzY93Y7RsalwLczlq8TW7h/g0c5Okpj1CV3wVia
dNt5SzYcE6rP+wjmWWQu7r0K6AITP/IoBOQGfOUJ4MNEJ/OXLxJxKh6bBZavqpEv
38tfBcXYRKz74+Pi/64SIyMOieKOHMq/NBWDTFGhNnf/79/3jyZfkFJT+kzNb6Q5
AB8vGpZSzdeZ8uFx835UUwyAMyQ8iF5Z4msRyFPRkHo+WWWKMUk=
=0eIg
-----END PGP SIGNATURE-----

--n3jf4bpcppfbcwwy--


--===============5803059655258115420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5803059655258115420==--
