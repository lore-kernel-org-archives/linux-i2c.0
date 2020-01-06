From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] I2C: JZ4780: Add support for the X1000.
Date: Mon, 6 Jan 2020 15:47:34 +0100
Message-ID: <20200106144734.GJ1290@ninjato>
References: <1576570450-122556-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1576570450-122556-4-git-send-email-zhouyanjie@wanyeetech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1576570450-122556-4-git-send-email-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= <zhouyanjie@wanyeetech.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org, mark.rutland@arm.com, paul@crapouillou.net, sernia.zhou@foxmail.com, zhenwenjin@gmail.com, 2374286503@qq.com
List-Id: linux-i2c@vger.kernel.org


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 04:14:10PM +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie) wrote:
> Add support for probing i2c driver on the X1000 Soc from Ingenic.
> call the corresponding fifo parameter according to the device
> model obtained from the devicetree.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> Acked-by: Paul Cercueil <paul@crapouillou.net>

Applied to for-next, thanks!


--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4TSIYACgkQFA3kzBSg
Kbao2g/9Fw00CvW6HoZ3t/gz4atSoANS3Fuifoxz5o1oIkdX5o1deWwRWx9zYHW4
OdDQQ/gBwY1s2p+GxbdvPmdp/4fPRGl6caoVQUrm30lS/yrtttAD+90xRcDyD8/i
mb8qKagOYM2vif6eGedidLjK2Jy2ShQCyQJhb41cpk73JjXUpc5jXrdzL+rgU8qg
TvF28Il7HM+j/XXN4DwxVIsDhPYTWUM0rMlbZ/dacLGTnhp5Gz80uzaeuK2VCFIM
t61fvI549eaR/m51elIzDrytokR2S4G/Y6URP9BfhPHGbc/BczKaensAHjxjHpWc
ts0B+tLr16Tlbad4F8qnCk1Upp1O4H/fsq5uGqWcuzeDyNGM5W7RkEHXHiCsSk0q
FQViD3x8RKt2NU91txAcxfIZzv4zkLnWaRETkSUnpNUiqw9aHr8XNNtTccPUsnsD
C5PgywSZqok7pTfAeWeOJs+qNwypnrrCfc33rk1TcqsPHl9zgWMiqAZ77+Zf/J9E
EfmDu8xvf5OG2cTWrXoFkUjN4s0lLsizTsYTovK90MSBBrTFr/zKacPgpSPzqtuX
VX9Efjf6GHM3n8xk8yuFWaY5b/FPyWpJzTqcqdzLGQOGnZu7AyRlGMrE82nEo2sJ
fOyKaUs+dxZKCJSPKsLedgo3DVnfYhPwOA5VGJt1EoqhA5V16iw=
=Gabw
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
