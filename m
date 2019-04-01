From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Mon, 1 Apr 2019 21:45:59 +0200
Message-ID: <20190401194558.zdcr3m3imd6vpze6@ninjato>
References: <20190325183652.252175-1-helgaas@kernel.org>
 <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
 <20190401140806.GB4570@kunai>
 <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="alwnzsgae2vuzpj4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jean Delvare <jdelvare@suse.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org


--alwnzsgae2vuzpj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Jean, would you like me to repost this with the updates?  I assume you
> > > will merge this (just based on get_maintainer.pl)?
> >
> > I will apply it, now that it has Jean's Rev-by. I assume this is
> > for-next material despite the Fixes tag?
>=20
> Definitely for-next material, not for the current release.  Jean
> suggested the Fixes tag, I think since it's related to a specific
> commit and could be backported together with that commit.

Makes sense.

> Should there be a MAINTAINERS update to clarify who applies patches to
> drivers/i2c/busses/i2c-isch.c?  Right now, get_maintainers.pl doesn't
> mention you (Wolfram).

I have set the i2c/busses directory to 'Odd Fixes' in MAINTAINERS. I
don't want to be mentioned for specific drivers. I am eagerly looking
for driver maintainers to spread reponsibility. Maybe my tree could be
added to Jean's maintainer entry, but not sure what that is worth...

> Patch with tags attached in case it's useful to you (sorry, I'm
> saddled with gmail right now and can't include it inline).

No worries. Patchwork keeps it all for me.


--alwnzsgae2vuzpj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyianYACgkQFA3kzBSg
KbY6xw//XPSqTjpipm+4dS8ioXlDRdZl7MWa3HVMuhhIHQiOkS+qJw8qWFHlkvyA
Wil2ZywRwSLUF8IJ3Y8SPeLz9nDNzQBp/HLkjSZ4QcAYY3RI/4NI1DdeyN1D6p05
AB0xzD/F1PGVK3HJOJj0wV6GM8od7NYpWYF9eQTjzDaC6fDP4/pyEK1jpplHjTsz
sMGFLIspVnkgTzDIMmsjJlKV9+byHX+Gmj56+kK4W+3+/kcGV+bvoZoDr++GeGuo
WK+5QTnXsH5qEQGAuYx/SwOXSNfU5FLuYN+pjfzP9xaxUShmhGZ+UUxHR6oJRtq0
iOa+DBAcGIDVsg2hynpLBZqMysqtHSiMrx4lCs0aMboGzzMKtBsSpXrm6roKhwhj
i1vvw6fqvB/FyYibyG4O204lQ/RZr5SRfihLy6OQaiZQeo2AYrC4Wan/8ONiKKP9
4C6O4TcMIuWwKdAlN57klp/JlfNnjfIBaHhNcOL9v/weuyeTTIOY2Lmudu9ccmuv
ojbnUM/Un4v4qn3HXQhba+IrznoDrRYgjjjAZwIzKPeNXWU1jGb1+VqapmqAadrp
tQ5AV76ciovbJasnU3AaGuv06XuMQkzlPD3NaBSvIkrRThvqbBE+XL/izSfvG3Xn
AaeanfwoPee3+GcKjLFYeB8NoTHu3xA9vC4ZTnUann7nNxKwvZM=
=HAZ4
-----END PGP SIGNATURE-----

--alwnzsgae2vuzpj4--
