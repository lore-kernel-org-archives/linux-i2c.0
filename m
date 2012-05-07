From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 12/15] drivers/regulator: ab8500: Split up probe() into
 manageable pieces
Date: Mon, 7 May 2012 19:44:54 +0100
Message-ID: <20120507184453.GQ17002@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-13-git-send-email-lee.jones@linaro.org>
 <20120507165838.GN17002@opensource.wolfsonmicro.com>
 <CAF2Aj3h7pgh=Kbt+M5Xd_RDRbJN7K+WbaH1+8nM2Eakb1QNpsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MXxcbiX/Q4+iy5U7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF2Aj3h7pgh=Kbt+M5Xd_RDRbJN7K+WbaH1+8nM2Eakb1QNpsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MXxcbiX/Q4+iy5U7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2012 at 07:04:59PM +0100, Lee Jones wrote:
> On 7 May 2012 17:58, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wro=
te:

> > This doesn't apply against current regulator code.

> It doesn't? I rebased it onto -rc5 which was the latest at time of
> submission.

This isn't a bugfix that should be rushed into Linus' tree for 3.4!
You're missing the best part of a release cycle of development here,
including at least one incompatible API change. =20

If you're developing new code you should always submit against the tree
it's supposed to be applied to; as a rule of thumb -next is a good
approximation though subsystems do things slightly differently,
especially in the creation of topic branches.  Even where the code will
get applied to Linus' tree then merged as a new topic branch you should
verify that there aren't any other changes in -next that affect it (eg,
an API you rely on having changed or other changes to the same file
which conflict with yours).

> > Please also at least
> > try to use changelogs that match the subsystem you're submitting
> > against.

> What do you mean? Isn't "drivers/regulator" in the subject line enough?

As I said you should use changelogs that match the subsystem you are
submitting against.  Essentially nothing in the regulator tree uses
this, as you should be able to see from inspection of the changelogs:

$ git shortlog next/master drivers/regulator | wc -l
1059
$ git shortlog drivers/regulator | grep drivers/regulator | wc -l
6

Generally everything uses "regulator: ".  You should always make an
effort to do this for whatever subsystem you're working with.

--MXxcbiX/Q4+iy5U7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqBgfAAoJEBus8iNuMP3dhFEP/Rk6ifDpDDcDYbupeLZIAd8w
ZA6cDIyGMODl67cflfLoSUcE2RqDsBwBGhGslZkcDWhW3dsTItqCPAAzwTybF7AU
QUjHv5zVcR0wXDZCwnHllrNEUy6RltR3heRnbUs1nWgPykLBFVCiA5J8mkgISSNc
6zs0KHL8viXfKhF2E8WC9z9rBReNHp2FnrYQ4fZWSVybLCrxBaolbP354aWA732w
GuJ3vUCyiI8IZIRmBl5dMFCkWFgAZr2M1zujuCAeEAj0zQkfu2pzHwjfDDeqMSaj
YNv+HF5WWN3m7F0qq3Me6KrRCWAnrgLwQVeoj1nWuF9jnJcBo989JiM+oZ0RDjzH
gGW86AULcb0nZYJuJfgA0lQzEvQ3dK77IikrByYREhSwcbIPVltl+6sKkYDvY8T8
DxWiqK4nS5jb7k0N7vVVKtEDfSxhY0MOmuF6f1475iEmkufYLDySWlI462IXmYcI
zz8zbjTQTX6jekWHzE9923W4YYi58TktLAO/iyQPyWSTKTr3+q//lAWNY6CgfPvs
5HfO2GXiB6otaeDsd0Zzt77wQMQtJrSHKVo54xNEkGx5Sy9SFAzBhJhkG3dz/LDG
+ToGcLexJOuPWKwORIXh23/2GvNA/hLDCmXc8YSUqk/GCIwH+nIIPZ1y6FiJHMrh
+80N/t4Pxyq/EqP3LZXB
=WDhe
-----END PGP SIGNATURE-----

--MXxcbiX/Q4+iy5U7--
