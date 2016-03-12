From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv3 2/2] i2c: cadence: Implement save restore
Date: Sat, 12 Mar 2016 16:02:36 +0100
Message-ID: <20160312150236.GA1661@katana>
References: <1456984240-17389-1-git-send-email-shubhraj@xilinx.com>
 <1456984240-17389-2-git-send-email-shubhraj@xilinx.com>
 <20160303204013.GC1711@katana>
 <CAKfKVtG5sC7+2Gsq60irZAYgof1guqWTg=YCN+63xJV=tfmowg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50217 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbcCLPCq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Mar 2016 10:02:46 -0500
Content-Disposition: inline
In-Reply-To: <CAKfKVtG5sC7+2Gsq60irZAYgof1guqWTg=YCN+63xJV=tfmowg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org, anirudh@xilinx.com, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Shubhrajyoti Datta <shubhraj@xilinx.com>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> zynq-mp has the capability of going off.
> >> the current kernel does not hit off however some day it will.
> >> since the overhead of having the support is not much may be it is bett=
er to have it in the kernel.
> >
> > This sounds like the patch is not tested?
> to simulate the suspend behavior I  did a reset of the module by writing =
to
> slcr register.
> And then did a transfer.

I'd prefer a patch which is tested under the actual condition. So, let's
wait until proper suspend support is added.

> >> +static void cdns_i2c_init(struct cdns_i2c *id)
> >> +{
> >> +     cdns_i2c_writereg(id->ctrl_reg, CDNS_I2C_CR_OFFSET);
> >> +     /*
> >> +      * Cadence I2C controller has a bug wherein it generates
> >> +      * invalid read transaction after HW timeout in master receiver =
mode.
> >> +      * HW timeout is not used by this driver and the interrupt is di=
sabled.
> >> +      * But the feature itself cannot be disabled. Hence maximum value
> >> +      * is written to this register to reduce the chances of error.
> >> +      */
> >> +     cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET=
);
> >> +}
> >
> > This...
>=20
> Writes the values to the register.
>=20
> >
> >> +
> >> +/**
> >>   * cdns_i2c_runtime_resume - Runtime resume
> >>   * @dev:     Address of the platform_device structure
> >>   *
> >> @@ -853,6 +874,7 @@ static int __maybe_unused cdns_i2c_runtime_resume(=
struct device *dev)
> >>               dev_err(dev, "Cannot enable clock.\n");
> >>               return ret;
> >>       }
> >> +     cdns_i2c_init(xi2c);
> >
> > and this...
> At resume .
> (Actually this could be conditional however since we have 2 registers
> so can be unconditioal)
> >
> >> -
> >> -     /*
> >> -      * Cadence I2C controller has a bug wherein it generates
> >> -      * invalid read transaction after HW timeout in master receiver =
mode.
> >> -      * HW timeout is not used by this driver and the interrupt is di=
sabled.
> >> -      * But the feature itself cannot be disabled. Hence maximum value
> >> -      * is written to this register to reduce the chances of error.
> >> -      */
> >> -     cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET=
);
> >> +     cdns_i2c_init(id);
>=20
> And at init.

I understand what it does, but I don't see any connection to the
caching mentioned in the subject. So, this is maybe a seperate patch or
the commit message must be updated.


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5C+MAAoJEBQN5MwUoCm2XS8P/2pJfUoFSpX77GxiWgj4qQ/8
Lm+kd3+Ancqpn29pS70rw/rCAMbO/9jJnAp2uQDkExXYtFlUZh1JhFjDomDS9D1S
KRIGlUVxzj6Ab+ZZzF12eEThq4lyCZ4nPCRoqxxPrl6f3+wyiKZBKzRYh0KuuC2U
+4ChJD8wsCQtmeRov4VCfvRFfi2C8jdTj6L0Can1la8C/4nOXuJ/Ia1DYt6/DaNP
gXSWBUlk/vtD/mtPGNbqz6sZr2SZhkvS5RyDL5SI+tbRFjTv17Ej0qtJayLZDOV0
EPxRoK12Virxy8X82bFjO18lLITJYoWrNiS1lzoCAYG40U7MYAsJVAR/gfOwIVXe
EPEMH5x47Bn7sOF4HlhgBsnUDZysinGmfj/cl5tDpr7ePuugKw2PWCzOhrc8MXKs
uiUjmYz2jqOp9r8iEGqf+6eW990/HzNnKquGHabQjbD3LgC6khntlA8SWdx06YkV
8eEX6nQI3OmCGvf0fPxjNhVa3vssSvUUdW+PntG7eL+WocoPW4TtLhJgs4h3BJKK
ZZM7n+ov+IeMGlenauwxss0vcT9Vlc1/f9aYPXsjnh8sWL1Y5ULryhcQ4mrtQ6RE
ekmI+81jwHe4FRWO3PEC2VZE0Aj8BrQaL29pbPyJVy4ZemN6VkDtqHenmsO/awJf
pyddc9AzHyeY2xlFpgly
=x9k7
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
