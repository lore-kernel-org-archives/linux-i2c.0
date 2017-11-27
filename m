From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] dt-bindings: i2c: eeprom: Add Renesas R1EX24128
Date: Mon, 27 Nov 2017 19:05:28 +0100
Message-ID: <20171127180528.rg5imhfthbso477s@ninjato>
References: <1510839994-12473-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtjpyzk5q4hbyh24"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47882 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbdK0SFa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 13:05:30 -0500
Content-Disposition: inline
In-Reply-To: <1510839994-12473-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--vtjpyzk5q4hbyh24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bartosz,

>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 +-

I just noticed this file is missing in the AT24 entry in MAINTAINERS. I
wanted to prepare a patch for that but then I was wondering if the name
"eeprom.txt" is really suitable? I have doubts. Would "at24.txt" be a
better name maybe? Rob?

Kind regards,

   Wolfram


--vtjpyzk5q4hbyh24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocU+gACgkQFA3kzBSg
KbaUFQ/8Dctrm53qMYcofekgJNuenK4WnuuWwkIgVRpxQupH5nKCMEoiS/Nx74XR
enH+0Lz+cJCDLLQiGj2X9wvnave6oM/mNRTz10id5eHXRIfsb9XvZGeIRrJjgP71
JsP46DhsdU54h6VN0E3oVjwsZrR2MCdLoxIUTnu6xqogKbD9DbXOSiXMdD5QEjjB
hb8E1SfTnurZFO7M6Cdg+MAFlmSD1AxiyNX4jdyB91CeQvMhnXspJrTUtBjOHyOw
6PXe89VlfUCLY+Ju5fE+cWyvOvlltz+PkmkDsfTO/GoIq55iOsUfpMUB2+Wgk3E4
vJCvm7Wx1tZwr45ZhfRPF37WzfFV+kHcxT8wy4utCTAhIRESNgfxvjPyLziwCpbG
x46a9OrfbhC2BWzluJcHjIkGdTErM1MKRUYQZXThlg91dJdEfcGKIfJ1X21eYVNP
r1LCcTvi7PAzvlTjVL3rS0KuEGVKftU9LGLqLooZ7dR5FWSTnjEeVzhigQ3N3Ve/
TFf0YM8QorNEOBpuM43GOalyoCSoZOfWo4++zMqlLMY56d5yRI+2p3+2LIRX05AZ
cdlp7Ij+wS+FPHeUQ1MDh+IaNLQlT+0ck73s/eHGNbcNLDmaFReUNGARX2VWibcv
TA0yXDBcZLKYxBSz/89PJ748SbNqjiLuvkY/N6ueXIszDLJgEUk=
=1y0k
-----END PGP SIGNATURE-----

--vtjpyzk5q4hbyh24--
