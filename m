From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Tue, 1 Dec 2015 01:35:54 +0100
Message-ID: <20151201003553.GB1517@katana>
References: <20151029112913.1036f00b@voldemort.scrye.com>
 <20151029183032.GA8992@katana>
 <56332316.90506@linux.intel.com>
 <20151030100442.50ac07bd@voldemort.scrye.com>
 <20151102124728.52e82bed@voldemort.scrye.com>
 <20151103081840.GK1509@lahna.fi.intel.com>
 <20151104075143.44053d44@sheelba.scrye.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45869 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbbLAAgA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 19:36:00 -0500
Content-Disposition: inline
In-Reply-To: <20151104075143.44053d44@sheelba.scrye.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2015 at 07:51:43AM -0700, Kevin Fenzi wrote:
> On Tue, 3 Nov 2015 10:18:40 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
>=20
> > On Mon, Nov 02, 2015 at 12:47:28PM -0700, Kevin Fenzi wrote:
> > > Any other ideas or things to try?=20
> > >=20
> > > It would be nice to have a working touchpad. ;) =20
> >=20
> > Please attach acpidump of that machine to the bug (or send it directly
> > to me) and provide full dmesg with i2c_hid.debug=3D1.
>=20
> Just to circle back here, I exchanged some emails with Mika and this
> one liner gets it working...
>=20
> Hopefully something can be made upstreamable from this. Thanks much.=20

I didn't find any patch coming out of this? Mika, did I miss something?

>=20
> kevin
> --
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 3dd2de3..31ea736 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -90,6 +90,11 @@ static int dw_i2c_acpi_configure(struct platform_devic=
e *pdev)
>         dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt, NU=
LL);
>         dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
>                            &dev->sda_hold_time);
>=20
> +       dev->sda_hold_time =3D 30;
> =20
>         /*
>          * Provide a way for Designware I2C host controllers that are not



--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXOtpAAoJEBQN5MwUoCm2DAMP/AycMKp+MIbAH1GcDtu14XyJ
+Si20zLr7FEIigun8P6nx62RWQHpO4aQ+G55fLGpyAZLHKgP+0MSbJTml3YUrF2w
WvdzLEWvxEBGQAexDMYY1tziTXJUDXnATySN7LaUVNqu1EwJrofiD+1O1di+BRIY
+L5b0QudySon37IY4WMVsSj8LBVCFgtHIu9+Xz4WHEPvgvjhXM8SUk9wzfkNFKr1
iclg0MMzG86bGXNorXhyEAtufwMKjqSWRIm1zDm46TCaqFC2wTnOlfhL81OObpbN
b8Kt6SD87lrh3NJIP/IZkS6n+LM0Wg+Wy45tYA2tKoj/19CKL7yh8WTadGtUu2QK
UikhkTGPrjDQ2N+0+zsFukDEfU7o2SdEl7dnV11UpJVrOnvCDsmlwuJgqn4iyTx7
sXm/2S8cWecNFVghI1rNYMtayA4N6IEio4joJA8lZzShCQo2BLXaLulhyNUuHleN
3V0e1KPuIBBtniBXdpKwdnXv5lbjhYL7iMg9EWGioJweWeWOki0xZyFT9/y+uD0N
qp+1D3pJNQAv45XON9e4JOzyGtW7jmpz4//4Tr36L+jGUFCuHLQlIJO283n9f/rg
/6f42d4yvKby+jY7BhP2GOWzrw0yB4Y3eEOmSlz2P3j6bnWzKjQo1WJ7/6PxOyGg
tIIlf6THGag0U+xPd8Ks
=NKeL
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
