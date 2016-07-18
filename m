From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: tweak the loop_until_timeout() macro
Date: Mon, 18 Jul 2016 20:11:34 +0200
Message-ID: <20160718181134.GA1973@katana>
References: <1468780806-13034-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54296 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbcGRSLm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Jul 2016 14:11:42 -0400
Content-Disposition: inline
In-Reply-To: <1468780806-13034-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 17, 2016 at 08:40:06PM +0200, Bartosz Golaszewski wrote:
> loop_until_timeout() replaced a do {} while loop in the at24 driver
> with a for loop which, under certain circumstances (such as heavy load
> or low value of the write_timeout argument), can lead to the code in
> the loop never being executed.
>=20
> Make sure that at least one iteration of the code enclosed within
> loop_until_timeout() is always executed.
>=20
> Suggested-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to for-next, thanks!


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjRvWAAoJEBQN5MwUoCm2uuUP/j5B5CLa1UTsvmpaNBrAgOS3
dF30EghlIAPY0aZxkVEe+O8RPAwdXIvEymiO5MsRXluC2JtL7WRB+D0blnq06jxR
0kr4znnzyIVguct9epOyK5jcoPUMXfBW1jMW6IPW1SB+ZLYGvEbabaVy8dipnOuW
2bS56wJegyvizfhc/BGeE2Eshijns1OT6m/e02QmFo+dC+cj5Urk/o8RSu8pqsU5
9VlAwrgf1Y1ZEWC/aRAYb+HXJ5IU+KxehdX0uk/m52fMrl1ddDIKPhx7TSPQcbEX
+XGwyNCeqF8gH+mqLSTz2CzzoXaHmCoVUkoDCMBiBpNY1ZstrTI4+fCFJXOX5uqZ
C7fsCWncWfyA/VwtN/8y+SvGREzrqUJN/R28hy91vJJAq91UC/MPd+vgqC4GO2NX
3C/UmuLIK3/hkxEfttc3k1w+zm9DJpqsmumBntM4/qOwYfivQeHWqRNXYBzcuQK1
IPjg1bWMrt57UQ4TqoQs6175icPSdaQJ56dzo6yYh4V7c4eCp03bLrzT0F65BZP/
x4Wjoj6u0Ft9x/ISGGwRNN8aGNtSs6Ls3z0EXKy9j+UfIMU5o8GvwQ8/Qvafhlzg
kusmQG3pFArNHaLRzgXW/dJTsjdmHtm27YlWkFibKSpr+aPzFSOgDX8nQNzYgMNC
AkaHlLCCPEBtxlTrcOAK
=BrRb
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
