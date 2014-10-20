From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] drivers/misc/eeprom/men_eeprod: Introduce MEN Board
 Information EEPROM driver
Date: Mon, 20 Oct 2014 10:24:22 +0200
Message-ID: <20141020082421.GB1413@katana>
References: <cover.1413416105.git.andreas.werner@men.de>
 <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner@men.de>
 <20141016085835.GA1273@katana>
 <20141016102126.GB23256@awelinux>
 <20141016095910.GC1273@katana>
 <20141016114401.GA22506@awelinux>
 <20141020081822.GA1413@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141020081822.GA1413@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Werner <andreas.werner@men.de>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, johannes.thumshirn@men.de
List-Id: linux-i2c@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Here it gets frustrating. It seems you have no idea what an OS is for,
> not even after I tried to describe it :(

Sorry, that might have been too strong. Still, we can't map any hardware
which is out there 1:1 into userspace, we need abstraction.

If you want to help with this abstraction, this is more than
appreciated. If you want to keep your driver, this will have to stay
out-of-tree, I'm afraid.

Regards,

   Wolfram


--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJURMa1AAoJEBQN5MwUoCm2sMwP/3ijvRY/1WZ9LSLQ0ncC3MUw
//e/bLnFYf5bI+feV2CMFeHRvPiwgM2dRwn80gdQmhEbuqMd0wXy/igbskeSQXOT
Vl7iU7Yw/56xxlrc/E5yE3doVUX5N5tdWKMBA2cAjM0M4UQEllBN326OtRj1k1Wu
X5GzyFhvYqWqLWV0/Zio7hTOY+UquhojKDwL1K06DFJeUnAf+raKSaP/x8gm3pwT
aCgGKNUvUa6/P1bii7CSEUvkqtOPngeMPHadzRfrfSxKRi6mcO9Ka7w2cNlItEfE
Z/SEhLl//qORlH1JFkzj2Ygw8lMcVBZ5bIw+K78aUtksHdS19erz4Mey86TJ+f16
vqWJ2/niyChvlWDyn9G93o6UY0xv6pENF0hIo83naroY1t5Fp0i8E6JffYuOi+Oe
0HgbJIbpkfoi/acqdFXv37Tz982bNUvmh1bX9l91BPeIpr5MtX/bg9N1ZaSW/Vy6
wEX9xqj2SvoZkRcP8fM3o0FiqTcpi14jgVvKum4C2K9ck2hZKO13RP7XHKn4YRNS
BOnWfXUumjC2Pk8YykLlSXSR/D5OKEY3nyM4uLPZhCQfbVuq05SpFqhP0Qhz/qsh
b0FSLNKi2eE/B6aU3auqO4c9JqlaHqMUGgF+qVR/pQkQwz+DBO3ZIwlklCGhuM+3
ORe9/iz+Sm8S3UobcRNR
=PzeD
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
