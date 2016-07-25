From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 25 Jul 2016 10:28:14 +0200
Message-ID: <20160725082813.GA3376@katana>
References: <137031469256709@web4j.yandex.ru>
 <20160723195114.GA2104@katana>
 <27421469430128@web19h.yandex.ru>
 <20160725072151.GA1599@katana>
 <354241469432837@web19h.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50612 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbcGYI2T (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jul 2016 04:28:19 -0400
Content-Disposition: inline
In-Reply-To: <354241469432837@web19h.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Please word wrap your messages.

> but the line is muxed until timeout or answer received by RMC. BMCs
> are passive and only responds to requests.

OK, I see.

What about serialization? Can it happen that you send a request to BMC
#1 and before the answer, you need to send an urgent request to BMC #2?

Is it common in IPMI world to use muxes for this case?


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlc2dAAoJEBQN5MwUoCm2k3wP/AqrKXPd0c5nPGAMFmEaeWth
egP9/5VFqgJ7SNgJcJRhup926HiveXTaB5i4C/JZIfJg+aoxSTPqFISxK6ym9ON6
SHere3IScxp7wwErajZATrzW3OfixLaxHXrl55VjgxJcb2dRe9fX0BBovqDrH818
fPrEloyVtjnuUSywPC6xWVdkE9i1iQRHItMLZP4MD15VB5rX0rGrXW8GvP6ioWn8
mbLxcx8xGnzt9VMQ/UoKCOlCDX9MfqSHopuB+ChZf+Y9wC7bfrOZpt4+rqCA+ZCT
wNNo/uznVSE3ocquHeRwmFlzsqc5coG6mZDkgN4DurY3pTxJ1qVuHldf5D9Us65f
rTFDaFI5oL6tVPsGZjkwkjhrsQngw7ijVHVprDGLhYf73mxfaMGJ8dIobY1mZ6yY
iuo6geSM5JM2C6NqaAo5I+Gmgl2R531CjyFV9wi8lvXLHdhDEsHWkbxzoq5cSQ0J
k8/yDpN7/ywNWZ9rrj28yQRpIwHD65Vp0E3ahYN7sCirTliVZcL+cEqEmi7q6P39
sks3DXx2TOKnnIRTmlISS7aqxcUIdM3KCCE2kZnxVsHR3AV0xAambm1+xVF21QUI
iR92B+sZvE8QtHWgu+02u+NXwhYnxKZxvULFVDKYyBTNiwP7ApIoCnfb/k7j4PF8
Bqkxmf/EsgfHVo8gC/Oa
=YLui
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
