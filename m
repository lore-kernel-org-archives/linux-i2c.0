From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
Date: Mon, 2 Jun 2014 14:38:51 +0200
Message-ID: <20140602123851.GB2654@katana>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana>
 <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana>
 <20140530192516.GA4319@lee--X1>
 <20140531134805.GA3287@katana>
 <CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2014 at 02:16:59PM +0200, Linus Walleij wrote:
> On Sat, May 31, 2014 at 3:48 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >
> >> Right, I read the function which provides the functionality, but my
> >> point is; I don't think my patch changes the semantics in a way which
> >> would adversely affect this option.  If you think that it does, can you
> >> specify how please?
> >
> > Currently, if a driver would be DT only and does not provide a seperate
> > i2c_device_id table, then the driver is unusable with method 4. I don't
> > like to have some drivers being capable of it and some not.
> >
> >> Does the sysfs method create a i2c_device_id table?  If not, how does
> >> it probe successfully pre-patch?
> >
> > The sysfs method creates a device. Its name is matched against
> > i2c_device_ids only since it does not have a node pointer for DT to be
> > matched against.
>=20
> Is this really so useful on embedded systems?

Well, this feature is at least nice with embedded:

---

* You are developing a driver on a test board, where you soldered the I2C
  device yourself.

---

Or during HW bringup, you this or that driver for a device (out-of-tree
vs. in-kernel), and hey, the RTC even has an EEPROM at another address,
let's try. Such things are the use cases I have mostly seen and those
customers liked it.

The problem is that we are talking about matching against I2C slave
drivers. I can't see a line between embedded and non-embedded when it
comes to slaves. They are just slaves and could be on any hardware.
Keeping the bigger picture in mind, IMO it is cumbersome if some drivers
support user-space instantiation and some not.

Though, I wouldn't mind if compatible entries could be passed to the
'new_device' file, in addition to i2c_device_ids. Yet, this needs some
extra handling I haven't found the time for, yet.


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjHBbAAoJEBQN5MwUoCm2kYAP/1A/KzgGsKX2iPIq1X/hOail
29YA26NCl2jXu6mVchlNZAjfY3+4XiGNIaIAu1ULHj9wPIicW4JqC3iwEXoC1Ds5
8baCPVMq5GgMZ5r/wOplZVd7SsBsH75BpQJDILVjGBq4aSS1zeXFyf+1aGVewrnE
78SDEXBO/d+qo6QiD1UwJKIAdksPyK7LN+Stq68e9jgXOysM3E8OKE93A/L30SjR
xXYvB1f9rF1qtXP2hTc6AClWrE2FTuKh+XRb/OzR9FaB+L6PWQm/iaTqEXeQAh/1
nMRDZ+BAIzb9MR7kWUkYTxFSZrQCFJN0VQQxAOATdrKBTxf7KHZYAuUpBBxZxwkr
9SsK1rxb1avYKph1jdaAfzhe/qQ/ZMAD99MUkNkH6lASzA94wX1xpAsf8fRPSZgI
v4/f8rWEV4DQs/GjFLrrtf+MaQgDBy6yGYVJ+4Il+1A9UIpdl49kuoQM/7zBxuSU
1rBAFaTey8FFc4KT1LLnhYyUDYhZuxgNlennNQ2tJdA5KvOaogJ3JuR98318upSN
XFSpXd591mGrvlLDtH2fVZZyZlT0gMuvnWXiGHajrK7CexlRyPM98bYbtv7f67FF
eYB9exzomP4s85yrEgDGOy3vuVgErBh/LiGTJ2QD3s/9oufrU4PHzVtn6xzvf/RO
yWHh639wbGnXp1LByCBs
=cf3z
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
