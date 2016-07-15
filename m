From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 11/14] eeprom: at24: add the at24cs series to the
 list of supported devices
Date: Fri, 15 Jul 2016 15:30:48 +0900
Message-ID: <20160715063047.GA7675@tetsubishi>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-12-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36949 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbcGOGbB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 02:31:01 -0400
Content-Disposition: inline
In-Reply-To: <1465202936-16832-12-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  	{ "24c01",	AT24_DEVICE_MAGIC(1024 / 8,	0) },
> +	{ "24cs01",	AT24_DEVICE_MAGIC(128 / 8,

I encoded the size for EEPROMs with "x / 8" originally to make it
visible where the EEPROM name came from, i.e. that is from kilobits not
kilobytes. So, for the serial number I would simply encode the size as
16 and not as (128 / 8), because it has nothing to do with the name. I
can fix this locally if you are okay with the idea?


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiIMXAAoJEBQN5MwUoCm2EqMP/RNarw9LC/2NvvqREzHSz8vZ
1uOQJ7Vk+XVC01SVeiAcCGjp7d/ZWm12yrk3C2lEkgNDXSKqgTYaNGq2VmUHBIAr
WAZVW02rpk1kpb3eFNSv8W8cm4QBD1wp6lYB/nUXY0BrE0cHiBacOpGqr9uA2R4G
1BG4EltDv3QCiqn84kuWF9kZJMqRHVlj2GeRfeW3gvQEA4Nr22pvhJINMFnmX7UO
TcrqOcXXPpX6tolNNWAa3bU1KirxmbPpcud7hNXn+9dLeEicdOwW7tYJsXtZIuz3
PXh8awkItr3emt++Hsxhg6Heu2hgUMaSctcLyappRwpUagIZJ3IichtPWkCaOrlm
bToq7XHiHAABr4kS1646fW+yCcX1+iU/p70O3/8qzWOYtcUloMnAQWD0v266lZI8
l0p+ONVlt3Hta1iDzLTgtfMJloGHxf0VAs6+sFUsNWIE5xoZtNjU3ofLm3WpCPSZ
e+zTOt329p1PRfpx5BMyLXLcgc0bJc7K+5Nc1SIGnZwOJFvlDDTbNZP7zJTa+hph
rALBYAEwa09aMMPTGfNEwrMis8CL2DBsLTFjaXWZyEDC2tSTNQ3j3pmq+Q0fxk2i
ZCvuFdaEH74hQt7g3v0+uBiqKd7eyBkqEI95TxKF4RwN8LmrIm0+GuBASU3Igwiv
lLohjNWVA7RI6nvYWOa6
=Gz2G
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
