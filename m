From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c:at91: Add device tree property to set
 clock-frequency
Date: Tue, 11 Mar 2014 12:09:08 +0100
Message-ID: <20140311110908.GB24766@katana>
References: <1394511938-28653-1-git-send-email-mark.roszko@gmail.com>
 <C7EB5260-2285-4572-9D73-15312BB09F65@jcrosoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C7EB5260-2285-4572-9D73-15312BB09F65-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org> mailing list" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Examples :
> > @@ -23,6 +24,7 @@ i2c0: i2c@fff84000 {
> > 	#address-cells =3D <1>;
> > 	#size-cells =3D <0>;
> > 	clocks =3D <&twi0_clk>;
> > +	clock-frequency =3D <400000>;
> >=20
> The bindings is wrong it=E2=80=99s not the bus frequency but the max freq=
uency
>=20
> as you describe the bus not the device frequency. And this is this one th=
at limit the bus

It is not wrong, it is since "the beginning" the way i2c bus speeds are
described. It is well known that, in fact, the devices should have a
speed limiting property, yet nobody has sent in patches so far.


--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHu7UAAoJEBQN5MwUoCm29/IP/1wszbE+yr4qVTXwCYirV6Sw
2u/C6TQOfjZOXqkNFFsM4yJ6H7bk3mjWYzkMs/L1DEA1qm+jF/Qdv+XInbffC+u1
rAQ5+kTBgDlyq2hf0QBxLTMWkypS1vvcfv/pmVaFux7391MJTJIjae73Q1Rul8Lc
6u9SbhnEfOIAmHpqsxxC4q3YmTa1cJIF2OpD8ycVmMMe2MuSfFrOqqk7v909cE9s
0aa/ZMeASGhL0fdFZDYlMv53a4MzNu3gICSXq3Vz5wUvgdw/5fEqFzgTTaXrPimZ
0bUYbAxiEGYT7v16ZWeKnk0JV2wryn00FrquGTPZZXI1QEGEEJ3XkcfhAlYpQJA5
QCmI/HXMv0m0dIbVtdXAZwHildNbkoJCMv/k95dMLV+2yIyH2dmiXdgsmtx65rGM
PIR/fKByjKEh2NNgJkqKL4Ed0e58HH1gC2Y8IBSNav0rPDOdHQC8nbd5Z0S1cpxE
X/Y9K4d7DWFhMLQ/BeLwMcJzKFHVdgTRJEnOIe+pvIfpSMl9RNHzACaL/kGvku/i
y6Sk3jxfQ/CWuqZBxXebL3Ypdb4zsiK6puqiQDk/uN46aIUoZHJrAoDYKHtLeiLJ
kRJud8fr6cjLRtRiuL90SBPB8XV+Gam7gBMLBxVQihz1+Qq7qZBjFtoDJEMz1/qg
cnIPmwNGHVHjlt1cXZ/Y
=+H3k
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
