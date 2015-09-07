From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/8] i2c: img-scb: fixes to support i2c on pistachio
Date: Mon, 7 Sep 2015 15:50:37 +0200
Message-ID: <20150907135037.GA4986@katana>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
 <20150731111252.GL1522@katana>
 <CAAEAJfCW9cEMDZwta5Q6VVEZfzxTDZ50Fx=YeW6bPMnrtKNcbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfCW9cEMDZwta5Q6VVEZfzxTDZ50Fx=YeW6bPMnrtKNcbw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > That sounds like good testing \o/ If you are happy with i2ctransfer,
> > then please consider adding Tested-by tags to the i2ctransfer patches,
> > so Jean gets a more cosy feeling to include them to i2ctools.
> >
>=20
> Definitely! i2ctransfer was a HUGE help while developing this driver,
> specially when preparing involved transfers to test repeated starts.

Glad to hear that! I also discovered and fixed a corner case in repeated
start handling recently in the i2c-rcar driver thanks to i2ctransfer.

> Any chance it gets merged in its current state? I think it'll be useful, =
even
> if the usage cli API is still a moving target.

I don't think it is anymore TBH. Not more than any other tool.

Waiving to Jean \o_ :)


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV7ZYtAAoJEBQN5MwUoCm261EP/1D/fyRoQbKx6IGLcHmtE50n
v82kHtkH61+FPxcSlu4e9bxz2C1upAXSXka9JEosGi3gBTP7uyD16AfFVQjHDuzO
LeS1tuMIXp4pb7I13v+hFjN3/kHW2q/SDcwzEAV42pRz/kEDmwlS3U/ni/ugXM/w
ilVlItGhcu2sSRri9dM36BTgBgKrUAOC3ftQi96Gtj9LxHQv9Nih1QE0rmtcsh5e
IIZHezs67cGpauq1VnT+jNjwQUKtUIQrmrAzoxq+jjHvfCMJJNS+qDhKnK78psEL
650U8TcBYllOTgpfTm0em0nS4YdDnu/HtHb02PAtRkZiVm2QW/SV8F/9p6L5CkWM
BeXORX+5OPjcQJ6EqwNInXb+jaqXaWarVH4OTXvTcMGQCX80Q5ku97QTsY6b9TPL
DvL5EOpbTqXU6NzFtoRISppode0/vUtyPvNiJKjraxSEXvs+SqPdy4eUXJcEQc0f
XKCESCaSePVYF9XgyGwVYUPzoY8FNTQuyoyYao56dCPSHy9jPdNfjAV3WnHfnh4r
8ssIiiZKwSBDrkgM7jg7RTzy7JW0TRiaOXR0fRqnQI3/8L67HUaov0hxUoIsftIV
l9ryD5aKKsolaNabf5EW+5YveV3goWfPf89fBv/7UAsRQygNAsOQ389JU3zUlxVm
D6f1Ig7WPV/dxDgdi1rw
=UiRf
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
