From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 01/24] i2c-mux: add common data for every i2c-mux
 instance
Date: Fri, 15 Apr 2016 13:23:19 +0200
Message-ID: <20160415112318.GA3999@katana>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
 <1459673574-11440-2-git-send-email-peda@lysator.liu.se>
 <20160411204630.GA10401@katana>
 <570E4BAE.7060108@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570E4BAE.7060108-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt
List-Id: linux-i2c@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I'd suggest to rename 'adapters' into 'num_adapters' throughout this
> > patch. I think it makes the code a lot easier to understand.
>=20
> Hmm, you mean just the variable names, right? And not function names
> such as i2c_mux_reserve_(num_)adapters?

Yes, only variable names.

> > Despite that I wonder why not using some of the realloc functions, I
>=20
> When I wrote it, I found no devm_ version of realloc. I'm not finding
> anything now either...

Right, there is no devm_ version of it :(

> > wonder even more if we couldn't supply num_adapters to i2c_mux_alloc()
> > and reserve the memory statically. i2c busses are not
> > dynamic/hot-pluggable so that should be good enough?
>=20
> Yes, that would work, but it would take some restructuring in some of
> the drivers that currently don't know how many child adapters they
> are going to need when they call i2c_mux_alloc.

Which ones?

> Because you thought about removing i2c_mux_reserve_adapters completely,
> and not provide any means of adding more adapters than specified in
> the i2c_mux_alloc call, right?

Yes. I assumed I2C to be static enough that such information is known in
advance.

> > Ignoring the 80 char limit here makes the code more readable.
>=20
> That is only true if you actually have more than 80 characters, so I don't
> agree. Are you adamant about it? (I'm not)

No. Keep it if you prefer it.

> >> +EXPORT_SYMBOL_GPL(i2c_mux_one_adapter);
> >=20
> > Are you sure the above function pays off? Its argument list is very
> > complex and it doesn't save a lot of code. Having seperate calls is
> > probably more understandable in drivers? Then again, I assume it makes
> > the conversion of existing drivers easier.
>=20
> I added it in v4, you can check earlier versions if you like. Without
> it most gate-muxes (i.e. typically the muxes in drivers/media) grew
> since the i2c_add_mux_adapter call got replaced by two calls, i.e.
> i2c_mux_alloc followed by i2c_max_add_adapter, and coupled with
> error checks made it look more complex than before. So, this wasn't
> much of a cleanup from the point of those drivers.

Hmm, v3 didn't have the driver patches posted with it. Can you push it
to your branch? I am also not too strong with this one, but having a
look how it looks without would be nice.


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEM8mAAoJEBQN5MwUoCm2vqsQAI3yJI+B6O3czvil6A1eykpH
g4woawT6xVkslGuCxiz+bXsjE3ldfGG7YH2BICfyhYLEvIkvVBgfVb1JQrsEsR4C
AfpX3HyO2N29JO+S0Zk5NUToJ+6W2e6cMiAXKgBCGP3sODITuqx0Fku3Nvf7zfTB
pR1wOH9lAg/+qSiBTtpclX0l8i2chQiRHJqFxUJUoErClZudrZkizbTugMkfsXJf
qiywt1GsBgkPLcnAmISq71J/9QgsQZeMfJc85qCeEWng0YEkOruK8JFDHvqhffZw
10P1GWYsFF3do2qeMgCh90xeZNWijzOJl8a/YcOnTRGgJRjfLeUu5Y93k+IhdZiq
wJkSiybtFrz9Qq84DVwG53QHu9huZN/MW+GUxWKi45B2ZikM4UkPQMA3DBUVcn23
AWTYhhGI7FenWI63NceG0Nl9+o3UxAO97SHIRcqvNmeZfMd0lsYi7oqDI+SuaOSy
wI0NhdoWSl1mutULlojkMqWBiGHN+RweLTNpv6dVUgR+qBb/7+tCC7DRFQBA/G9a
mA3d8EEEOoxo7mcP2F7PYmYiA42gN6TRiP+Lce3rqNyRMe+G3YoA/agWwgcsoehf
p0pIWzU8vH/5jcz32FTHlooMQIgsx5IqT0FxbxIDPoTaNOuNcsgdOHArv84v/9j4
H7duOm2CeCS5eX2uuQPU
=Px0Y
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
