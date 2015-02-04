From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Thu, 5 Feb 2015 00:35:16 +0100
Message-ID: <20150204233516.GA1677@katana>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
 <20150204190819.GA15467@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150204190819.GA15467@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2015 at 11:08:19AM -0800, Guenter Roeck wrote:
> On Wed, Feb 04, 2015 at 06:47:23PM +0100, Wolfram Sang wrote:
> >=20
> > On Wed, Feb 04, 2015 at 08:23:37AM -0800, Guenter Roeck wrote:
> > > Large EEPROMS (24c32 and larger) require a two-byte data address
> > > instead of just a single byte. Implement support for such EEPROMs
> > > with SMBus commands.
> > >=20
> > > Support has limitations (reads are not multi-master safe) and is slow,
> > > but it works. Practical use is for a system with 24c32 connected to
> > > Intel 82801I (ICH9).
> >=20
> > Can't you simply use i2c-dev to access the EEPROM? In multi-master
> > environments, things can really go wrong, so I wouldn't like to add
> > something dangerous by default. Maybe with a module parameter named
> > "allow-multimaster-unsafe-access-to-large-eeproms-with-smbus" which is
> > default off. But I'd really prefer the i2c-dev solution. Hooking a 16bit
> > EEPROM to SMBus is daring, after all. SMBus is multi-master, too.
> >=20
> Hi Wolfram,
>=20
> At the same time multi-master access is quite rare.

It should still work in those rare cases. A setup of an SoC, an EC
(those like to be masters, as well), and an EEPROM is not very far off.

> Also, many of the kernel's i2c drivers are not multi-master-access
> clean. In many cases that isn't even possible due to the chip
> architecture (a good example are chips with multiple 'pages', where
> the page address is set with one i2c command and the actual access
> occurs with subsequent commands).

Huh, using i2c_transfer to ensure 'repeated start' between messages
should do the trick, no? Drivers doing this via SMBus calls are broken
and should be fixed.

And what do you think of my suggestion enabling your mode with a module
parameter?


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0qy0AAoJEBQN5MwUoCm2IbYP/0y8zyeiFaaQxEdei0/OA7E8
Rik0TBSmmvB2ush23W1086exX+ML/TPRCWPoEp7XOLABe1spet1z+ZSZ/HiotwcR
R/NvhG480ry7WTz0KgtMCg/ckfTCKF/5Es1q3GxcmmkGNqRFFdR8lXJLzaCtycvf
IgxanbVYVP9/a/YUoZ1oACcz/stbatPac/UdYNB2eYvb4Jc8tGN7c6E6H7gCxzLW
Y6xqDvojXWqo1WLH0GJTOB947QOrGFvKLCYsbElDzJfmFb/6YFwDhVeRrE6E+sNf
/PiRh/cEYukAbRq9Rg2OmncTVGeLzBlh2jOHjTGAw2T1vsv/f9meFfr44wYfk74P
C6z5ptzq78acqqvyMtadDGcD9aC3h9nVQ+nzYjTRCpYK911rkT/bnqls75sY6jP8
gPqFdTkF2MFTETCbkQ5nNepQe7KThUDCcWt4ZI9SDkksaxE3GHXnoTMnHtQ9ic2y
NDHj/k1z+dUQ/Ixoi9LlRuPDZ1wlfcofwrW21vLzVMz0fPsmBJ9EUSDjFtVJdPCd
qhnq/uW97xnlbu3IBS8jhywExZgubmrjB9eKd4R6GFO5BuF7hn0tv+tycAY+q7NE
zhxEb436e7OEflyE3iLR019Vd4kMwansewadFJr/uD348/oFHSLSmJVSKQL+hD52
u4dSmPDoijBv6wWMrpHN
=KC0S
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
