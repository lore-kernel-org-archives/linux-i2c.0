From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Question about I2C driver upstream from same SoC vendor
Date: Tue, 21 Jun 2016 12:59:54 +0200
Message-ID: <20160621105954.GA2263@katana>
References: <CAOAejn0EaPQK7A-YAN1RC6dVEB5wxtVvWq9Z0D0GnA66N9GoVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39957 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcFUMB4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 21 Jun 2016 08:01:56 -0400
Content-Disposition: inline
In-Reply-To: <CAOAejn0EaPQK7A-YAN1RC6dVEB5wxtVvWq9Z0D0GnA66N9GoVA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Cedric,

> I am wondering if it is the good way of working as I noticed that many
> maintainers prefer to have one driver that support all IPs of the same
> SoC vendor ?

Really? That doesn't sound too healthy to me...

> In our case, I think it will be possible to support both I2C IPs in
> one driver called i2c-stm32.c but the code will run of readability and
> will be difficult to maintain...

I think a driver should handle the same or similar IP cores. Quite the
contrary, the same IP cores can be found in SoCs from different vendors.
They should then *still* be handled by the same driver. I usually
compare register sets to decide which way to go.

For your case, this sounds pretty much like a second driver. Good you
asked beforehand.

Thanks,

   Wolfram


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXaR4qAAoJEBQN5MwUoCm2zS8P/2Qaq82RNWzaCijpG4V8kl2d
py6eLn7BDz0im1wizt6tWTLugWoV0HCF6jAUJ+xS9HxDSnkKzq7SEogzFoOIzwQz
5Q/Px6Sqtnd3DVCvvwqsTu5KuXb4CxPNetECzoPNYmnSk4YodCW/WBxI02Oq7N4p
CXGtT33zYn2x/nFkzbNLystc3UyjM4RzT8RLI24ylhMrHUzpm0NfVgr0CZz0IM91
+Wz3nd17OA70pwmyfmXEBCWHIMTYEjg2Xc711qjYKpOa4sBCaRp0/zzngzTfbpVX
ysODOLVi24wx6w2VmTMP9U4PR91kPlZoq9MIIovKVvUzXiEQOE7jdE1yjKDCRA7O
pLQH6d+cOi5qJcmviWvAiLBzdATnJOsCtiazjPJku00VwYkY9IFLzWw5Gdw2BMwb
4yGhd194VBOxcEVZDhN6KmaJ615lGbChTODB15OcrF/ZUlDW5vDpEhS7pPsmE4Rm
0O8uAQFbSlE6KFIEu78HZU2RYWFihnYqrbcM1JOKOYBW+O+cHC8tg2O803dpNmBV
kljjZFd97FVpy9hPERUcxYQDCyle+sQl8CPDGXEriemqKun6EYsbwgBzBS05wkc1
BW5qZSY+gMBJhfkNWe/tM7tUsrFgo413b1IRhy+upR6AqucmVV2RNQeny/8pyi6R
QtLXzMSLcrKGCdf6rwat
=1YAJ
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
