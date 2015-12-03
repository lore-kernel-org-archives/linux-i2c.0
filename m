From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/4] ARM: at91/dt: sama5d4: update i2c compatible
 string
Date: Thu, 3 Dec 2015 21:45:32 +0100
Message-ID: <20151203204532.GB8509@katana>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
 <1449136434-27619-5-git-send-email-ludovic.desroches@atmel.com>
 <56601A74.3040507@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36011 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbbLCUpj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Dec 2015 15:45:39 -0500
Content-Disposition: inline
In-Reply-To: <56601A74.3040507@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, alexandre.belloni@free-electrons.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2015 at 11:33:24AM +0100, Nicolas Ferre wrote:
> Le 03/12/2015 10:53, Ludovic Desroches a =C3=A9crit :
> > A new compatible string has been introduced: atmel,sama5d4-i2c. It
> > allows to use the i2c-sda-hold-time-ns property if needed.
> >=20
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>=20
> Wolfram, we'll take this one with us in the at91 branches that will go
> into arm-soc. It'll be queued in at91-4.5-dt branch soon.
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I squashed patch 1+2 now and applied them to for-next, thanks!


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYKnsAAoJEBQN5MwUoCm2hY8P/AnNOkbYa0c15rrENCh5lI+g
B6QqmGT/N0VGfYk68u6RqafygOHwhMy2fwEkH/UhlYXpkOshsnVWdvO+pWf5thIX
viWI34a5e6vO4ES85sHuAVu1S9RFYtjZuCGfC+oH1fd9uD1YR/nGsB8T4LWg02mk
NbUMtmRUeq/72qowmM0uVKRUEU6C/UyQKD/zaJ93wrxYchxAOVpJ3u+3E5m16rxa
f6bi7MvP+WZjArGUcz2q6iRK7zBUnEOE8kmP6nseD6txC67Gu48eawHQ7voIT6/w
fut6LpwCigoZc3HGA/vbTiZEBtHlgEJAxA1kfWBoT8Qh7l1I8KLpbkNf9/DFY8EO
7ahivSYZ4GbML1XzyzXggy1AcXLcuJWoAdtVZA8hRhiRVNzbzlxT5MnLbPQiUNo2
UlqkZeq0Tdr3mcDZbE8pec5YihwL60ItOygGADxUDjhf5xJC0Mr6MDlSuLrl2mfL
Kb9ivfeqsQ3XPTDe2hezA2q/F9BTxuNuWt9bjVAzMCjR5F4eawxvChO3eXY9V9u7
qotkal8xWu1F0DN0uvmnI4WfV4u4OR2Cc7KiZjW/jrRQQdtEaAmoG9B7Cupe/vJp
69rNwiTy3uHe6vtdOz4r8axRqspGW3QDpEOeb5vuH+ByuGIGrmaEk2t61l7QuEAw
+rPcklkEN/nlHVFpbatS
=JHI/
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
