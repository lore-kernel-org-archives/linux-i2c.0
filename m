From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date: Fri, 7 Dec 2018 14:11:08 +0100
Message-ID: <20181207131108.GA2462@kunai>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
 <20181127125050.GO1107@kunai>
 <CAL_JsqJZJVMvd0aQJ8eDXBqiZ=quLrNGr3hhqePm8fCushHxxQ@mail.gmail.com>
 <20181203210035.GA4611@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181203210035.GA4611@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Peter Rosin <peda@axentia.se>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 10:00:35PM +0100, Wolfram Sang wrote:
>=20
> > Didn't we agree that I take trivial devices changes? Normally, it
> > doesn't really matter, but I'll have to delay landing the json-schema
> > conversion because this will conflict.
>=20
> Oh, sorry, I missed that! I haven't send my pull request to Linus, so I
> can easily drop this patch again and apply a version not touching
> trivial-devices instead.

For the record, I really dropped this patch from my for-current queue
and will apply it to my for-next queue without the 'trivial-devices'
change once we agreed how to handle Bartosz' incremental patch on top of
it. I hope this fits your needs.


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwKcWwACgkQFA3kzBSg
KbbcTg//cRhHyl6Oi7w349QnGL0ZEFb47wqcFPYWmaCPzkAJMKlWbf9IQw7c4a4O
DV2HUjGT2Nu6YU3aGr5wM2LXjO3AiGnoeGyX1glKIcjvaN/r26A77tSX0zzzEU90
4S9C9PV/GmoO7H4BDerJ/d5BBGeu2X6DqIEoC3Qp/gn3kSrxvWAXvALmX+30sKdj
vWuETZKm1G7vYPL1bQG1wrOauZAEwpPgpHwLIWdj2uCmxlEJ00UsQumJEz82sxc5
lYfRjzelW5tg43eqDWV+hn+7pUxz/KL990hHKfAg9NxUszOUdOPOfKX1wb21IXa3
7Yu0qPfAIGVAswbateYTWXqhmgUJPzaoVesmqpLao5SscxXYFSUOff4fdcBFq/Oo
nhe0dgzwajL/O1L4RgV9qh1/mSOCLSO5M79c9QxPTKNEZ0/Hw5mbMZs8aM/T+L/h
l/iduLMSkI4hl4YnBGU+rGQym+oFhPHZXt+TqCB3rjCibXfHMIUIlufIJK3yM+bj
Nkl+enGbyJfZvJ9D5955ziyF/cAliy3v7vx7c0OMyvZOfimMvlycA9RtWRkE8Ioq
c1DTsJHqkJs+6aOZBJu7ImRxmU8rUZU8hqLUigAiat/p/AgqSicpQ7aleb4E0I7m
WBz2fciAP6b09TmiKBzVpk6USInEGvtcRm9OCdKjwQjAt68B2Ws=
=xul7
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
