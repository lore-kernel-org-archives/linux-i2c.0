From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: aspeed: Deassert reset in probe
Date: Thu, 26 Oct 2017 22:53:48 +0200
Message-ID: <20171026205348.zh2gicql4pyyeoaa@ninjato>
References: <20171018142930.13052-1-joel@jms.id.au>
 <CA+gwMccb45zXESWJBa528jUa2n_LQdqJD8UFBnfZBkA+q5+mQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="exvvntgzvuhfygzx"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59836 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdJZUxu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Oct 2017 16:53:50 -0400
Content-Disposition: inline
In-Reply-To: <CA+gwMccb45zXESWJBa528jUa2n_LQdqJD8UFBnfZBkA+q5+mQg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


--exvvntgzvuhfygzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +       bus->rst =3D devm_reset_control_get_optional_shared(&pdev->dev,=
 NULL);
>=20
> This could return error values in case of broken device trees, so you
> may want to check IS_ERR(bus->rst) and handle the error here.
>=20
> > +       reset_control_deassert(bus->rst);
>=20
> Otherwise this will dump a warning.
>=20
> > +
> >         ret =3D of_property_read_u32(pdev->dev.of_node,
> >                                    "bus-frequency", &bus->bus_frequency=
);
> >         if (ret < 0) {
> > @@ -919,6 +925,8 @@ static int aspeed_i2c_remove_bus(struct platform_de=
vice *pdev)
> >
> >         i2c_del_adapter(&bus->adap);
> >
> > +       reset_control_assert(bus->rst);
>=20
> As will this.
>=20
> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>

Joel, do you want to fix it? I'd think it makes sense...


--exvvntgzvuhfygzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnyS1gACgkQFA3kzBSg
KbZSzxAAslR7gDMr1LdCM/H0cLLPYITdUG5WFZs913qIwLfdG/kn0NXw1Z1H2I+t
co7RxxBJZgtVVgwZ91qsZ6xyImkVlfIKcgbinDXsXFWNMk33MDMewfe4z2EMwO5z
2FVL1nRGVnn76JCQ5OCukZUvaq2Bng7ztjOocaFO3gHHI6gqMFX8sw5MoN31z32V
LosO79oSZqtyUmbOOf8fyAzhev4AC8leUZO2jq8Z/aUnqVGac8BwoWEungWtY9mV
pqcPfWF03MN/hyWCcF9urQb95qK3/z6HAWslbaHmMOyIC+cJVlNTQ/BF+6d2p5cZ
RNnkZBvvRSVxMmOR2WkBwRj99RuMhwgLcNScGG9ObkAR4QLihyUH6IktMs49a/Wn
y+1mS7qu6yDiA8vOUqzf0E/B9NcYF9uScg8hbN/db9eKv23Fe32B7XQJ92AFI5+z
nfutkiWlsZjaeX5uc9yUsCkYkqjwsdtjLnUKNZhN7N42Mx8Ikeu6kLvsocA6sSge
LeHxNXsWrdL0YI+3XM6IqVE3J1NYbqd+IXlUs6EigmbMGmR1FEQRnPbf9v/3GECa
m/1eSdjDwCOAzajPRkGKR0FuZhAGPx4aJUzyVzi36APVDILZ/Bl8XgQ+NAMLHKez
eglfSFI2Ykts+G+su0qhGRV3dQqTXpdmaoIhYsrZ9RftAlpakgY=
=bZSh
-----END PGP SIGNATURE-----

--exvvntgzvuhfygzx--
