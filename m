From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: spurious warning from of_i2c_register_device with
 fixed_regulator?
Date: Wed, 16 Mar 2016 12:20:16 +0100
Message-ID: <20160316112016.GC1542@katana>
References: <20160316110156.GC21259@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49379 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758AbcCPLUZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 16 Mar 2016 07:20:25 -0400
Content-Disposition: inline
In-Reply-To: <20160316110156.GC21259@amd>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, robh+dt@kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But we have fixed regulator there, it does not have "reg" property.

The fixed regulator doesn't even use I2C. So, you need to debug why it
calls I2C. Your information given is not enough for me.


--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6UFwAAoJEBQN5MwUoCm2kqUP/iaZIfZNcwXqPag5rwafkDdu
i/nLIeP1YPGj7bi9DFKnh/pdFa9yMXU9LN4oJ0JLWcoRTfbXGuheZJqVotkGeABk
NPVkuE/0x9Zuun5OHJoCUcCZXYr3AEyOIqLp4nAa4Iv2Ke/zuzZ4+TOQjwjsCC+/
WHrtEZkPaMdUHIVODU+gzlf0FwrZT6ORg8d3GVubjVQ1NvEGz2NCYL/9m6MtmCyT
kSnkCqmSBbHnp2hiy5MXBrGSTc4jKyJdMzQ7KXciP4xIy3wT0/0qZiVptZNplnSM
NFN8a4kJs026sjw6n/tjYt0s40o9GiJH0RbdgJA8/pMfHu0yl80CDBG54JfVsWnd
i3LByDhmKK+TnpbPxYAvBM42ryuaKSQYeW4iI7rFGlBd7ziCsakj+1i9Je5U2QhJ
aoiGnX1lteCcw/hKEOTDJsimMuY1jtmuBy7f443WJT8saZVMl3U0O4bj5trpo+mI
zzUCTUQC2w8eSEkkz9Ph2xM0fngiwcR7xCWE5g7TLCGRO3dvEiBiLqUtiSMNkY+Q
V94dAdsDs2Ach6BjUrGQSSaWfOGGjU3d7xTqu6FJ1KVtXF1tT6czyPsL1O0pZeLn
k/tjF8/hHzfR0G/h43NwsJ7QjQ/+omYWxhIki9/nnADEzJH1pLkcM202kjT4N14E
LYY5R73oS/7IpyYsPPNt
=qBzI
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
