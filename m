From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Thu, 15 Aug 2019 14:52:52 +0200
Message-ID: <20190815125252.GC1916@kunai>
References: <20190812235237.21797-1-max@enpas.org>
 <20190814194714.GB9756@kunai>
 <f33ef44e-61e8-0392-7f5c-5a0bd7b42fff@enpas.org>
 <20190815071228.GA1054@kunai>
 <276714fb-6b3a-1e99-0744-bfd037305724@enpas.org>
 <20190815114809.GA1916@kunai>
 <54185c85-8c26-916e-41b1-af9b55223e7b@enpas.org>
 <20190815120430.GB1916@kunai>
 <4661d2f3-13e1-ff62-22e1-e4391ccc38b2@enpas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4661d2f3-13e1-ff62-22e1-e4391ccc38b2@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The callback, just like getclock(), is from the existing i2c-algo-pcf,
> which I don't want to touch right now. So I'm afraid it has to stay,
> even if it returns a fixed number.

Sure. I was just thinking loud and did not expect you to do it. Maybe I
will do it once your driver is upstream.

> Touching or forking i2c-algo-pcf will be necessary in order to
> implement IRQ support, if I ever get around to it. I've wasted too
> much time on debugging IRQ support, and would rather do it another
> time, if ever ;) I've left a comment block at the start of i2c-icy.c
> for anyone interested in the gory details.

Yeah, I read it. I like such documentation. Really helpful!

> If this is okay with you, I'll send another round of patches. :)

Perfect!


--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1VVaAACgkQFA3kzBSg
KbbhYxAApqbkKmM/SfvqaGNqdQxFvjTFrV3E08Ct31M28y210CPVO5YMz4tkj+hq
OEi7NDuA7+XTlgNAeuJJb3UQYOlkEUwR8x/6oZMWj4Nh379Bmk3TmlkMqHRwIwJ3
OqItq+oIN3MAcICCf4D/66/WUFoZIzZAprXASzbtdfGQma4Wue3lXxGPvhndYqzR
HpO4yhOTRs87PJrHUavD07BV1+bk+VIKBG/NkehpG1BmiIsd+5XrzQtbuMNVaKBN
mnpL6uwRROG6nz8NamnHUu+KPKquwakTTW1Nx7KeZs6Th7ySAyCOlhFcbx7x0AbK
h8oSwpmrSukBc1pKc+ZDvoqZNppE0ixVBF3AdgZP5Msgrm15xfa0EEXM7/s8o/EE
iasali4Zj1S34JX0MFBYXmeRUTxWOVtT/2dDVhNYrPzt5GpXsuG32NyQo+PkTAv6
LwvbOQ1JVU49rqsyYinniA6zGZeSNeJw7z2TRKb7zR9FGZUa+NSmNQs8IciSsnrv
H9VOPDviPuTEGQjLdOMzNDPPQ5ZizPkQvRNiYwNCGqgXAFSU++RDwksEsAnUsRVz
VPnmIjxE4IC73MzyM/76ILtRBVyvu/+AjGoygjifpNP36a5bhOXysRxwbLZGt1ww
+AGF+JAJznrW6JUIRgoaUo+vaxFwW8oFjJff/zezVXOX2+o4UoY=
=0mSM
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
