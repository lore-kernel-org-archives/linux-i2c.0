From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 11:15:14 +0200
Message-ID: <20160728091514.GA17499@katana>
References: <20160725082813.GA3376@katana>
 <1025301469437877@web19h.yandex.ru>
 <20160725094117.GB3376@katana>
 <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru>
 <20160728074157.GA2693@katana>
 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
 <20160728083914.GC2693@katana>
 <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51650 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbcG1JPW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 05:15:22 -0400
Content-Disposition: inline
In-Reply-To: <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Kachalov Anton <mouse@mayc.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> What I mean is that it is possible to have an i2c bus with some random
> i2c device at e.g. address 0x48, say some eeprom, and then register to
> be a slave device also at address 0x48, e.g. slave-24c02. If there is
> another master on the bus, it cannot sanely use any of these two devices
> at i2c address 0x48 since there is an address conflict.

That is an address conflict, yes. Even for a single-master system. You
need to make sure your slave address is unique on the bus. The kernel
can't really help you with that, because it could only detect address
conflicts if a driver would be attached to a device. If there is no
driver and all communication is done via i2c-dev, for example, then
I can't see a way to detect this.

> Or am I misunderstanding something? In my mind i2c slave support is
> the equivalent of usb gadget support, is it something else?

No, you are correct.


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXmc0iAAoJEBQN5MwUoCm2mSYQAKQfOmOobtoVycTq6EFelZPK
OlgEGivK73hhBN2Sc546/C8qv0QxrUGnr+6RGg7iA1LrcQj1NHp68Q06YxNoloGL
ff1E+OtvjzJplB5JpFx+MWkWyJQC1cE9bA5rCf+njSOOTW6RjxKwYZNAzovMG9OO
oeIRGN9kCMMefCIBPeoRuUHidza+EAVt0GkpVb8nGamF3JnwlfTnTifSItBtcKBh
twYYbSocyyppRuEPqgE6HAouzy19qrlCIMMiBHLeXaHFKOAn7P7veAqyBdcwrQpr
l6TuL/F5SOPU5RIkLE/mJs7UAbcMKfsxye1/qHkX+GXTLcRvzm1u7S1WH4Y2b6Vv
1o41cZ375U3dT7vXiX3Jvz6glK2jVgjpuajLo+4AQED6BbxVjngAoAc7UfQcUbr7
D7J7Jk0pUdVKHXzN02ax2S6twqzTEk9gq5OJMsW2bV5si8rWafK5V5I6R6oFTcPN
lbyvosp2Bwdts05DWw06JFcLYkbsh9klsi163MyCbMWGc6aKZZCUCc9Fe6PnBXbM
4HJ7cFTlKK37FwKaDTDc+jFSESBmpqV+rhwfrlT5fQ7QsKNj2UBBt20H3oOQsi2F
W0W41t0Bto75Vt96sKXzz6UqPzUSuRgJ3FpLW5PTdGBpqn4VNjJUDiUsimTKtwjZ
n5AoGq1u4J7dx/tWnFCk
=a+DY
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
