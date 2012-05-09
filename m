From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
Date: Wed, 9 May 2012 12:18:20 +0100
Message-ID: <20120509111820.GJ3955@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
 <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
 <4FAA46E1.4050708@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="va4/JQ6j8/8uipEp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FAA46E1.4050708-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Mattias WALLIN <mattias.wallin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--va4/JQ6j8/8uipEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 11:28:49AM +0100, Lee Jones wrote:

> >Shouldn't this be (av8500->irq_base == NO_IRQ) now that we're tranisitioning to
> >use 0 as NO_IRQ?

> Sure, why not.

I think the endgame is to phase out NO_IRQ entirely...

--va4/JQ6j8/8uipEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqlJiAAoJEBus8iNuMP3dB98QAJCngUbIrCgbzn+7IE1cKDQx
5snehFiScygu3Lik3NRQCbKW8TwTAmbD/az7iKOKQQIurec+JtxaExma4GM5/7de
kYB5BXNOCiFinbubpm7ifXkRd8n7TBZNZJ0qcCXjXlFl0PNiqFVVYF99Dq6C9X7t
ZkJ9MEi9W6K2yB0C5wGj+Z3pBhP9chl6CDA+dhjIBMBuTwExOxn7SC0DKparTAg+
wSadJNSE05HVBlCYIvQIWyYC+mvjk9I9h6n3Jb0s2sYLCfa9ydFKwWRilT39Vdzp
qR7j1YdkN5XfBpCo8UvKSynwoY+Nhqx/1tJx3ij/+uM0z+2iGbzhGv2Mat6G+rF9
lxAUkMLuYt43uSPv7ubDWu9ku8DP0r0cPWylK2yVNPgTexvuMN1Xrw6Rzy2gGbwn
AsApeKY80QDFVuyAUZSukkGJanCSs74IvUu1cBCo9g0YnbvfP7c/SA7e3JLT5Aaq
m9uTWEFb20fXt1Ir1IVa70zNylvw1MyfQHa4ycoCQLXYpFV0jdfzpd24V+CncnIy
hyJnEhWw1E9dv25dbr+DBfLVDnXEf05++t1b9xDauGRohfJQrB8/zF/ERqVl+1qe
weOcbHL2PyCJwVJAoeiNXzTAOovkj/TYJSmF5Ut3xaaxz/ZEeCHaIOmQS1Nt6euT
Tw89qWy0R+OYr52y0tHu
=VGvb
-----END PGP SIGNATURE-----

--va4/JQ6j8/8uipEp--
