From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Date: Tue, 11 Dec 2018 20:28:05 +0100
Message-ID: <20181211192805.qsxptzkmczmm5vlz@ninjato>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
 <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3px5u5ztkeyr3oy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--u3px5u5ztkeyr3oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ludovic,

> > >  - fix checkpatch errors
> > >  - tests:
> > >    - hangs with a SAMA5D4 (master and slave on different busses) afte=
r about
> > >    100 transfers. It's the firs time I do this test.
> > >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> > >    I don't know if it's a regression. I don't remember having seen th=
is
> > >    behavior previously.
> > >    I think it's worth taking those patches even if there are some pos=
sible
> > >    bugs. It'll allow to get more people using it and so to consolidat=
e the
> > >    slave mode support.
> >=20
> > I really want to see those patches go upstream, too. But I am also not a
> > big fan of delivering the user something with known issues. Especially
> > not when they affect the main feature to be added. My rationale here is
> > that someone who is able to fix the issues remaining will also be able
> > to pick up and apply patches.
> >=20
> > Maybe, maybe if it was to be enabled by a special
> > I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> > think twice about that, though.
> >=20
>=20
> I understand your point. The experimental mentionning could be a good
> trade-off. Let me know once you make up your mind.
>=20
> > Speaking of Kconfig, I think this series needs to place a
> >=20
> > 	select I2C_SLAVE
> >=20
> > somewhere.
> >=20
>=20
> Ok I'll update it if we go further with this set of patches.

Ok, I give in. If you:

* add 'select I2C_SLAVE'
* make slave support selectable by I2C_AT91_SLAVE_STAGING or
  _EXPERIMENTAL or something alike (default n)
* and add to the help text of that symbol the above known issues
  and 'not for production' and 'help wanted' and where to get more
  info and all that

then I'll apply this series soonish. Promised!

Thanks,

   Wolfram


--u3px5u5ztkeyr3oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQD8UACgkQFA3kzBSg
Kbbv5A//XSrxh8si+e3AU5T8HE/y/l3i9dreOYqcMS6joBcoIIFocbC8PSVpOWRR
jk7BxI87bfpTe2kDxpmHq37jvjy886tXJ8fcAx8YGvaWgnF5FjMrcZGJ0GYoIOQ4
04nEXdFgGb1NACMZGyT3Q4C0ov4HBy62T9K/sN99AznxLQkfDRB0kCE/TdQhtpcC
F8XCfSUjrEhfs04ey2poggUHjne2zVmOjATnip7X3CZF4LTE2ktGtOY8lZHeqWjl
falbb/xTGMNIrTr6keXzwiBN5pvy3ijwzZbFtF7MThLWIPMsPPK/Y3RbltauT4SQ
/AilFdJIeheddTPPTFpMw6tC1FA7VwJAEM87M5uEk7TUlc97LBl25uUH8cEHaYKg
HNlOACMkg1U94lJWPk4dWvTHT4e4PTHCQK2fIegaeZnTKWw+FluJEqUPr9cAANEj
8z++hdKxsWK4MLNBvziTu7yfrw9/k6/sMbDd8bB/PoPak9YoGTlKX+ogdJtsSyPK
/uUZlVkIptK/sGaCIKMbCjmrxbAuhuoPSjSi5kEkX558T6tjCXRK8hDkqvqQbW/Y
wLKRfQpqeOHmfAECHG1/jPISVcZA5Pp4DjMTOvuyiZbFEKFLQ7p3lkmMoZ6zuR23
p0mpNpPYww/rQL8rUm6+Ej9yUrmzmlfyDlEZxdVVFTBw66BXCZA=
=Mkqk
-----END PGP SIGNATURE-----

--u3px5u5ztkeyr3oy--
