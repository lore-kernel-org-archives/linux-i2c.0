From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [V4, 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Wed, 10 Jun 2015 07:16:28 +0900
Message-ID: <20150609221627.GA1717@katana>
References: <CAC=U0a2R=G0toDqUQzVueREDXFxs0Dm4eiBAdyhzH7Fp57-nRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC=U0a2R=G0toDqUQzVueREDXFxs0Dm4eiBAdyhzH7Fp57-nRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If ii is alright with you I will change the  dev_err(...)messages to
> dev_dbg(...) so that they do not spoil the logs.

OK.

> >> +     rc =3D of_property_read_string(dev->device->of_node, "interrupt-=
names",
> >> +                                  &int_name);
> >
> > I haven't checked but is that really needed? of_irq_to_resource() seems
> > to parse the "interrupt-names" property
>=20
> Since the driver also fall's back to polling it will not work in case
> there is no irq domain assigned. The above approach works for both
> cases. So we do need it.

I still wonder if there isn't a better way since the name of the
resource is set already, but if so we can fix this incrementally, so OK
for now.


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVd2W7AAoJEBQN5MwUoCm2eusQAJ4wM1LhqCx0gi2KUCjEQCMu
yQWuIueXzb/6/gsUHqYpM8ATki4TNEBG2ntqf4xKqnA7a1/NygrPyh5vbMWdO0El
RxIxRvdbfgHEOsB5rkft9sPf9Q9Aza0JLVQI9knJnPhMtnfBN1iqYawoV8txVJ9n
70hJlpEyuFpSzCibCgL1U/L2XU6bA3vY0ZHFpncFDrFNgweJDPGkQN07QxcwUkj3
T24QwQcmpJVROYQq5JReUEvQcFlKPuDBNYv3g/SvmTJNzto5FnKEZE2NzZNM6y5X
oRjdkt3wtFXCUul00fFrM9aLajPSElpjORTEy0sfjhKZ5Lvg37mGZKgYRtmM9GVQ
N2IKjiprcvV+GADjXzMHSNiDjdY92o2Ox65EW3WnIZjFVcIq6U5uQKPkS906C5ro
jKAJzI63osrif8GceQ/gSm72XXOL3vcrPN9kbV+iUnpaOOSvxkOYDBmbLh/e2MC3
noI2BwRtTTPmBpRxwOF+R9OX67dvIIC5hLSXJJhIyfAVWXpYQinpv4AznP9UyyvH
eraHZ8cuXqtdpOhHIH+9SKb670TkpfNzPZ+4Xn+TJYlVQ/+lBb6Qd+1CvUBgYOyP
AH/riUUNeFggw3ufej15NGnzN6elzo0pCZ9DPI1pNbPhAgg2YIeoG16JZBzQgxjz
0buCMLef9eKOd0exvMe+
=omZ3
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
