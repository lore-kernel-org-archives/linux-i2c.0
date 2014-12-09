From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: Driver to expose PowerNV platform i2c busses
Date: Tue, 9 Dec 2014 09:54:35 +0100
Message-ID: <20141209085435.GA1154@katana>
References: <20141208063039.14356.34770.stgit@localhost.localdomain>
 <1418069595.4827.43.camel@kernel.crashing.org>
 <20141208205520.GA12715@katana>
 <1418075026.13358.4.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418075026.13358.4.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Oh, I thought we agreed that you take it via powerpc. I still think this
> > is the best solution.
>=20
> I threatened to do that :-) I don't remember you replying, did I miss
> it ?

It is here:
http://thread.gmane.org/gmane.linux.drivers.i2c/20762/focus=3D21099

> If you are ok with the driver and are happy for me to take it,
> please send an Ack.

"Happy" is not the correct word, but let's just go over with it. Maybe
like this:

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> (I2C part, excluding the binding=
s)

> From a binding perspective, it's just a piece of additional info that
> the firmware provides for convenience.

I do understand the use case. I even agree it makes sense to have
something like this. It is just that I'd prefer a generic, widely
acknowledged solution, with consensus where it belongs and how it should
be named. Not a custom solution which, frankly, feels forced on me
by time pressure I have nothing to do with. So, not happy here, but also
not looking for drama. Let's move on...


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhrjLAAoJEBQN5MwUoCm2SxQP/14KP9HmX7/VElUaCTmG4+BP
m0muuYKuqOB1lPmw1sB3IgdHcpm9rQbRCRnXTPGSKEAlNZrTzS615jvedtUhVQP4
dCkd5aD0+C66eRK+S7fgAzHSuWL87DfGYRaOp5iipiiPUBDhwGM+jWnnRA0N927Y
UlV6jUhjqq+r8m5j7nvRg7ZZNi/IGOUNtEF0GK3wGzZmzI3iG50m0FkSFxAppaLY
0AHG69cuNVUMJI5nXH2NW+hXVghKiEA/AIxvIU8aQBt/siRywCSxcqSmOZ+gnaWT
mPlct61FEQ+d8IyjrqfkkyM24uC57YG0g1cE4l/kkxkmOwEGqP2t2cPUs2eFndIZ
v7qrBp3Y4ODctBeZBVAsqIrV1eIuxPiOzzZKG1Qvw9DCSP+e2pYp/KPLNz4Itaws
NwbZL/Lu7LagolCuysz94RmChhcJt395IUAOny2zeL9k8gVFbQ3qy/F/lV+tRmUp
thtXRd5LVa3hp9OxzAEIW9T5EC72pBngKu4GpN6LQ26tiCUzjHXXoVtoThHe1J9S
6Wr75+X2rxRSolHC9MlyT+3S+z2grBWhAYdaFftfG1+6IAyo9Cb/Rj1xHpHbgZu/
SmlB7qncNDJsxl22V6kHsN/wDN536f7wPhllMZ9KRLUQi195pJ6fbtw4enlTl1Pq
CMdpAtwaX/MnXcQ4ddz5
=Cs8K
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
