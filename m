From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
Date: Fri, 15 Apr 2016 19:58:46 +0200
Message-ID: <20160415175846.GA1533@katana>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana>
 <5710DA28.6010104@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5710DA28.6010104@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David.Wu" <david.wu@rock-chips.com>
Cc: heiko@sntech.de, dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <wdc@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The default frequency rate of function clock is 50M Hz, it can match
> F/S mode, but HS mode not. If use default rate 50M to get 1.7M
> scl-frequency rate , we could not get accurately 1.7M frequecy rate.
> The input-clk-rate is more higher, we get more accurately
> scl-frequency rate,  as 200M is a suitable input-clk-rate.
>=20
> If 200M was used for F/S mode, it would increase power consumption, so
> add a option that could be configured from DT.

If I understand you correctly, couldn't you use clk_set_rate() depending
on the desired scl frequency which is already described in DT as
clock-frequency?


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXESvWAAoJEBQN5MwUoCm2G9AQAJcjsZuJNHdNkH1geCWm00xl
Ax4nIzTV2hAgIhkFfBup6XUOkOuEr5Pj/dbZ3HELNg2UovyIo4CmIENpYQVljHzm
xBxodVJVBswzOQ4RzPRJj5AO+G+v0vPVTfOLAQEagLlTvb/h3FCBmVTc7DEvt2QG
/tcU1fgyHBC0+3FX+UVmHKuYyJywhK6P+nPPGEfw4jHn6nF6hFpkj0oOibNfVmOr
NjWJMycBrGiGpbBsc36VFqY1Lo/RbruawDNHY4OKj9Zl5f4cYryRM7V4uzNhYquM
QvLhqTvOKPUbw1HsFnEY2ilOQC4bbS9oESWlf2Rf0BNHm0YOG7RiUvwJMBFazwM1
nxRBZWb+gtzxi1n2wSC+rTjXlXBND8Fl+GA73YaS2GcQAnfcftvhDwJdBixdbh4J
1JMvdKEO5F06f2/hAPno7Ixa+FCieOUId6YyhVBYttqE69I/ooEJ2YxHS6DYEhji
5uqOWTDuvEzRuUal+/bIMs3M0dfmQza9c0v06z+p4caW/Qeb0O7Cl9OBYTRIjhoY
N91sXlWMso7Kqr584Ffc7P2PiqRdKEZ7vCiEV0KeX02Axw8uL6YL41ywIY0EYfvM
veL56Oku9TDnku8eOFAFTjl1h4V0qqQ2L2sS+fiQKoK2k9muE/aA/YyR9AZcS2Pe
W3XAWW9I4uwQjcmBh7Yf
=Gcqt
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
