From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Raise SDA for each received bit, if necessary
Date: Fri, 13 May 2016 12:33:56 +0200
Message-ID: <20160513103355.GE1778@katana>
References: <1461780714-20378-1-git-send-email-tdz@users.sourceforge.net>
 <20160512090544.GB1638@katana>
 <5734AD00.3050904@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53225 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbcEMKeM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 13 May 2016 06:34:12 -0400
Content-Disposition: inline
In-Reply-To: <5734AD00.3050904@users.sourceforge.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Zimmermann <tdz@users.sourceforge.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I was playing with the DRM framework and an old SiS graphics card. I
> discovered this issue while trying to read the EDID from the monitor.

So, there is no upstream user yet?

> I have a few other SiS cards/models here and they all expose this
> behavior. So I guess it's intentional(==cheaper?), although the HW docs
> don't seem mention it explicitly.

OK. Well. As this flag is potentially dangerous, I would prefer to not
apply the patch unless there is an upstream user of this. If there is
one, I'd be okay with applying it with the flag renamed to something
like "dangerous_push_pull_bus" or similar with additional comments
saying there is some (broken) HW which needs it but nobody should get
the idea to design a bus like this.

Makes sense?

Regards,

   Wolfram


--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNa2TAAoJEBQN5MwUoCm2ch8QAIOK/nG+VLM31WMtfvlFB43r
kCrPC7z9ZgQJkKnx3uz8ANvcif/uI4WSAlacvv3aJNWhBvf4Mu0bHuuF7r1YEas0
ft1/3D6vwSGqFnyJFWEFvJNdC9R/0RGWnsphrNidM/x100sHJvLV0q9YLAqfkVYk
bcUL96HMoEj7s5FVEob/aCkXV4Ic7kCSbJyZdxWHbf0bWFP3EvMoMqJRawPdcsG1
wHtY9GuxfN+IAE/4IC8sHeZMv6Cp276JGIHUop00wFCRamC5OgytrkvJHSd91WFp
fKyTnrQfcbHZQsjeJnBFttzawis4rnAKwCXgXAA47bG47WQi5xihXPaJW6ar1IoP
QrVDflI/lXtRYcERDEmyr+8qnLOXDpHkK3thi3I2ebFxcBolop6kF/fqEhGG0OQ0
KP4WxQjaPxXugSJhJNfbXazU4cOcpPwUSZGtUtgrmo6ZrHHA197Rexi87Q1JF6Ax
inS6HNBbNcNQpDOKqMNMl0U/o1mq6Qe7xAaoHBWLQKRQFRtxx54S4DY8uZxp1+sV
H44MTTliCPutwgi0awuWUlBueP/ccfVejJa3QlOBm1RaxcyXbSYtG9A96cCUtnNk
tOhJ7Wcnyfo1SX62xBaMZGC5qUgMP2mffOyk286qEf+aZJNTfbLa/8hKLnpprNm+
8UjdfgE0hDsJ+U1kfXod
=eEMW
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
