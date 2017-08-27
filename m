From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND] blackfin: merge the two TWI header files
Date: Sun, 27 Aug 2017 15:39:04 +0200
Message-ID: <20170827133904.vezzq64csnvasiei@ninjato>
References: <20170813142117.3977-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7a3ak7bfzjzr6p2y"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37279 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751347AbdH0NjH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 27 Aug 2017 09:39:07 -0400
Content-Disposition: inline
In-Reply-To: <20170813142117.3977-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: adi-buildroot-devel@lists.sourceforge.net
Cc: Steven Miao <realmz6@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--7a3ak7bfzjzr6p2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 04:21:17PM +0200, Wolfram Sang wrote:
> There seems to be no need for separate ones since all users include both
> files anyhow. Merge them because include/linux/i2c is to be deprecated.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to i2c/for-next, thanks!


--7a3ak7bfzjzr6p2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmiy3cACgkQFA3kzBSg
KbZFJxAAo4yVfnd1pW2YKfN0m9vuXUSNZfE8g07EASBTQP9eG91atBwUneUTA5nZ
OHJzR79F5pj6qfv5pYi+62QVKH6RjlUtI8Q8e8m7Z/IeQmWV6TQG+y/GL1N3YIYF
PTYhN3VEdhcLFfoQRsQcDOodfvQ9l96O8F+5gOeD7lHXMblN73E7tigQsZQmqJ2e
oJ2wm/A5eJ9NjKm7LUCi8ERMxyflfMujYhdxiISgWQyv3hI7NIbmcR3ug1H7Uvg9
kQZCpyJ4N9xYxEqwPV+Q8kVPIZZ3TPOuB89ersuIMCvaXV7tNEerAO0hd30Mg2b3
sEIgN5gIG8VXFlU1qQCfnQT1uHNwHgJvK9yAqFEO9Kv4M63tr0oPieMto0p7td6n
YtfzI5sWRYSRG526uIOtVv4q0vgw8OUyDmqaV1VaBD187y81TQ3wtbh/VPTcN9O4
B6htwOgrvFbWA5YgpaNb3epX7oFXnyny9tUmyLEGIktro4wFpxPvmRNkuotEgB5g
/FjGC0wU7t5uvyIvCp3fm/9b8vcKISRgkE79mIX0/1voI+dqL/8GjTs/Z3hNNstJ
GFjG/pxI2PakQruJgmln+t6aD7vN3KBiJ0VsNWMYlAtqYestyZZ56PmqTNLQf2/e
FmATJANBHOe6NF+vbeBuUdenVir2/l2paIC0h4rAac08VaoIZEY=
=xMBv
-----END PGP SIGNATURE-----

--7a3ak7bfzjzr6p2y--
