From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Mon, 24 Aug 2015 14:35:28 +0200
Message-ID: <20150824123528.GF3608@katana>
References: <20150818065251.GA22085@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150818065251.GA22085@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 11:52:51PM -0700, Dmitry Torokhov wrote:
> Instead of having each i2c driver individually parse device tree data in
> case it or platform supports separate wakeup interrupt, and handle
> enabling and disabling wakeup interrupts in their power management
> routines, let's have i2c core do that for us.
>=20
> Platforms wishing to specify separate wakeup interrupt for the device
> should use named interrupt syntax in their DTSes:
>=20
> 	interrupt-parent =3D <&intc1>;
> 	interrupts =3D <5 0>, <6 0>;
> 	interrupt-names =3D "irq", "wakeup";
>=20
> This patch is inspired by work done by Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> for
> pixcir_i2c_ts driver.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV2w+QAAoJEBQN5MwUoCm2qaoP/2xuVeT7tNbuKbcTKrBCB7fV
1XcLSAmix8luxEPto/us+5dPFO0e14BUVIOPIPLs8T3wZp+oK7kuzMA1meRyh+RA
E3CGNXchm9DtqqPmiMaVh5gjQAerWY2dUviWH3cL5h6kWT+wb9jePLMxDw0O/Bs0
vqDNTy8MU8eHDsgP4X6fASAd4WsJUXGIsMGx2xlEr9s7PvDFrqbYcAa6SYKfWUCg
X+NRiSIRl0EAQfXxBGF39eJtLM4tX/LbJDto8UgCJV0aeRusH2HVBUMjKuX3+wmc
AYsPgLSo2eHm6WHlA14gssQ8cEwMoaS0czJV6PNwiZhBztaqSTxbErA5bjZZ8zC9
3Jr9eYbAeThRO2xSY97oQAQ4I7bFKjgORZHuo7xEBRMqsss6lk/zRyxiiUkKcixw
W0icXbTQVJ2pqxBtC01ihSmOo+XjTSdSoyIbbuzL+Cw4xHuYbPIxvOFu8V9uNqWb
fvkNJEc9vGcAFFXr+mO0jandIDhbPa6LYQixR8yZ/+wDTfnCdrF6b5Q6U4liy3v4
qjetugZnoTWWNRxilnLfwUbg0X+K/gkphNorNNVJ3E8FjzSHesmrvRN0lFUMZ99P
RmcPpdHE+Mz5LG65/23oiln4uKFidlITwPv0+LH19oZ4XzTgnXycS1VGdF29clQ5
t8q5ddHrpxfXqyE7GUpe
=PgWQ
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
