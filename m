From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: ismt: Use %pad specifier for dma_addr_t variables
Date: Sun, 31 Dec 2017 00:22:01 +0100
Message-ID: <20171230232201.fzh6l4tqxvvagyi4@ninjato>
References: <20171110183358.86100-1-andriy.shevchenko@linux.intel.com>
 <1514474511.7000.422.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ozfgu5nw5i3lo24i"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:32878 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdL3XWD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 30 Dec 2017 18:22:03 -0500
Content-Disposition: inline
In-Reply-To: <1514474511.7000.422.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org


--ozfgu5nw5i3lo24i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2017 at 05:21:51PM +0200, Andy Shevchenko wrote:
> On Fri, 2017-11-10 at 20:33 +0200, Andy Shevchenko wrote:
> > ...which takes care of proper format and size of the value.
>=20
> Wolfram, any comment on this?

I was leaving this for the driver maintainers, but well, this is an easy
one, so...

>=20
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--ozfgu5nw5i3lo24i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpIH5kACgkQFA3kzBSg
KbYleQ/+Nl+gJzYyO9L/HCrUP2Veh/C7RUxoYkb0DfWsDK1gSstClUYVEfRe1pah
Yk/LgcmaluxXNsEuhJ3GT0n2wfApLsoSfb5Pk3JxUY/G3mNp17RW2dNJVFTxVeq4
hDGLwRS/2y1192F11zftfQ1daD7GgmnwYIGInjDpe13YwLPg4NPk57A0laHEnOMe
jdHaBWmXAN9HS3PeQDkF63xq4H+8lbmeSZb6LN0NjDZBwVEpOia7w1yurSVQ+s4B
dCM0Bbk3hd77dp00ZNgVwjLUqPdTahfdcOJ+5dld85ScUuKlp0U/jKxyzLV+kBvs
GyepcuJOR13lBqWhg8+HsFTKhlTQqyc0zBNL/vfxanagPu3B92BhfakF5LgBpei8
WYdzq7y8CuUq6fzlkbbF0dnOsA3ccudIKiHzhi7pJcCzd9DpWkeMQKkbajMtT/LK
8z9vCrHaUtQW6QTTCW/M+lwv+reQIQdK5mmbi102waeoSw8kcz0qs2XqEJYyLXXL
I4mAMpXGoSOojknNB03TskDbiiz/eX5E+3fyUzeuTf8aE54bgQST+minsF5937C9
PiqwxfUzvMEfRYQNNtTiKWtwmZ9TNIJsCKd11sutPQ3QDZQscHb1fCBw1dG2jE1x
0/r8nKmYF7F9qVQR5ajco9/Eq1CigCZXdSAj/lbHHXo0ziNFP5I=
=E6fH
-----END PGP SIGNATURE-----

--ozfgu5nw5i3lo24i--
