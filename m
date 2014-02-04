From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] regulator: add bcm59056 pmu DT binding
Date: Tue, 4 Feb 2014 23:21:17 +0000
Message-ID: <20140204232117.GD22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-3-git-send-email-mporter@linaro.org>
 <20140204172309.GG22609@sirena.org.uk>
 <20140204211638.GA16179@beef>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fICFoEfxmEe5Oilm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140204211638.GA16179@beef>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--fICFoEfxmEe5Oilm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 04:16:38PM -0500, Matt Porter wrote:
> On Tue, Feb 04, 2014 at 05:23:09PM +0000, Mark Brown wrote:

> > Is this really only a regulator - does the chip have no other functions?

> It's your average multi-function device with other functions as you are
> suspecting.  Buried in the the MFD driver comments is me admitting that
> I need to split this into two bindings. The base device, "bcm59056" and
> then "bcm59056-reg". So point noted, I'll updated with the appropriate
> binding for each.

It doesn't need to be two bindings - just move it to the MFD section and
document it there.  The existing binding is totally fine from a
regulator standpoint and should continue to be so as other functions are
added.

--fICFoEfxmEe5Oilm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8XXpAAoJELSic+t+oim9S9wP/RT/4yR8J+RyLq6g9t6sk4GR
y/uTK+SKhXg1G2HOKBVWhYDrWO1DYOPVDp7f3dGM6Bm/Qn6NCf69zsYpEjFD/ODq
0sloKa3LWQej64fznnB1geUGpXKl50PFQ8oF0zQl3bC0lHkP3HVPreqgCnafJRra
El5IXge59LQ5tRp8nqhpwm+wfNTJRpXNtEhVoFzn3Y1/HvioU8HyOJuumXLztA0F
hHJP+s6TECeKTHZkLf58Efaz+bMfw4KJbl3sUiZS+gFtY1V2MonXtabE42nxadZz
MRbn3ciiHsCXktN6uFoTykWB/LRaVuCz01JzL9QOqNmFBiotJlOO+IT5CvIsiZHB
EZopZrKL9cCwYiV6sZoIsUwHGNgAM1QWcN+yhg+XhZDUH6jX9sNHYcam8/J9gHwf
7SzsuSZTEHPV7z2MIKvID/DG/Rv/4wJdfsoTpKZR/R7R5v3RyUNhQ9CBHTyQe5/q
KAl7heGmA7NyW1qMw1tZ72Uu7SUGLqgEwYaWgzP/wn5pHxa2vo9tAl5137nme6kS
29nohEvN7rNDKYhw3805XFufQuEJFfNqw03TRmbL61gLvmzS2e5VLfroc3ed9oH7
AWWrUV1VC+FAlprDujdzfsxn5JjDF81riyIS3V9Y/HTFG6kJQ//kj1YVFcHs6Qjx
Mja6JhGEzMrrfLLvVEsP
=NewP
-----END PGP SIGNATURE-----

--fICFoEfxmEe5Oilm--
