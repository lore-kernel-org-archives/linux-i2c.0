From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: w1_ds28e17 driver for the DS28E17 Onewire to I2C master bridge
Date: Mon, 19 Jun 2017 22:15:17 +0200
Message-ID: <20170619201517.sl4iqhcbvjarzk53@ninjato>
References: <00c6d284-33a6-aae8-688e-801c7c62c48f@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="niuxlzs4f6dyekl6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54602 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbdFSUPS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 16:15:18 -0400
Content-Disposition: inline
In-Reply-To: <00c6d284-33a6-aae8-688e-801c7c62c48f@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--niuxlzs4f6dyekl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> It's been a year since I submitted the first version and there was no
> further feedback since my latest version from October 2016.
>=20
> Have I missed something or did something wrong? Is there something I
> have to do now to have the patchset accepted?

TLDR; - I expected the Onewire maintainer Evgeniy Polyakov
<zbr@ioremap.net> to pick it up (or to ack it so I could pick it). But
maybe he missed the patch?

Onewire is a bit special because in its directory (drivers/w1) not only
the master drivers are kept but also the slaves (like your W1-to-I2C
bridge). And because your driver goes below drivers/w1 I was expecting
that Evgeniy would pick it up. It is his realm. Maybe he wasn't on CC?

=46rom my side, the I2C part was fine, but I obviusly cannot review the
Onewire part. This should be done by Evgeniy or some other Onewire
expert. So an Acked-by: from one of them would be good.

However, your patch 1/2 ("wire: export w1_touch_bit") really needs to go
via the Onewire tree. I could only pick it if the subsystem was
orphaned or Evgeniy really wants me to.

Question answered? Sorry for the delay...

All the best,

   Wolfram


--niuxlzs4f6dyekl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllIMNEACgkQFA3kzBSg
KbbfcQ//e6yYN2uyAzrTnHdFT2vZdehDK7Stg4baT5WNfy2FrqnVr50AvNUqNSN0
XxWXF9MYV+P5f59WacibDLJIf5bIUKK913FFMbgfe3U9r+dA3iYeAHVwBbSOVP9p
BqpDT1YDBpVl5Y8vmWSau9HEk6s3r5fN1CDHEX31/t753RP6Dq8JW+wS4F3slXdM
8tj5PpL8eO7TsXwqGxSLPNOBSTR/c5q4EYVt2wJg3frD8wcS7H5v3RTJ53YVLTqO
p1Z9q1wFl1uhDhH0OJMcI9abfKz45w77BnkOdrjjVsPighRYX20IfWRrn59p0kZU
ZvQgH+7ygqNGeBLdy4zSLolfzB+WKo7Zv+EZ0xs5ajGpv5NiIypxk87d+CUnc0p8
GAj1+fmslHtyzreK6N90O7wBcYMbmWCYUtNklpQlju5u1iudm2/ZJaF855LSpwpD
vIVzXIqZzVfJPe3DgzzUFIzXlMZBNBgcEzKwfNPmaHbaO9cpkplBW64834m1ZFQf
oYE0R2hiEejwdsnyIjjP8oQX/IVDoUlL8jukc2XITvmsJ19UszHREzeLr7ALi6L5
yj7iIYugi8I65xMIsWbO4JC+kpbtKjuFW+OuFanFcUoJX4uyA3kQ2598PN8jGyJm
WEiQJmYCBm1TUOyk7GXBU+V3iBHslyQMPKHy8vqz2oN4+1biN6c=
=R76S
-----END PGP SIGNATURE-----

--niuxlzs4f6dyekl6--
