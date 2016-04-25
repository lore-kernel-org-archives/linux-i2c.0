From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 02/15] i2c: octeon: Use i2c recovery framework
Date: Mon, 25 Apr 2016 23:29:13 +0200
Message-ID: <20160425212913.GC1550@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-3-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47078 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933361AbcDYV3T (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 17:29:19 -0400
Content-Disposition: inline
In-Reply-To: <1461594824-7215-3-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 04:33:31PM +0200, Jan Glauber wrote:
> Switch to the i2c bus recovery framework using generic SCL recovery.
> If this fails try to reset the hardware. The recovery is triggered
> during START on timeout of the interrupt or failure to reach
> the START / repeated-START condition.
>=20
> The START function is moved to xfer and while at it remove the
> xfer debug message (i2c core already provides a debug message
> for this).
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!

Fixed this checkpatch warning:

CHECK: Please don't use multiple blank lines
#32: FILE: drivers/i2c/busses/i2c-octeon.c:157:

> +	return (ret) ? ret : -EAGAIN;

I'd write 'return ret ?: -EAGAIN' but this is a 'mileage varies' thing.


--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHowpAAoJEBQN5MwUoCm2ei4P/0VoFGgeoovE+/uYi9TxZxuv
XwzjN1Mf+hk/16HlA0MMpmBmV2OXOQHIqjzPTq08Y5ORR+9dr8+rXsBBfA/uIn6A
RtuUKEHEaxPQe+aDPjJ+qiRWMImyDw2RB/mDIbFTuc2YqDpoMd/PdtN7UBKvPWtC
U0COobsDc9rxIgxb1T6WFj6D1ch+1XDY4V4n6dxNMTkH6nJ7FO3kQrBf/JQdavqT
OuKyUWIvhteMsZAPa++i3yD+029i1sKceucIhaJY1oxYurjG0hIKeTDDNTp6ZQrC
Z0/jf4R3hhbrifQtoyfGtTuLqk1sUh8vFHJ5+Y35Q2mdc+k9oo7Jh81x80+vD274
CvARw1z/FHF6dS7pCgN5jLA6n5nV397pUFzyOQcbD3EJu+8hGndFI6xMSiO6AxUq
hJb62fVPt6CO9mGEAMkC9zApZHdEulmcHOBod/7MsKnV7JVp7XPUDiyB7K3L5jaZ
GOD7B9BUvpumwPnfHisB20Pt04Ur7JQJF/ygsVWbXRCtwjozGiGPkq40fM5Fm5f+
4gdGeEUb4AZFHl/kny2K4dY+ETgc9WYrvauVcyveGZSWJm3G+S9FAPDL5ZzX8gkc
KulLvSkjY0QHa6+cuf9KjEYcCfAgb3frpC15leMSuQkeBfGwTBSH3CLitF56VvUv
hLlRcQRxgm0vgLeonB83
=LyU0
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
