From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv5 8/8] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Tue, 10 May 2016 08:33:46 +0100
Message-ID: <20160510073346.GH19473@dell>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-9-git-send-email-kieran@bingham.xyz>
 <a34c73e5-afdb-5f2b-0775-4959cb09dbaa@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36917 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbcEJHdh (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 10 May 2016 03:33:37 -0400
Received: by mail-wm0-f47.google.com with SMTP id a17so10884572wme.0
        for <linux-i2c@vger.kernel.org>; Tue, 10 May 2016 00:33:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a34c73e5-afdb-5f2b-0775-4959cb09dbaa@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

On Tue, 10 May 2016, Javier Martinez Canillas wrote:

> On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> > From: Lee Jones <lee.jones@linaro.org>
> >=20
> > Also remove unused second probe() parameter 'i2c_device_id'.
> >
> > Acked-by: Grant Likely <grant.likely@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> >=20
> > ---
> > Changes since v4
> >  - Rename .probe2 to probe_new
> > ---
> >  drivers/mfd/as3722.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> > index e1f597f97f86..28fc62af6861 100644
> > --- a/drivers/mfd/as3722.c
> > +++ b/drivers/mfd/as3722.c
> > @@ -354,8 +354,7 @@ static int as3722_i2c_of_probe(struct i2c_clien=
t *i2c,
> >  	return 0;
> >  }
> > =20
> > -static int as3722_i2c_probe(struct i2c_client *i2c,
> > -			const struct i2c_device_id *id)
> > +static int as3722_i2c_probe(struct i2c_client *i2c)
> >  {
> >  	struct as3722 *as3722;
> >  	unsigned long irq_flags;
> > @@ -453,12 +452,6 @@ static const struct of_device_id as3722_of_mat=
ch[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, as3722_of_match);
> > =20
> > -static const struct i2c_device_id as3722_i2c_id[] =3D {
> > -	{ "as3722", 0 },
> > -	{},
> > -};
> > -MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
> > -
>=20
> Just a note that this can only be made because the driver's Kconfig s=
ymbol
> is bool and not tristate. Since for drivers that can be built as a mo=
dule,
> the I2C core always reports a MODALIAS of the form "i2c:as3722" and s=
o the
> i2c_device_id array and the MODULE_DEVICE_TABLE() are needed even whe=
n not
> used by the driver.
>=20
> As mentioned the change is correct for this driver but I just wanted =
to
> point out in case other authors try to do the same change for drivers=
 that
> can be built as a module and so breaking module auto-loading.

Sounds like a subsequent patch might be required to fix that use-case
too.  I'll add it to my TODO. :)

> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> Best regards,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
