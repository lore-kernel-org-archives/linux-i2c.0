From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Question] When should a driver issue STOP condition?
Date: Fri, 31 Aug 2018 11:53:56 +0200
Message-ID: <20180831095356.ow6nhbx2fhhpuhjj@ninjato>
References: <CAK7LNAQO2aYLrtzg82jgKdKcOw20rNWBEY3DrdLcwOhnF9aa3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jgijt6335oqjvkfa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQO2aYLrtzg82jgKdKcOw20rNWBEY3DrdLcwOhnF9aa3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--jgijt6335oqjvkfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The problem is, my driver is forcibly setting
> STOP condition unless the next message is read.

This likely is a problem.

In Linux I2C terminology, a transfer is everything between a START and a
STOP. A transfer may consist of multiple messages, connected with
REP_START [1].

So, a STOP should be generated after the last message of a transfer or
of I2C_M_STOP is set in a message. The latter should be super-rare
because mostly you should be able to use multiple transfers with a
regular STOP instead.

[1] Slide 8 illustrates this:
http://events17.linuxfoundation.org/sites/events/files/slides/ELCE17-WSang-I2C-Fault-Injector.pdf

--jgijt6335oqjvkfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluJEDQACgkQFA3kzBSg
KbaE1hAAhWCwQM9Y2aMYi5XGZ0dXtNckOcIguxxp/Cylt7DuBWdddTwMo/O2TodX
kWIw7/N3NPcvoNHkx7UJAl1Faj0yrT917d08IwZo+gAxu3bGcHiRSGu4TYbMEzu+
beJ7EpVn0Fjss0GxyyxGJXDrk8OilQF1KYZTQYgOvS8WmyA7KeQ7t1gC2y0ggsTQ
un+1NhwATSuE+MJo3narU5jhIiG36tAA/ngEz8R7i0xwkd+E+XAg8nErebKBrX0w
I6Tpir98Jt9O/dlzD/HH1BedoFQnIUZpNATlySm2Mwc7sR3pz7E0EZWOGVVTKOGU
XONLTzG4YGr/zgIOkHcBrGpCoBCG82UWTykI1TJxfagBz6BKm80e3QzjKdUlBgJ5
yyuHx/8mWXOlWUbUxmc2vVMCy22DZxuZanKgBShHNyk6uN6M+bBjgWtIfzBNZ/t2
gDFpiBZF4PCSEsfV/lToK/iz+sJ9FxSHw0dhJcdaHLo5FtlZYmEkQWzdYv6Wj1w1
Xgh3kOcJZzUN2dft0mTGc2Rs96cqdBbtm7mz8NyQogpisYU5Hsj1+i5yWa/z3mlk
pFGFfgC14czHMWZqC1Iiv3UGH0ChE0TzVTTQ0u7H0B67PKo8pXSC0hq3lRfk3/XK
yV/duAKKCFMkQEIBTRg3wYmNiXrAisHTQ9mriBfMv9EYdpkRI/w=
=frk5
-----END PGP SIGNATURE-----

--jgijt6335oqjvkfa--
