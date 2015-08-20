From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Thu, 20 Aug 2015 23:52:23 +0200
Message-ID: <20150820215223.GL30520@lukather>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch>
 <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150816131130.GC10094@lunn.ch>
 <1511754934.28154.1439739426390.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <55D1DB24.8090602@linaro.org>
 <20150817130945.GE7537@lunn.ch>
 <55D1F6CB.2010606@linaro.org>
 <20150817152504.GI7537@lunn.ch>
 <20150820155729.GG30520@lukather>
 <20150820163851.GG27457@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pfJPkqu8nAxkAh8+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150820163851.GG27457-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pfJPkqu8nAxkAh8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 06:38:51PM +0200, Andrew Lunn wrote:
> > It's true that this is something that we might have overlooked. Is it
> > expected to maintain that compatibility when moving a driver from one
> > framework to another (and this is a real question, not a troll)?
>=20
> Yes. There will be user space applications reading from the eeprom
> file in /sys. In fact, until the NVMEM framework arrived, it was not
> easy to access the eeprom from kernel space, meaning the majority of
> users must of been user space...

Ack.

> > If so, we might provide a compatibility layer to add the former file
> > too, protected by a kconfig option maybe ?
>=20
> There is one other detail you might of missed. Both AT24 and AT25 do
> have an in kernel API. In the at24_platform_data you can have a
> callback function "setup" which gets called when the device is
> probed. setup() is called with a struct memory_accessor which contains
> function pointers for reading and writing to the EEPROM. A few
> platforms use these for getting the MAC address out of the EEPROM.
> And these platforms are old style, not DT.

Actually, we took it into account. The in-kernel API is even a big
chunk of the framework. The only thing we still need to figure out is
what interface we need to register cells statically.

AT25's memory accessor can be removed, there's no users for it. The
only user of the AT24 is some omap l138 boards is mach-davinci.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--pfJPkqu8nAxkAh8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1kwXAAoJEBx+YmzsjxAgJIQQAKgrQXsm1DMC9SnC+AiHJKVk
49mnoS1ZJwI6DzgvzF9TWDH3lUabYjMDVg7JMMIfHnu+k0AJ0vIqeeiYlLCzRYxl
dXLw0BbINwjdODAPhDisuPK5jpUBjPw5KNAzQvgvHSO/sHW1pcUitdp7S9pe5z1U
C/nf0t/1OR+A33tKeHeX45Bs4nnBHV94pmS6sAEXE7b7AIHQY/YGtlmDtStRA/RC
FPxpv/qyrKtH0yPlG5LletHyF2ZZLzh5UQeq60evPrvXpyocvlz/cLp6a/oR6pkc
BTRttLH/R0BByRjandl3utVwyD+PbV1gOfaFE0xUKZ+fORIQQ+O1nwvJqcv9+Agu
ce2cWUh4i1vnzcGaXWYyABYoVr/G0KvG6BRXBA8vk8fF0aMP3OztOBLRJA3o88/r
Puv09Kwi9Ows2t0kNzxPaSB1CWigEs/0Y1fIDdj0gSv9/syIkndDtQ/MBU2NQ6Wr
q8z1i5Jz2eP6KQ1H0fO6hJg6HwAIepZpxBVSOohhN+5DhoEIGPGjbIzLBkOHPn4U
45c+e2YxNCk1c79Fv5n3X9Cr0op81YNdDhPijFz84oX1dUAKJqmYzH8NUqJcxgn+
03XkguYcluSDZmf+XiFdo6lZeDLDqHhE2I5WqYBFq7bsehZ2h4UbwpVxbY3OPoXo
KEksC/U9BHqEtccCOTWB
=ikW7
-----END PGP SIGNATURE-----

--pfJPkqu8nAxkAh8+--
