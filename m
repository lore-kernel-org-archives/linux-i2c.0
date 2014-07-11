From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: efm32: correct namespacing of location property
Date: Fri, 11 Jul 2014 10:38:31 +0200
Message-ID: <20140711083831.GB2786@katana>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
 <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140711082826.GJ11056@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140711082826.GJ11056-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > +	if (!ret)
> This must be "if (ret)". I noticed during testing but obviously forgot
> to fixup before sending out. Should I resend?

Yup.


--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTv6KHAAoJEBQN5MwUoCm2FPYP/2XoHdKINU2SghgXWBL+EhIO
ctfVKo1lodyZ12nAld/dLNeFX5qRTQmSokSXUuReQDQAGvZEpIy9pP2QrvZJfXIj
KZKF6j19L2c/SX4uA6dJuRckFLKYSskiYuh4QlfS+6kQd15cdSXjttYNDj6xn713
9f2UnzMmGHYIOtDgTar5v1wPohLaE+yyNiOtaYHs8iYLcdq74Dw7wVnfL7/uQnx8
v7wpsIXNTEC3JZ1BTsh5NdGXcytB4YIEdZ5JeFYfFj+LwtsR7R97+JwoWQjCFCHD
ACfZHe2GcSkVbTmdPlVAHEHViVRBzFtxqza2VFzFUhGrxjZLmoj9EVjE8E+U8tLz
NWLMjS/ukgEDHgjsUqbGPeRZV2uTyXiT5RafZ1vbTm478JGoOzTbXopFe1VK/xen
L1ovv77uBIqlBiquRGMqwCtOwxGkMFM05LzxfWlw3yc92uyFBZ8u2OxYwn/FiC3K
yvJ9hiAFX7T4lD0F6g36yEjfKdhn0aihGJkkKVhxD5JXGAZpIuYrCNrfkYVrAk8I
YQ6jDW3f56CMGHWSfRQ/iz0KFz+82P94VEdnZ78qLly7JljCNUid2/UzrE3q08pu
r7IsagA11ZnK5MLWVL3svEb/MyCcjjxmtdb8ghWJUMCpuBvYI7ykxjTRZtGaCLgh
MqWOGtbyDFgO5hVomlRW
=ze2d
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
