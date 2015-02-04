From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 4 Feb 2015 18:47:23 +0100
Message-ID: <20150204174723.GB30930@katana>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Feb 04, 2015 at 08:23:37AM -0800, Guenter Roeck wrote:
> Large EEPROMS (24c32 and larger) require a two-byte data address
> instead of just a single byte. Implement support for such EEPROMs
> with SMBus commands.
>=20
> Support has limitations (reads are not multi-master safe) and is slow,
> but it works. Practical use is for a system with 24c32 connected to
> Intel 82801I (ICH9).

Can't you simply use i2c-dev to access the EEPROM? In multi-master
environments, things can really go wrong, so I wouldn't like to add
something dangerous by default. Maybe with a module parameter named
"allow-multimaster-unsafe-access-to-large-eeproms-with-smbus" which is
default off. But I'd really prefer the i2c-dev solution. Hooking a 16bit
EEPROM to SMBus is daring, after all. SMBus is multi-master, too.


--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0lsrAAoJEBQN5MwUoCm2VuYP/2DurOnQypsERp/NDUc2/0cB
sR0xi/dPtFHP60ynTVJ3rmyJ1rlLAprDpSvdOLZm7AyeRqLa9BE0EDoILABwWADO
zUDJd7OhfNsGRNWiFmXSxjPsSbU1ASHbjF3Np53Q8ISjZkogI+R0wjqXiW0P0/yk
SHcmBu11r0Kj2W6iXToZxe0PP74QbDH4pT4nv5quIRJe6udJHkGaA/eI4K8/iUj9
KH8SvPZDfCb25bd/0ibMD6WlIMegmORpEjLUmiK9nZIVKA06Zv+LRNw2L59Q5lyf
NosY6jFpI7b3WA/iGOvI1tABknCC5mIyO6E/kkNdPwEkec5qwra7OdPj1mysSY6N
UH52QgQQ96AXPX60A4m8rKO1aLMlxjEuptnsEVqvcXBkntVMvEh6tcj49RW5CKMU
JpiWfz3GM8BilmjYbW6uJVc1mz4qfXz+s3lfr8FoAmh6WseONDY2Gk3try95xQeH
xoD91iSYhpnssgnwnfi0LX9mgsDzCvjkdcaVlt3rsvZs0Eb36IOVR/2Y7HCXCmLq
TLkK61jyjSjFyhgvGDVv5+jHkiPTzMZ+BStciecELUBG+h0tFjXPybfscozR+HWp
d3KuU8Bp6PrAFINrY75BeQfwfr/AQl+fKDKQaseSMLew5mMdPT4g/HKuRFu7otFb
F0xqgB83m8dBH8Zua6S2
=3Y4M
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
