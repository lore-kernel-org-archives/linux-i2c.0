From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming - solved
Date: Sat, 14 Mar 2015 11:49:39 +0100
Message-ID: <20150314104938.GA970@katana>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com>
 <1426136151.37151.YahooMailNeo@web181506.mail.ne1.yahoo.com>
 <20150312094423.GB4225@katana>
 <5501DFCC.6010408@rafresearch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5501DFCC.6010408-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 11:49:48AM -0700, Bob Feretich wrote:
> On 3/12/2015 2:44 AM, Wolfram Sang wrote:
> >On Wed, Mar 11, 2015 at 09:55:51PM -0700, Bob Feretich wrote:
> >
> >>I tried some random things and setting aliases in the dtsi file solved
> >>the problem.
> >
> >Good.
> >
> >>The use of an alias to set the name of an i2c bus should
> >>be documented somewhere!
> >
> >Well, send a patch adding some documentation where you would have liked
> >to see it.
> >
> >Thanks,
> >
> >    Wolfram
> >
> The first two places I looked for information were:
> *
> https://www.kernel.org/doc/Documentation/devicetree/bindings/i2c/i2c-mux.=
txt
>=20
>   This is where I found the info on specifying the multiplexer without
>   aliases. It would seem logical to add the description of "how to
>   explicitly name child buses" here.

Please do. You know best what kind of information you'd like to see
there.

> * https://www.kernel.org/doc/Documentation/i2c/muxes/i2c-mux-gpio
>   Even though this file is for gpio controlled multiplexers, it seemed
>   like a good spot to look for information on how to specify i2c
>   multiplexers in general. It only describes the board.c method of
>   registering adapters. (I don't know which  gpio_i2cmux_platform_data
>   fields would be the equivalent of specifying the device tree aliases.)
>   Perhaps a cross-reference to the above documentation is appropriate,
>   since use of customized board.c files is being discouraged.

Send a patch and we will see :)

> Note that once device trees become dynamic and support hot plugging, the
> alias bus naming solution becomes ineffective, unless there is a way to
> specify a hierarchical alias that references the bus/adapter id of the
> multiplexer.

I2C was never considered hot-pluggable in the days. So, anyone wanting to
use it this way needs to spend some effort adding it. Some steps have
already been taken, though (e.g. dynamic of reconfig).


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBBJCAAoJEBQN5MwUoCm2L+YQAJx3LLYbIX+18rpTthv2QCQc
lCq3W9MC0SEhph+ThQ1r1YCWpdh9qcUaz/Gj/FtBEEQf5mSWukbJWhf5kBlYaHR2
0kmWm1hYD9ps5OGzGjG6MUfYQIzDPRI2evEIBkWPKJvV7keNrgrzcOIjJFaF0spl
X2rjxFMBwIiq0viH0S102TpDvrX74T4mFvh+UyXWacFV27m4DwrqKked4Cp81IpP
o7hy4QEvsQMYE4sCgTvdZdSZBp/Uq4QnjdcKpO8H5uTy6TtRlC4wDbE5U9+frv7M
0saRSuoYfa34Qfpeic0kRvioaGe/4LDuGAqBWUBMBn5+zLRspEx0B/GJZIwt/F6E
xRNmFdimX3fIDXTFtPmB6uYbUhOxmETQgduVZXQM7icCJRK07WmZXgBwTWzxibdg
Ih2rA62eRBkT3wePBmcYmkCUGaIzsTO/7rgZyI6BUH2OAmKNuqDdY8Y2ZIO6zyem
amOBa0UWajl6jV1D56UtqJk/LhQ2uttDAmw4rGjMLD6vVFRlQ9Jm8uISKMFHlva4
xnupIrcta7xPOE396idfpETT0vz9ns0MwbBy4A7dITNf4mxvmrw4dLJYIhUAmVvH
CE6wChJCYSm6AInQDTC5KKT3ZQMoRPn4h+yInwHt5saAHTTeKWbgKpzVtZvyRw8a
2ByJfbzRXH6mbbSSbnSB
=JnB1
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
