From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Tue, 13 Jan 2015 10:57:26 +0100
Message-ID: <20150113095725.GC1059@katana>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
 <20141124121555.GG3733@katana>
 <1417096856.12707.59.camel@mtksdaap41>
 <20141127164536.GC5667@katana>
 <1418352022.4994.44.camel@mtksdaap41>
 <20150106133753.GA3754@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150106133753.GA3754@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Liguo Zhang <Liguo.Zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 02:37:53PM +0100, Wolfram Sang wrote:
>=20
> > We've started upstream work for MT8173[1].
> >=20
> > We've fixed these issues for new SoC, and we believe it is fully I2C
> > compatible now. We'll add mt8173 support to this driver, so this driver
> > will support both fully I2C compatible SoC and the current one.
>=20
> From what you tell, I'd rather add the MT8173 support incrementally.
> Let's get first the limited support properly implemented, then add
> another controller.
>=20
> I'll send out my draft for describing the quirks later today.

What do you think about my two proposals?


--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtOwFAAoJEBQN5MwUoCm2EccP/RS4dHJuEzMWgB63gBreS80V
YO0Xtq1BxM4Q7yDuHnzKVHF4K8rCPbxRZNgpx/xQBOyynE0ZpM/rqnNShRhMty4H
Pl+pr0aG5++hw5zOP32yoaEJtJkzP9US+FZxKphnMPO3+vpqSZvcXQNi/HVcG05c
6WepQcC9YM/bRcQKY79tHvyH4E1qvs0MaX0GYESC9Vw07KQa9tlg38LLkqvidTC7
BYjjrVuim98t8O4BtxN4O8tPY6ASCK5WA2h/IpKQOyWKWQQXI4R/ZqELLF2y6WtR
vPkD4tgQVwmPe67K5rTmNzEv5EgI0GFb8yXXK7BZVdioh4+5db2oFWKYAEE0Xdsj
KLMYgwgvM9HFG63vffqSpXvJXybNwJgTYRTcU/sEtBGHvC5VZUxsEyi2WCRlsEoJ
ULbGZtHRJ4SwBE0nkpKLJCBYO/KnxRcNBFG/vKfnR1fh9UN1pQeLzZlTunrcO7wY
GxclcKMU42mn1y8iGTT+fBB24xc+oxnclqXw75/8BzK4UTskshVbgXRql4WdPRrG
PoFh8OaMcKQmO9QCDqWm9yWbwdScVdcU+S9qK/KhLKUCS6LFMy6pKML+X1+w56iN
M51V91A/6lhBqSDx1pZkm0HpwHJJEyqNTCpvMAf68z6ZHvAswolSl4O2Cu5KgKvZ
pmYlTBo7NbEbt9CmIROC
=IYs2
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
