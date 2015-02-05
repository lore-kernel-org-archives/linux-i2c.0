From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Thu, 5 Feb 2015 15:40:28 +0100
Message-ID: <20150205144028.GA4865@katana>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
 <20150204190819.GA15467@roeck-us.net>
 <20150204233516.GA1677@katana>
 <20150205002630.GA396@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150205002630.GA396@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > At the same time multi-master access is quite rare.
> >=20
> > It should still work in those rare cases. A setup of an SoC, an EC
> > (those like to be masters, as well), and an EEPROM is not very far off.

To clarify: What I meant here is, at24 should also work in those rare
cases reliably (like the described case of SoC, EC and EEPROM). Your
patch sacrificies this reliability.

> It won't work if the 24c32 is connected to a controller which only suppor=
ts
> SMBus transactions. Also, there is no problem if it is connected to a
> controller supporting direct i2c accesses.

I know and agree.

> The only real solution is to not use an SMBus-only controller together
> with 24c32 or any similar chip in such situations.

Exactly.

> > Huh, using i2c_transfer to ensure 'repeated start' between messages
> > should do the trick, no? Drivers doing this via SMBus calls are broken
> > and should be fixed.
> >=20
>=20
> That would require all those drivers to have two separate implementations,
> or to declare that any such chips must only be connected to controllers
> supporting direct i2c accesses.

Yes, TBH I though this was the case. Which drivers did you find using
unsafe SMBus transactions?

> Both isn't really practical and defies the real world, where any kind
> of chip will be connected to SMBus-only controllers.

Is it that bad? The vast majority of controllers I come across in the
embedded world are more like I2C than SMBus controllers. They have their
quirks but most support repeated starts somehow. This is why I came up
with the quirk infrastructure BTW, to describe what the controller is
capable of and what not. So, users can check if the controller is up to
what the user needs and then they can decide what to do if they
encounter a too limited controller.

Back to topic: I2C and SMBus are multi-master busses. Drivers have to
cope with that. If we say "let's assume single master busses, because
most of them out there are exactly that", then we open a window for
very subtle and hard to find bugs for the multi-master case. And people
would get rightfully angry IMO, because they should expect specified
things to work.

However, if people are connecting I2C devices to an SMBus controller,
well, they ask for prob^H^H^H^H special cases and they need to deal with
that. And using a module parameter is not much to deal with if you ask
me. BTW another idea I got was that a user could mark an SMBus
controller as "single-master", so a driver can check for that and use
some fallback.

I am really all for the "better-safe-than-sorry" approach here. I am not
objecting if somebody wants to move out of that area. It needs some form
of "yes, I really want to do that" however.


> A worse situation would occur if the chip specifically
> (only) supports SMBus transactions and thus doesn't explicitly support
> repeated start after completion of one transaction.

You lost me here. Is "the chip" the master or the slave?

> This may or may not
> work depending on the chip or even chip revision, and it usually would
> not be specified as a valid transaction in the chip datasheet.

Can you elaborate, please?

Thanks,

   Wolfram

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU04DcAAoJEBQN5MwUoCm2DJcQAJ1UVdKqp+tTvzXEx+8+NKNc
4V3g3R55PkLEXw6C/mdgDawbo9Vd0a9ZtBKfoBCdbltZ13cuMsD5hIVtFzjrHdxJ
yS2hkIBaZ6uVOBmPlUMuWawrC+W5aq+/7KpOHBNousX2NP+4AN0ku5x8/UFAeIhL
PQ1RkVA30k32V7OkZIXmEAPLbKQTJKk2PEV2XiAUw4OjFEUEIVi+Byowk1motJBk
+u0CvWqw+s92XhIloiTslQdKdl34hllOGJOHUXp24+Dqfbf2Zv4XNfTOVFCfc/tk
QqFAUKv6Ps1MpFRFtgDMqHujfYMYCR/cZNI3+tNHW/g1Xga3N0zARuZkmYyxnf+X
rgl5qvXIYEXa3ap7qssAYbYgwKjb8rHocLs4jqx+8s7AyZj9lRTXjhqGYI6FSBLT
yD15/ajl8NkNHDsZ3zfMv5YJk97adhKFVRWFsT8J5XvhBOw7bmkvxFl9Cxrt0mDx
tnFkPzzFD4JG84U+XtM5EhLA/V9moAdJYjaVK/NuSs5Ah4KPNP4Cy7B95FZgHVJI
PxpqtWpRpoR2t79YgMR7LxhxoM7nklAVnJDHgkEeb7HohRgFyP9s9Pg1dXdqfe12
PjS1OfQaGbIZ1KALsOF2hQ7C84HdrvjaMSKsKRbYaEZWEobRbKDCdbTbKtpSeZ7S
JELqfKcXER+mvMYdSQx9
=CPqA
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
