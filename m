From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Thu, 9 Jun 2016 21:15:13 +0200
Message-ID: <20160609191513.GB23522@katana>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, javier@osg.samsung.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kieran,

> * Device Tree
>   I tested that the device would still register by adding a node in the d=
evice
>   tree for the board, and testing with a built-in module.=20
>=20
>  - This worked fine.
>=20
> * Module Autoloading
>   With the device tree node in the board dts file, it wouldn't automatica=
lly
>   load from the external module. This was due to the rtc-ds1307 module not
>   exporting an of_match table, and not yet having Javier's "report OF sty=
le
>   modalias when probing using DT" [0]  patch applied

What I didn't get here: did your version of the RTC driver use probe()
or probe_new() without i2c_device_id table or did you try both? I assume
module autoloading only fails with probe_new(), otherwise we would be in
serious trouble. But I'd wonder then that userspace instantiation works.

Thanks to you and Javier for the testing. I pushed the patches to a
local branch for now and will merge once this question is clear.

Regards,

   Wolfram


--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWcBBAAoJEBQN5MwUoCm2p9IQAJSevt16MHaqeAuyyaLYngcw
hR/X1rF2ozbLjJsVwf2d7LjSpJqhHjUmJR8c7bgd/X3NGvCeKjXrB3FkYW6MtvRS
cpM9ztX/1YgN/564EoSf/NutUy/DgMnI2dO+tUnkr3JcJtj2cupsLN6Q3U7TFGB3
CkRQmItCtJayTmrEH+5b28SpVMhxtvVVSVzYDBn+daGtNfGiVdyKR0LOQCFxiysj
ksFdZ/cJ7WVfUT0xXPA/s3LHf2DFl4+XjHTRBhRJQF/a5JhjxiwQ4irdBcyo32Ii
PTgfczDHJ59wEWWS0WUlAUlF0TzT+YOEVWi6ROcG698nOPWv/V68s6ygVrFDk70U
wa6q8700WC4pjKH34JA3d0U8pxWS8bTNU2BK6DQmX3nQyGcRNVj7eZNQfpdmg5tY
REsReDEcdrEqIOBzi1qVpP1iG7xEPDgukgIvUSu56Nc9oUcUUUV3fs+Hi/6aJ7YU
wDbI0X1NbqWmIsQNy3FspNCL6R/Vh2n1qkXVwVzBj8gvZfWjZlzovLmrXZGrK/k2
6XtFzIPZa6zHu0VzNUKjGRqoVtE6sd/mXxhE0nr3E/l6GTpf8zGKED5azWZb1vGV
Qz4GEKVwxb/xrpWIMH9rMGnHFr1snL1Uc4eJXQOq0NqPX9PPCyFfLcykSxJh+upx
8OKp4AJnxWUaYEg5no+E
=uxXD
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
