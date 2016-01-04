From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 1/3] i2c: rk3x: add calc_divs ops for new version
Date: Mon, 4 Jan 2016 20:40:42 +0100
Message-ID: <20160104194042.GD1522@katana>
References: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
 <566F5FAC.3080404@rock-chips.com>
 <CAHp75VfkteDvC0KUXOXDik9rQeanTXLn9Qq3wux-0rxk5ZotNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52863 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbcADTks (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 14:40:48 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75VfkteDvC0KUXOXDik9rQeanTXLn9Qq3wux-0rxk5ZotNA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jianqun Xu <jay.xu@rock-chips.com>, David Wu <wdc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, dianders@chromium.org, huangtao@rock-chips.com, zyw@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Wu <david.wu@rock-chips.com>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> +static int rk3x_i2c_v0_calc_divs(unsigned long clk_rate, unsigned long
> >> scl_rate,
> >> +                                unsigned long scl_rise_ns,
> >> +                                unsigned long scl_fall_ns,
> >> +                                unsigned long sda_fall_ns,
>=20
> Wolfram did some sturct to assign the parameters from device properties.
> It might be re-used here.

Yes, I think it makes sense to convert the driver first to use
the new i2c_parse_fw_timings() function and see if it fits (or if we need
to extend it perhaps).

David, does this make sense to you?


--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWisq6AAoJEBQN5MwUoCm2SKwP/RmDlLqJwqYjBwHWSn30Rh04
oYA9z0RQ7Bzdcj5Eq+6bcdfTqsVx4AyxyNZSTPsGcU0/QthiPy5Eu9j8tZza2cT/
tYiKrbK9Lf0qj1qX9kgdiDK0JdY3e7fLxdmfacM9H616BdBwunmhKOGp4WOJyJkK
xYaPrWBRZQsAx74u5Nv+2bwaBsKEIpOJ6CUu1CeYk9IB4sk9+DZ/GrosSEp1z6tR
+fqRPwhNuyIFI1utO95DtkOoaxT+pFmlRN4olrBw5jitXuJofqTcqnPi6FIvY7hZ
nE1I3GvgfazMJeVCr6zWweMLFbNx4BInsHN9/vicXWZX3Jz5MPJkarNT9SxnYOEi
VD2XUqsHsvkiacYAraL84hJBWf3e4FKcg00mA76LiiqPwYVaT1rsDG7TCEOicgGa
BzRtj7WqtmRAznCOvaaJ0PWHJHdaZtCOH4xVp/2bywIlg37XVKxAHtXNpIryn2xH
pHoDKyTBhEBMmpkRaO4iO+/tKk17ofsOFWVeOV8z8/uL/90vsM1Fw671vDldD0mu
4sSO52pBVh+gFgDXU+e9MIdtGqu0tdPa7deEVeQSOu4lZnk9XWMHcL4BAIU+fJnt
/j4fWsttxW1bqlMjZn2yei4efvZrY+0pUk9swXQVKz9r1BrzNuBQPsZBYwdjJuEP
7iL0PeOG+LIfbQNwgMW0
=i3gV
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
