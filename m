From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/7] i2c: Relax mandatory I2C ID table passing
Date: Thu, 17 Jul 2014 11:23:42 +0100
Message-ID: <20140717102342.GD30888@lee--X1>
References: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403265753-25851-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Are you going to take a lot at this set?

> As previously discussed I believe it should be okay for an I2C device
> driver _not_ supply an I2C ID table to match to.  The I2C subsystem
> should be able to match via other means, such as via OF tables.  The
> blocking factor during our previous conversation was to keep
> registering via sysfs up and running.  This set does that.
>=20
> After thinking more deeply about the problem, it occurred to me that
> any I2C device driver which uses the sysfs method and issues an
> of_match_device() would also fail their probe().  Bolted on to this
> set is a new, more generic way for these devices to match against
> either of the I2C/OF tables.
>=20
> I hope this ticks all of your boxes.
>=20
> v3:
>   - Insist on passing 'struct i2c_client' instead of 'struct device'
>   - Remove hook from of_match_device()
>=20
> v2:
>   - Removal of ACPI support (this is really an OF issue).
>   - Add a new .probe2( with will seamlessly replace
>   - Supply a warning on devices matching via OF without a suitable co=
mpatible
>   - Remove unified match_device() - bad idea as it subverts type-safe=
 behaviour
>   - Provide examples of the kind of clean-up possible after this set.
>     - I already have the full support from the maintainer of these dr=
ivers =3D;-)
>=20
> Kind regards,
> Lee
>=20
>  arch/arm/configs/multi_v7_defconfig |  1 +
>  drivers/i2c/i2c-core.c              | 72 +++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++---------
>  drivers/mfd/88pm860x-core.c         |  5 ++---
>  drivers/mfd/as3722.c                | 12 ++----------
>  include/linux/i2c.h                 | 22 +++++++++++++++++++++-
>  5 files changed, 89 insertions(+), 23 deletions(-)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
