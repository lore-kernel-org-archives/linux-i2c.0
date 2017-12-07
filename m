From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: stm32: Fixes multibyte transfer for STM32F4 I2C
 controller
Date: Thu, 7 Dec 2017 11:52:29 +0100
Message-ID: <20171207105229.jxxyfofsgub27nip@ninjato>
References: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <990c3275-35b3-68da-453c-d1a80e867df7@st.com>
 <CAFvLkMS6+o3D88Rj23of56KtjonwFAVD_aEP3eWaA2H=U5WP4Q@mail.gmail.com>
 <2d892fec-0496-8a6f-51c9-439b933d9975@st.com>
 <CAFvLkMS9Q801biCBYp+fJeiOo22zr436Td43PH3GG8E6diSL3A@mail.gmail.com>
 <b24d9699-a88d-6a83-ceaf-140ea8b4db97@st.com>
 <CAFvLkMTsgxpjoGRgq7J0NFkT=YsOTYL6smkVhOPcfD=26Hzutg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d4fgqqllg7ccxuer"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55634 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdLGKwb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 05:52:31 -0500
Content-Disposition: inline
In-Reply-To: <CAFvLkMTsgxpjoGRgq7J0NFkT=YsOTYL6smkVhOPcfD=26Hzutg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?utf-8?B?UmFkb3PFgmF3?= Pietrzyk <radoslaw.pietrzyk@gmail.com>
Cc: Pierre Yves MORDRET <pierre-yves.mordret@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>


--d4fgqqllg7ccxuer
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2017 at 01:45:43PM +0200, Rados=C5=82aw Pietrzyk wrote:
> I'm afraid that didn't help and the problem still exists even with
> those patches applied.

So, my reading is: There is an issue which needs to be investigated?
Does applying the patch make sense until the issue is fully understood?


--d4fgqqllg7ccxuer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopHW0ACgkQFA3kzBSg
KbYcNQ//WkZewKf9TfEm55nmiUUH5Yano5IJRkezW4whhjN6/GnS1oakSJb/0sE3
xNLPRx4Efef1oSH1nE/CmQ9LlRyi9pV68Ahyl8bQ+T9HfY3ZL0s28IxLEvZZSbey
HU+4a/O6DzuqJMCRikh0u0OnR9CX9SrHLsq0d1u9Tu9qAoxyo9RuGpZKcLAslhVJ
arFqn49b9EqcXc7EGmhpO50i7AiELpaSpU/BIs3Zmy19TPwYn/GYFKAX6PzOBlyb
aNgasvO9jhM0lQx7oFmRUlMHFPI53cG8CJrX0x56WSlP0gGQHTQzrRIMbdMxZ6Wn
vBeJByDhn7kVnxxzW+rsLE3M7Nhy1DtG7M+bziw1rrGpQsozfHCg5lsrASKAAthW
aqpiqmHsaI+nZiS47SvY5tbpRkUhhhuKGTTZq7n/f7a1865JvyG0xcXP3S3BTwMw
E/Mv7v2OePeWU7WxvhIpA/pGVTBPWbiFy5xgcs+i2rB5MMDcbXvtNHeFTgfQ4kdA
wE6ILOFOrUMm7zFVUMmVO4yKohaWYxp2IaSGDv1w9Srog4juECHkp+3Vgdjs1XAq
pB/EwhYbE0F4VMJv4Y1EURYqnqV+TrAmcsMo6ndwSauhE1Cum+NUAfvySibyoceB
yakrxcQnJU3NSBFRWAEzWc5tnTOnjk2BXs2tBYSF2tNh4Zgx/7Y=
=CPJ5
-----END PGP SIGNATURE-----

--d4fgqqllg7ccxuer--
