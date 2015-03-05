From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
Date: Thu, 5 Mar 2015 23:08:01 +0100
Message-ID: <20150305220801.GE4522@lukather>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana>
 <20150305182817.GB4911@lukather>
 <20150305184044.GA881@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150305184044.GA881@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2015 at 07:40:44PM +0100, Wolfram Sang wrote:
>=20
> > > I don't have the bandwidth for a full review right now. However, I
> > > already wanted to tell you guys that my gut feeling is that this
> > > protocol is quite far away from I2C. P2WI was already at the edge.
> > > Maybe there is a better place for such custom stuff? I dunno yet.
> >=20
> > That's unfortunate, especially since it looks closer to SPI than what
> > P2WI even was.
>=20
> SPI? I assume you mean I2C. Can you elaborate your reasoning?

Yeah, I obviously meant I2C, sorry.

P2WI had no address. It was a single-device bus. However, the way it
communicated with the device was very close to I2C, apart from a
parity bit instead of the ACK.

=46rom that regard, RSB is a multiple device bus, using addresses, just
like I2C. The way it communicates is basically the one used by P2WI.

So really, it just is more I2C-alike than P2WI has ever been.

> > What would be your suggestion?
>=20
> Let me quote:
>=20
> "I don't have the bandwidth for a full review right now... I dunno
> yet."

Good thing that we are not talking about a full review then, but more
a philosophical discussion.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+NPBAAoJEBx+YmzsjxAgwQsP/0qHvSFthd6lON8KruXB0x7w
0P7aRcsx0wWCnOEpsNdOBWDNZuaJ42oxYjrwxcgzYCfGx+bJqNjvajtYLlu0vWnZ
t0QofweIhpO/eRSN2puMRETvJJDNVfwy0lQkObdlsITqxWE4tYSfy6yhTp7onSnP
hhLfpl2p4qaE3IGaFt2pRANlI+cktxcBSIaKWlKRDig9xZehNn/hBiNPVqcM5Ybg
FWDJTkjuJqxwEevZmxzL5Wn17+MewGzUPPDiA2epQDmXnPGXHP3ZRwEGltN4wr6S
H1jLQozWAzfeIqGKO+HY6gyxlJO7da3ECzOXmp2CMPzkrRWKW9B8HXvEfxazSkc0
X9WD7HxSR73Iln1UFFZpyj5lFCXh45hP8zAWC0meHz/BA4aPj9gimyEjaMv1BI3g
WEBAWLTzKSBk57bwQFC0Wv/82jEuPad/rOMyAWG/Uf1QWoVgX6MxXG0Tsu5MwRg9
ypEfXzpLIbpb7PU6U1MmuHhyUve20YYjecrDPNhpSVnDSAszpSn10tUZz7krJBuZ
drYNY4JaHbsYHgQF+XHdhUNfL/QiWv4Vb6NSkQdDBqBmwdRZAkh/PC4brsdqVmW6
18vJ6/4NV/c/Z+e/7ajbNvzIRcUszWrMFm+LQuNtGlGwWwMvLGzbzoL7jrduDeKd
Gm9Sa9Syya7cwt7+yc2p
=b22k
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
