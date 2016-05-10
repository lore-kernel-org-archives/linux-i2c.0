From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv5 8/8] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Tue, 10 May 2016 15:01:52 +0100
Message-ID: <20160510140152.GN19473@dell>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-9-git-send-email-kieran@bingham.xyz>
 <a34c73e5-afdb-5f2b-0775-4959cb09dbaa@osg.samsung.com>
 <20160510073346.GH19473@dell>
 <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Tue, 10 May 2016, Javier Martinez Canillas wrote:

> Hello Lee,
>=20
> On 05/10/2016 03:33 AM, Lee Jones wrote:
> > On Tue, 10 May 2016, Javier Martinez Canillas wrote:
>=20
> [snip]
>=20
> >>> =20
> >>> -static const struct i2c_device_id as3722_i2c_id[] =3D {
> >>> -	{ "as3722", 0 },
> >>> -	{},
> >>> -};
> >>> -MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
> >>> -
> >>
> >> Just a note that this can only be made because the driver's Kconfi=
g symbol
> >> is bool and not tristate. Since for drivers that can be built as a=
 module,
> >> the I2C core always reports a MODALIAS of the form "i2c:as3722" an=
d so the
> >> i2c_device_id array and the MODULE_DEVICE_TABLE() are needed even =
when not
> >> used by the driver.
> >>
> >> As mentioned the change is correct for this driver but I just want=
ed to
> >> point out in case other authors try to do the same change for driv=
ers that
> >> can be built as a module and so breaking module auto-loading.
> >=20
> > Sounds like a subsequent patch might be required to fix that use-ca=
se
> > too.  I'll add it to my TODO. :)
> >
>=20
> Well, the fix is really trivial and I've posted it as an RFC patch a =
[0] a
> long time ago. That is what Kieran and my used to test module autoloa=
d with
> this patch series.
>=20
> The problem is that a lot of I2C drivers are relying on how the subsy=
stem
> behave (always match using i2c_device_id table and report i2c: modali=
as)
> and so OF drivers don't have an of_device_id table since was not nece=
ssary.
>=20
> So if the RFC patch lands [0], that will break a lot of drivers since=
 after
> that, the I2C devices registered via OF will report a of: modalias bu=
t will
> not have a OF aliases in their modules.
>=20
> We need a flag day to change the I2C subsystem behaviour and that can=
 only
> happen after all the in-tree I2C drivers have proper exported of_devi=
ce_id.
>=20
> I posted a patch series almost a year ago [1] trying to fix the I2C d=
rivers
> that I could find using a script but then found that removing the I2C=
 table
> was not possible also due how the subsystem did the matching. Fortuna=
tely
> your patch series fixed this :)
>=20
> So after your series land, I plan to do the same investigation again =
and
> post patches to fix all the remaining I2C drivers so the modalias pat=
ch can
> finally land and the I2C subsystem report modalias like other subsyst=
ems do.

Sounds perfect.  Thanks for the explanation.

Wolfram,
 Things are looking up for the subsystem, please do your thing, so we
 can ensure awesomeness. :)

> [0]: https://patchwork.ozlabs.org/patch/502201/
> [1]: https://lkml.org/lkml/2015/7/30/519

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
