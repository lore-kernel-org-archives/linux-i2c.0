From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Tue, 8 May 2012 15:44:02 +0100
Message-ID: <20120508144401.GU15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <201205081348.14269.arnd@arndb.de>
 <20120508142926.GT15893@opensource.wolfsonmicro.com>
 <201205081436.46471.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xr6Gr0irOxp3+3c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205081436.46471.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5xr6Gr0irOxp3+3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 02:36:46PM +0000, Arnd Bergmann wrote:

> Right, which is what the driver has done since 79568b9412 "regulator:
> initialization for ab8500 regulators" with your ack, so we decided not
> to change that and simply move the init data from platform code
> to the device tree.

Yes, I've never seen the arch/arm bit of it before to see what the magic
writes actually do before - I did review the original code which just
used the regulator API normally but not this magic number stuff which
was just done in the platform.  The magic numbers might be OK for things
where it's device specific enough but the comments here make it clear
that some of the magic number setup is duplicating framework features.

--5xr6Gr0irOxp3+3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqTEqAAoJEBus8iNuMP3dc7EQAIyq8Jwlgts48jaee8/nPlti
fibXBR/Nnb4UKpQz5PO9YBQjpZ3eryoeVuBzNLxCmHqwPoYNjxi6D/1KXKnsZGn6
Fi2UC3pJDeh6IYIvDAZIuL1OiSd5hKyORrYdmjFEIBlsfEtG1LVrlSbg5MB7AZFY
NiOv3s5D+ItOhXDI3WsywPsgoGIWxV32fBkV9G1TUb7wlULnHVhSpLBTuVSZ42/U
A7gK2Zhy/kYDUNN0eaDoPshTQNrdvjw03ZZRDbCKXIxtQjLIIWWEJaDB3e3ZOgaR
LUf9XDEbhWT514lRDbYlFwvVyuTVJBQdTjqFF8O6K+oAhuYE3F0eMutEYsuznVJu
lCmnVtHW5r4j2leURZh6tDJzqF9UI1wlybNKEaty2QrjH1f7g04i2epxcDbI5BvD
nrraSoILzOxMJQssDY1Cfj4BHUUq573v/mHIgtH4+2Ca3wFRky/7VIf4lO1B7Vv7
vaHGYOAhLm1vyu+vns11C20abjhIfUZ23sBeo4VzE6YcDJD7bzSzimvoBS3Wu+77
AaotydaC3od0C6SaC9dXLQOONL1B57l6d3OLO31W5k6iagl2FjzSsp1/ZqqxgIAz
X+i96+UH0TRAayUrdASRnyMcKx9x1xl4vckJAGAecqGgvdH/PN6X5bDaIN1YOILv
I4Q5BVZUKtXF3S2AXuch
=nNDT
-----END PGP SIGNATURE-----

--5xr6Gr0irOxp3+3c--
