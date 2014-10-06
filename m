From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 0/3] i2c: designware: Add support for AMD I2C
 controller
Date: Mon, 6 Oct 2014 19:51:06 +0200
Message-ID: <20141006175106.GA2000@katana>
References: <1412071495-15323-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412071495-15323-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 01:04:52PM +0300, Mika Westerberg wrote:
> This is second iteration of the patch series. First version is here:
>=20
>  http://patchwork.ozlabs.org/patch/390694/
>  http://patchwork.ozlabs.org/patch/390695/
>=20
> In order to get source clock to the core driver we need some way of
> creating it in the first place. For Intel LPSS it is done in
> drivers/acpi/acpi_lpss.c but that is not applicable for AMD I2C host
> controller which is too different from private parts to the LPSS one.
>=20
> We solve this by creating the clock in ACPI parts of the platform driver
> when we detect the AMD I2C host controller. Doing this requires small
> refactoring to be done to the probe() which is what patches [1-2/3] are
> doing.
>=20
> Changes to the previous version:
>  * Rebased on top of i2c/for-next branch
>  * New patch defaulting ACPI probe to fast mode
>  * Instead of direct dependency to COMMON_CLK we depend on (ACPI &&
>    COMMON_CLK) || ACPI. (suggested by Wolfram)
>=20
> Carl, can you test that this still works on your machine?
>=20
> Carl Peng (1):
>   i2c: designware: Add support for AMD I2C controller
>=20
> Mika Westerberg (2):
>   i2c: designware: Default to fast mode in case of ACPI
>   i2c: designware: Rework probe() to get clock a bit later
>=20
>  drivers/i2c/busses/Kconfig                  |  1 +

Applied to for-next, thanks!


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMtaKAAoJEBQN5MwUoCm2LlcP/AuMRTiPqVGjPUQ/hYHYEe4k
YN4Nvya/t4ntR+o0VBEzWiaURKnVE1omqUbQEFUm8SJL9GTqpOoIF7bod/01GPiB
bMgMKgVp40Hdr8qedKuU/PRLAsOKz4xHKFNY2Pxa/VoobtKHCTK8nZrX4lpKa3c/
acGpA2c6p3urGAfG/UWJnZbtoShCspI2CpU/U8InCJmNwqzEEPYULwLeeBFR5c1n
1or8aj/s+XmDaC6aCgLhMXZ0da5h6qDgX7XtDEnjM5AIlehYhIv/0Ad4ccnUbcco
sZppOkiWdfe+HVkMoI72/UYkv/ORbu150m9e+AmJ5h+UTZonS6cteEwkYphhNbvA
KObS9mNNR5tOra1+xPQocYz9oGvpUOs+xttE4FuWlvjuP+pWmx0fxSyAhHfL3x1y
KV1ezYOf7wn/IYpJQ/k9bfO8MQQh7zbXk998V1Ae9eLq+5PHHdNBJ+kbs+41bTBP
1q0jZrJ7m/kLxtXM18axLpe0JxSuS395AgKLfrthWnnfzT6j2D1AnSG6CHCMEK7c
8eH5rZhuxBhWfl1xtZc7XduO42AcFn1jKW9Tj5q+Yo12XcJgJcYiersJGC4kr5p9
AC7P+dVksvjfuA/52RZxghm5tgCbIKiHUgipDho1vug1gowKcjs6bdUoeqNN//DT
8t4EpoqSh8FDzr9T2JfM
=B0to
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
