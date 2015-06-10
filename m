From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 23:08:16 +0900
Message-ID: <20150610140815.GA21540@katana>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana>
 <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
 <20150506183733.GA1513@katana>
 <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com>
 <20150610054034.GB1573@katana>
 <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw@mail.gmail.com>
 <20150610124949.GC1592@katana>
 <B9EA0BC3-56D8-4676-BEFC-734EC1FE6649@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B9EA0BC3-56D8-4676-BEFC-734EC1FE6649-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > IIRC it is the one which adds OF_POPULATED. If so, why is this not
> > scheduled for 4.1 as this bugfix depends on it?
>=20
> No idea. This is an obvious bugfix.

Dunno if you did but mentioning after the commit message where you think
it should be applied is very helpful for maintainers.

> I would like to, yes. It=E2=80=99s just the nature of the process when de=
aling with
> multiple kernel trees. I would be happy for someone to pick up and queue =
it
> for 4.1.

That might be too late now... You could also have sent the patch to me
so that I could apply it via i2c with rob's ack. Next time...


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeETPAAoJEBQN5MwUoCm2LmUP+wbP4mO281SiHczzIKrnK6iX
bzPmw6nPSkEp5hXXzTUIVxe5sJtR/ThFdQ3ocuCoTbWHDAjtzfkPUnvLLS4YsYeA
c8x2TUhqbN7YeDbY/YpfNoSU9IrtTNZxKPo7Lv7nYDClTEjb3tUvOV4cBa3KwFqY
8m/LVQ/CRsSM7YYQ0k0bsNtVvDI3D21iWnrW3R/6LpRtqFJau2wTPJLDUwWB1ogx
Wgp/QIaiclhfwfDtAtzm1XWIfHZlqos2twz3eieBt4a/nJHW4D8+oSRNyYZdP/AC
mToAJ6VqBMLM1bNjd0SXdzdGKAXr6YmZ93mkFkTI5d7xdYE4aiOrxAuvOWoCp/Yr
yiOanp3txyFFz6IDY4FAB0ghkkGMzld3H1HAOkxMzvwv3Vl3LaVrjQdCF/BV8Swr
P4N58Xp4jaq2E1fY8wSwziPwOjKt+0eM5LLyJLx/QfBI3CTj5mkWM5hTVOlyOLqL
CiZEZ8o1C1/mrGc/ebO240Cd0NbL5SE+9LJEU+Up5h64RNBirQowBwcZyK9Gp1nF
4y8g/c1vm4Ma98a3hSkFW8+oFVi9KPrOCjtEyziNzMHqhwi4PuYyZq5Poc6wV13o
WSL8xdmh7lmcvS2zmTEpcc8MLotLPyaZgcG+ShmwUarUgoZqe3WzQWyFoKix8ezF
yrgyCA/g5Wb/kvk4df/y
=KolE
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
