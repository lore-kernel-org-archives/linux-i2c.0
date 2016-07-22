From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at
 boot.
Date: Fri, 22 Jul 2016 09:27:40 +0200
Message-ID: <20160722072740.GG1605@katana>
References: <1464818845-5348-1-git-send-email-eric@anholt.net>
 <20160704003118.GA1381@tetsubishi>
 <87lh1ip653.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50931 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562AbcGVH1u (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 03:27:50 -0400
Content-Disposition: inline
In-Reply-To: <87lh1ip653.fsf@eliezer.anholt.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-i2c@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 03, 2016 at 06:02:32PM -0700, Eric Anholt wrote:
> Wolfram Sang <wsa@the-dreams.de> writes:
>=20
> >> +	/*
> >> +	 * SMBUS says "Devices participating in a transfer will
> >> +	 * timeout when any clock low exceeds the value of
> >> +	 * T_TIMEOUT,MIN of 25 ms."
> >> +	 */
> >
> > SMBus has that timeout, but I2C doesn't. How about disabling the timeout
> > simply? Or using the max value if you want to keep the timeout
> > detection?
>=20
> Disabling the timeout seems fine to me.  We still have a 1-second
> timeout around the entire transfer.  I'll be back on my DSI branch this
> week and test it out then.

Did it work?


--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkcrsAAoJEBQN5MwUoCm2mfwP/09pY6MGNmTeOJbwGJfwCDUE
wT+6wD6zChNU+MwfeZ4FuJYvhdYlhuBgfsFH/26L/Yz05l+G8VDNI+gr/E2kERce
XwBAPtlhs5NVlC/RIfU2Ux+oca8NZJ8GBoIALR9Fbv/lRnC2d9hfbbt2ytFDWGN2
7TEsSOvxmh1i+4RVSB/0sLwoqRziWwqLtCh/JYPUbhylWLyiiX+LoXVLVf512EfF
Qley+9olGj68gv7wy05/ZIdjSeNfTvozIxMQ+Drcd0NRgSVhwbRquARUU2IGKNWr
LcPOETG79+QjuMCjyprlDf8ibA8Pr6I5TNdfEoEXQEZHmg8134WeAAzUsgcSAXKf
mKmhrq2VsSVt8yN3RjAHbPhfU3l+ZEsrpGrrnrZvqQ1vibVn9o+Fv0quTbHdbBsU
vynGRyHiYcDWqGPn78VJEpG5JaovKF1r3b+oZG35duco2xZo3Gzb/dAPwVORUi+b
VsdkmVuwQLUAvY4wgXglQwdDD7XndgDI8iWxlhIskBIv86v60aAtwjtcfRS7rMBJ
G9vlWJQQ7qGYMBYPkUe5FzXmBxwMHarmNW98xTTso5TaO3sILvg9FizfIVNDVH3c
zrS0zE8tQvakCC0UJMz8iKcn/IoKuqWWTFgXwYsBkxosfla2Z6HJUf30ZDxeVGm+
DcyqLir4CYo4zdt95LqZ
=KP4i
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
