From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: add bindings for i2c-pca-platform
Date: Fri, 23 Jun 2017 10:17:26 +0200
Message-ID: <20170623081726.GA1526@katana>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170620011837.14010-2-chris.packham@alliedtelesis.co.nz>
 <20170622082230.wf4r2ylyevidizkd@ninjato>
 <e121e9ad4afe49008e34b5b4a76b22c6@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e121e9ad4afe49008e34b5b4a76b22c6-5g7mGxlPNYb6GjIOKuZY+ItlCAj8ZROq@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 09:20:59PM +0000, Chris Packham wrote:
> On 22/06/17 20:23, Wolfram Sang wrote:
> >=20
> >> + - reset-gpios : gpio specifier for gpio connected to RESET_N pin.
> >=20
> > What about the 'active' state that Rob mentioned in his last review?
> >=20
>=20
> My intention was that by saying it is connected to the RESET_N bin the=20
> active state is covered.
>=20
> I personally always get a little confused when talking about reset=20
> lines. The _N denotes that the line is active low but because it is a=20
> reset line writing 1 releases the reset so from a what-the-user-wants=20
> perspective it's active high.
>=20
> dt-binding-wise what we want here is GPIO_ACTIVE_HIGH, as in the driver=
=20
> writes 1 to release reset so don't do any polarity inversion. I'd be=20
> happy do add something to that effect in a v3 but I actually felt saying=
=20
> the gpio is connected to RESET_N was less ambiguous.

Okay. Thanks for the explanation. I am fine with it but I'll leave the
final decision to Rob.


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllMzpEACgkQFA3kzBSg
Kbax5Q/+LlVQxArD1mHZh3ZY0Z3UAXkxO3f1Y+6Xz35ukFVqQyM0WIA0w+MJUbiP
viTfB5gilClaj+ZRCH7lrOCTnpRE3YFNTi3TQgGPdkiwIuNk0QTHiM3fw84+cuUS
Le6JAm7IwVM8Bf1bRBQp3/B2TmCOXyJ5+XUAGIjA/CNGKzOT4O5T/yCqdNMzwVUD
/bvUEG6YCEpOvaB3iynaMBnLtPuRwXNvkLq1ZWT8sXtcV1DFbBDrQ6blqAubBMEA
QeRT26sal9wzQomgnYZrMBuw3Z3VPwNwBjx6UGsFoOwaAIUAgYccYoPN+GafOgO+
d5cRdjkYpJTEe9DAiI+Cuy8iEg0evMpNSvlIt+3PVQAoEt7VzCJcokq5WsNZQPKm
B9gqn+Y5UojlVraOv895hOJWlTsLvToP4RUORaDwzreaRqznmJdPOWZH7RdVBc+n
1ByYqAQ4oxud6dYfAW36CGYBcABREs8jcygOSgf4zI9ZuVpPMjsKDaAYiSutSroz
dfLJTfEhvkumlk9DxUASjrM/YPVF2m7TFo81rKqXJMK7vQ+YAFM3jUVdCpu7CrkM
sB0zd1S5+GkEwDh4IFnIaOosM2V8xQhPmzQJz+E4LXhHJQa+5wP2UsU54ay+lNRC
0eUQwvJxRgV098RjGKSA6kCIbRCyJHc3jDQAMhG9qSfR5Ff5lL8=
=e/0/
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
