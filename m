From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] dt: Update I2C trivial devices list
Date: Mon, 13 Jan 2014 13:51:28 +0100
Message-ID: <20140113125128.GE2586@katana>
References: <1387239151-19226-1-git-send-email-bgamari.foss@gmail.com>
 <52B07870.6070809@wwwdotorg.org>
 <87a9fztofc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87a9fztofc.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 11:47:19AM -0500, Ben Gamari wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> writes:
>=20
> > On 12/16/2013 05:12 PM, Ben Gamari wrote:
> >
> >> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt=
 b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> >
> >>  This is a list of trivial i2c devices that have simple device tree
> >>  bindings, consisting only of a compatible field, an address and
> >> -possibly an interrupt line.
> >> +possibly an interrupt line. The compatible field is used to lookup the
> >> +modalias of the driver which will handle the device. The compatible
> >> +string may begin with a manufacturer prefix (separated from the
> >> +modalias by a comma) which will be stripped off during lookup.
> >
> > This part of the patch described Linux-specific behaviour, whereas DT
> > bindings should be OS-agnostic.
> >
> I see your point but it would be nice to have language like this
> somewhere. One of the biggest challenges in diving in to writing a
> devicetree is figuring out details like this.

What about putting this into a seperate paragraph prefixed with "Current
Linux specific implementation:"?


--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS0+FQAAoJEBQN5MwUoCm2KpwP/AyB8ra+SIKmFBzLM0/AsS8g
9xBV2Fjpgo4zjgrH0+wKX1ZGcERkFaxCEUN4vcSBrUiTdpbbpc6YJVkb4FjzjTx4
eVzXYxXfg/q8maHP/TrsaLWNoQYHTmcBXeWAAAyuiLNeLWRFCONkQMzTvDq9rXXd
oYEl+JMvm2eOwlQncPPjI0FJKsFbEUu7Ju6S7ZeeXGJ1k2As2Wy8nTifv3TgWeAQ
AgpLV0JkCIupM1DELmHRxo2yO9hSHSUU3efgkwCn9RT3zL/+Hnf9gW6Xn+nalvRM
83PNu71SXmdmr6XTe8ZexLtce36pygX2v/AgQ7Xw94DgdAYpfphML8DVM4TqRf9v
K+qr86g0WEKgfwX+qdULWGpixvR7FRwh13CDMBwlNywM7T9Ft2gsCFL+G5Etp768
mxnArOiv6a5GSosai5XJ+WdDgwAW+Ws2+7ln4rFD1aqInhI2gVNyQck/6InCjwq5
0D6CX5pA5cBxAm8W6fCUYibYC3W2MUYTA4dWIYhce8NFgoXc3NqVuZQ5qTt3aTik
wj71tWkK6Ip/w8XYwIaNJEiKNO46ddsPS7M/x1GWokU/jCkYW/56SbP5pKc6IrF6
7I32h+T1gIE4BCFMfoj7QdUWUFy2n5TjrdLy+WbwLGdPtSUqt7v1/iCpRAe3wgUu
ugZyLQrawMJ32PRao3sr
=9DAh
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
