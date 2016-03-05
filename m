From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 0/8] i2c mux cleanup and locking update
Date: Sat, 5 Mar 2016 19:29:35 +0100
Message-ID: <20160305182934.GA1394@katana>
References: <1452265496-22475-1-git-send-email-peda@lysator.liu.se>
 <20160302172904.GC5439@katana>
 <56DB1C07.4040008@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56DB1C07.4040008-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Olli Salonen <olli.salonen-X3B1VOXEql0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Perhaps it's one to let sit into at least the next cycle (and get some te=
sting
> on those media devices if we can) but, whilst it is fiddly the gains seen=
 in
> individual drivers (like the example Peter put in response to the V4 seri=
es)
> make it look worthwhile to me.  Also, whilst the invensense part is plain=
 odd
> in many ways, the case Peter had looks rather more normal.
>=20
> At the end of the day, sometimes fiddly problems need fiddly code.=20
> (says a guy who doesn't have to maintain it!)
>=20
> It certainly helps that Peter has done a thorough job, broken the patches
> up cleanly and provided clean descriptions of what he is doing.

Yes, Peter has done a great job so far and the latest results were very
convincing (fixing the invensense issue and the savings for rtl2832).

And yes, I am reluctant to maintain this code alone, so my question
would be:

Peter, are you interested in becoming the i2c-mux maintainer and look
after the code even after it was merged? (From "you reviewing patches and
me picking them up" to "you have your own branch which I pull", we can
discuss the best workflow.)

If that would be the case, I have the same idea like Jonathan: Give it
another cycle for more review & test and aim for the 4.7 merge window.

I have to admit that I still haven't done a more thorough review, so I
can't say if I see a show-stopper in this series. Yet, even if so I am
positive it can be sorted out. Oh, and we should call for people with
special experience in locking.

What do people think?

Regards,

   Wolfram

PS: Peter, have you seen my demuxer driver in my for-next branch? I hope
it won't spoil your design?


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2yWOAAoJEBQN5MwUoCm2h8QQAJpKVERebHnxPRdoWQvKdFgA
bAkwdGd9yBqmnBLvZ7MmxLOqRdZAd9YoXa2D7fVAUeVC20nGiicwpMALB4JwUC/I
6zmMQjEwQtErLKnHx3MUvELmsvnj5jhlFph17KgmtH4scKrJmzSSPdv//L02CxYT
CwdmPCZAfqdSbpa8X+ZIyrMBuy0h1dYcytj5ZXlz8tXugqSSpnk7t0ruwMq3gVuy
L50WIpWF6dJpMQRiRPVh5d5tKUOEYCbb2PbHGjIq7msFYTdD/fg6Ml4dIZuxf80C
Fj8YwNoPEq+OuXFvF0r6PYyYZ2XfW+2wdqNRmRAr9Xt+ECav3wNMZb8E7RqfoVmE
ssXkInXcg0+oofVNPHDzJYFQxjfPqmY4N32nmQ88z1HUCaUwA5Abfmw6SWfcI92f
VcNjAs5AQVDzhfpfwm/atwTGs1xm6gXQymL77hDvmKQnOUvIRATuXHjSB+FLbuSs
ypt52ZDBml0xdMTdwznX8uThijBeM6Ynw4w2UkIqkgipOfCzDuomcHd/+8n8z3i0
WwA5NKx8rI65R72BXkHj0nHy4c9StOuTXfNilMVyBHIsE8K+GDbdu375em3TuKcD
qiJRUHk0xpdmnhrXbURzUzvnbc3BdeG/JDJd/ErVycicx6wSXtktaqtRiEjwreSG
qK61eIj0COHEjoX/hk3s
=rkf3
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
