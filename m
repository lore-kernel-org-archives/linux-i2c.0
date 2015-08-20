From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Thu, 20 Aug 2015 17:57:29 +0200
Message-ID: <20150820155729.GG30520@lukather>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch>
 <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150816131130.GC10094@lunn.ch>
 <1511754934.28154.1439739426390.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <55D1DB24.8090602@linaro.org>
 <20150817130945.GE7537@lunn.ch>
 <55D1F6CB.2010606@linaro.org>
 <20150817152504.GI7537@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgr1mbP1ee4HJQ5m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150817152504.GI7537@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org


--zgr1mbP1ee4HJQ5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 05:25:04PM +0200, Andrew Lunn wrote:
> On Mon, Aug 17, 2015 at 03:59:23PM +0100, Srinivas Kandagatla wrote:
> >=20
> >=20
> > On 17/08/15 14:09, Andrew Lunn wrote:
> > >On Mon, Aug 17, 2015 at 02:01:24PM +0100, Srinivas Kandagatla wrote:
> > >>
> > >>+Adding Maxime in the loop
> > >>
> > >>On 16/08/15 16:37, Stefan Wahren wrote:
> > >>>>>Another question which spring to mind is, do we want the eeprom to=
 be
> > >>>>>in /sys twice, the old and the new way? Backwards compatibility sa=
ys
> > >>>>>the old must stay. Do we want a way to suppress the new? Or should=
 we
> > >>>>>be going as far as refractoring the code into a core library, and =
two
> > >>>>>wrapper drivers, old and new?
> > >>>I think these are questions for the framework maintainers.
> > >>>
> > >>One of the reasons for the NVMEM framework is to remove that
> > >>duplicate code in the every driver.  There was no framework/ABI
> > >>which was guiding such old eeprom sysfs entry in first place, so I
> > >>dont see an issue in removing it for good. Correct me if am wrong.
> > >
> > >The reason for keeping it is backwards compatibility. Having the
> > >contents of the EEPROM as a file in /sys via this driver is now a part
> > >of the Linux ABI. You cannot argue it is not an ABI, just because
> > >there is no framework. Userspace will be assuming it exists at the
> > >specified location. So we cannot remove it, for existing uses of the
> > >driver.
> > Am Ok as long as someone is happy to maintain it.
>=20
> Wolfram Sang has been maintaining the AT24 driver since 2008. We need
> his ACK to this change, and since this is an i2c driver, he is also
> probably the path into mainline for this change.
>=20
> But we should also look at the bigger picture. The AT25, MAX6875 and
> sunxi_sid drivers also have a binary file in /sys. It would be good to
> have some sort of plan what to do with these drivers, even if at the
> moment only AT24 is under discussion.

It's true that this is something that we might have overlooked. Is it
expected to maintain that compatibility when moving a driver from one
framework to another (and this is a real question, not a troll)?

If so, we might provide a compatibility layer to add the former file
too, protected by a kconfig option maybe ?

In the sunxi_sid case, I'm not sure anyone will really notice. It
wasn't used for anything but debug at this point, but it will be
noticed for the much more generic AT24 and At25 drivers.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--zgr1mbP1ee4HJQ5m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1fjpAAoJEBx+YmzsjxAgMOMP/A0+ctzCZB68QBQme5/xuepA
BOMRgdx98SsuTVfrAQlppI3pb1yiAcVGJiCvfCkjPxMF747elfkLSi461YfjyfY0
YKE3kxXOU9XyCG7rNlO080WNvcwVtDTZ/xUr0HEv5r7+eBIiFJCCK9abbcBFeZrf
xlRJlvYHYRbVkk2Gj6WDACxR5cUaKb6fCEiGiU9FNHwOP3N0+yVrdW2S9t0NOE7K
bW+nJjpFvSugJakSzwIBP5nBaw4cWtt4MTCHAfSi7lSqoyE7gmCpYBe8CEMrJrHW
Gud+IsWpXgEymWcDn7xLX1U7OjnuwpkHUenhKVFEJEiNc8HJTAGHjhcS9aZoopYf
3G9AHZToDmDLYorUqxnJqLidGIR4xl4Y7oHMCi+KBz9gMGFNybd6NPPE8f1Epte4
xBfLb9fbu+oKQvWh1d7RDhbPBZhzwdzmO719iKP0G3hYxjo7shoEZoiuA44WPY3g
ehDaUIB3HiZd8pfV1l5vj3PAcoe5CqwYvhNzuq0aGC8kXB8DeYyot5PqaJuJnBC1
g15v47zrlVMTcZUNuDDOkR3fgXjD/Kz7ot0Wwcg5zJWjp+l7xCYV+RKmtP7z4MAf
krjZ/q/2wGENZ00Wr2gWmwyTPnEIHANBaFcbUdHfQNMvvxGVZj1xumNNcyEf1JQm
Gv3gQ9PxARPh4ZDUj7Sr
=/1yM
-----END PGP SIGNATURE-----

--zgr1mbP1ee4HJQ5m--
