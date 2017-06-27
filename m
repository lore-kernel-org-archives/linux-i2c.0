From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 3/4] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 27 Jun 2017 11:00:42 +0200
Message-ID: <20170627090042.GA2408@katana>
References: <20170620211516.13095-1-brendanhiggins@google.com>
 <20170620211516.13095-4-brendanhiggins@google.com>
 <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
 <CAFd5g45=O2_MgfZEkmbY-=ZZY+izxeWSuhZT+B2e08P=O+WEog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFd5g45=O2_MgfZEkmbY-=ZZY+izxeWSuhZT+B2e08P=O+WEog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, gregkh@linuxfoundation.org, davem@davemloft.net, mchehab@kernel.org, Joel Stanley <joel@jms.id.au>, martin.petersen@oracle.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > If SCL is stuck low, how do you want to send a STOP?
> >
>=20
> Fair point. I should probably drop that in the future and just do a
> reset, and even then, doing a
> reset is probably just wishful thinking. If a slave is holding down
> SCL, we are pretty screwed.

Yes, you'd need to reset the client device. And that has to be done in
the client driver. I wonder if i2c_transfer and friends should return a
specific error value in that case... need to think about it.


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSHrYACgkQFA3kzBSg
KbaaZg/+OzB7p9eUDVCwaxNXXlYulzEa248dNyL4zHlmnUn04JU/V1pjh+Pu8x28
eLk3uUmheTL881bqWWVBShng9FKUebzEIFAAKdmozlNCF+GGg/Ptb7Y7iri7VRA3
f2RgivnTWhDg0R0nU4Hne2WHT7AVtIr3LUI4SViWK4+4sJGC0ngd5t2kYIateNj8
r7puuQYbKL27hvEY5H1oGCtWUZBgQmi6cNqeO1KsqQm6t7o6Q2cX9FKynMT/XK5+
Klh8B0jmNBw0YfKY5pYnuxx90tbsru9ny/i2ebjbcAKe/1DXyMVuT8lwS2c8nJQr
xwpKWzyaaN0NSGaH9XuIzNS4JRrD7AZJ/MfKZxXS5a8tUA8ZZvmcUKEZhoJ3ShmK
5T2DhH9TYyuCYXqt5oNC3gGW2ZE8Gw5//Sg9V84S+TyxtaapQ+gZZf5hl2aru6/w
4Jxs89VEuc82gVFf2Oq8rpIqufZN8FyJ60w5KtwdHlnhDyiVrnvSNkbOlTxVl6N4
1mnxrODvmnwLW/iellc85dmD6oQIDrWV+M4++XQ/VPdOX5g9pQLVncJAX/ZP92+i
LZ74+zWbrfEhqgnSNxFyG6qEXzbr10zo0uP0C98ZNHO1FlBvBxJvrx9v2azxJ1mN
mRQHY80AunfLKaQpcpOWRgIAt1n8qnA7v+qw6LXmFzErIbZuT+E=
=HPi4
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
