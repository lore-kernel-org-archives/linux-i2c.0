From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c/gpio-i2c add: add DT support
Date: Tue, 7 Feb 2012 11:25:47 +0000
Message-ID: <20120207112547.GC3332@opensource.wolfsonmicro.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
 <20120206160907.GG10173@sirena.org.uk>
 <20120207025624.GB15647@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120207025624.GB15647-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2012 at 03:56:24AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:09 Mon 06 Feb     , Mark Brown wrote:

> > > +	- udelay: half clock cycle time in us (may depend on each platform)

> > > +	udelay = <2>;		/* ~100 kHz */

> > Why not specify this in kHz and do the conversion in the driver?  It
> > seems a more intuitive thing to be specifying.  I appreciate that the
> > platform data used udelay but it seems an entirely unintuitive thing
> > from a user point of view even if it's what the implementation wants.

> because it's not accurate and on some platform you need to adapt it so we keep
> the udelay

Then you should clarify that in the documentation, it's not the cycle
time but the delay between GPIO operations which isn't quite the same
thing.

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMQomAAoJEBus8iNuMP3d2I0P/1RCN1jbV+kJoV3J07nleC3i
Rnxnd0WI+9shpVRCMQmfBGanJ1m6LUoqJwP7Reha7lYA9sRX8T9IEWOsdW2a/73r
5iMZudmelXdiDgqNApS1UEwGnFKG7zdrYW7fIWkOPRE5C5T6aXy6uVieYi64a9Gy
ZgayzPQQqekeBDJUtV2SjsNZHWUWoNyCwmI6eBjLjkIuNFB1bCbTqtF7+nlt8TP+
PdLR0BRBZBPOe5LInEcVfGm5QI8kuT9s5RHX1/EjvKTYicG2cxp2WQpydygbg4pp
tfIBpHndV6QvjZs2ov7XMVsmshU30K7Utah0MlKJIaTUPOi+JJo5GQY/11hPrGCB
lFYV3Al9XAUXSIRTu4J7oN544S2wjqqWzvkAiPJpkyT7RSKp2I/N/CHteVOYUYav
Y5CE3fcV8ubCDrZHLJ1tuIo7WkZc+3NIpoHbdrbtO8zfEvy40EkreshSnlR40cF0
1plKkVRBP8gNQqRnV8JfsXwQdUqw4urCp7B97v37iyN62LtbRwRj/plEwU2SpJ3S
Gc2VlDATI0QukwCL7SfqoB6XANRh9shEduz8V+iCCUJkA6paOUFyBOGFvP+ACmsr
1JqmwXbQpHfOgz6XbfzRRhLRR14LtX2tiisHcOgI2/YiKIRQAbsYPhXf+mjoq4kW
SjNCsr3f04wIVBpQ+0C0
=Js//
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
