From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Tue, 8 May 2012 15:29:27 +0100
Message-ID: <20120508142926.GT15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org>
 <201205081348.14269.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205081348.14269.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2012 at 01:48:14PM +0000, Arnd Bergmann wrote:
> On Tuesday 08 May 2012, Lee Jones wrote:

> > I did run this past Arnd before writing the code and he agreed that thi=
s=20
> > would be suitable; however, if you know of a better way in which I can=
=20
> > do this, I'd be pleased to hear of it.

> It was the best approach that I could think of for this, but I'm also
> a total newbie on regulators.

It's not really a regulator thing, what the code is doing is blasting in
a bunch of magic register writes to set things up, some of which are
configuring things that the subsystem already knows how to configure.

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqS3AAAoJEBus8iNuMP3dooMP/0qP6J0bQ2QMU6g62dGU8otO
HjImSErvJUYHZmr+AJxfPawM8CJ0EMudl+1CX3h4ocmw1fpMNb9ksITf2CeYKjbr
TUSscPaNNBH7qII0sHeIy/DOmGsBItq/P32sZbDlFIzg6TnzPsKNjSTO4Te9eJXL
P5HC7OnoCu6ta3TpnzmxfhCKhEPHLvb7Bn9l2sFQ+yNeJi3AKp0VP8zJlEdhzmjR
U742QwhNzM2wlES3ku30SurlU0NljpuipTtWYFS0+KJ3daE4U+i9TBUW/jdpJ8al
KB0LIOzHCGw6G3QIsPTTKEMHqyLqpw9EHQoJPHDeH17lYspKk/aLkQICQTAYB8WD
0nNl7fIBqej0SEK2ZLP4ZbX8KPjvhOFgMSr9Eh/A+ROL8qm/LrwNKl0nBJQx306w
qWnbL9cuVh7ayBjUZkRDXKCPHNxd+jhc1RI4M+qidaD9j82RHF9mo4bgLsUXj+Kc
MeaNK+D2QLPiL2kv3yEANps9/1h1etZTpWFmAUHmZjl7PovtRn+SE7A+L5qyWaRo
DpTGwztsqwq8JpV/xS6NgOPfzB/PB303roVUtmTCE+udnjwJh+qgl1ph4nyxANQg
pj0eAB2NF+4FC30A16nsdpxkBWY2J5euxX0hrK7S4JoBClWKQXAuo7p44sqW5rzU
SJPgAn0LDMcR8Xd92M6e
=+ati
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
