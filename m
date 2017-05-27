From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 8/8] i2c: reformat core-base file header
Date: Sat, 27 May 2017 14:17:59 +0300
Message-ID: <CAHp75VdpJ54rXJY7QhtWeVBjdAr+Dg8JRO1Q1cqJbCML+hPuJQ@mail.gmail.com>
References: <20170526082101.4746-1-wsa@the-dreams.de> <20170526082101.4746-9-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-9-wsa@the-dreams.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 26, 2017 at 11:20 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Finally, apply modern comment rules to the file header. The old style
> looked very non-Linuxish and challenged my eyes for some time now.
>
> I took the liberty to a) drop the two credits for the multiplexing
> support here in this file because there is no significant code in the
> base file and the two guys are fully credited in the i2c-mux file and b)
> add my own copyright for the period of me being the maintainer.

FWIW: here is my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for entire series _except_ this change. I'm obviously not a legal or
author of that code, so, I can't speak for them.

>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/i2c-core-base.c | 40 +++++++++++++++++++--------------------=
-
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 78135c1deaab59..2f742ffac8754c 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1,21 +1,18 @@
> -/* i2c-core.c - a device driver for the iic-bus interface               =
    */
> -/* ---------------------------------------------------------------------=
---- */
> -/*   Copyright (C) 1995-99 Simon G. Vogl
> -
> -    This program is free software; you can redistribute it and/or modify
> -    it under the terms of the GNU General Public License as published by
> -    the Free Software Foundation; either version 2 of the License, or
> -    (at your option) any later version.
> -
> -    This program is distributed in the hope that it will be useful,
> -    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -    GNU General Public License for more details.                        =
    */
> -/* ---------------------------------------------------------------------=
---- */
> -
> -/* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki@cc.hut.fi>.
> -   Mux support by Rodolfo Giometti <giometti@enneenne.com> and
> -   Michael Lawnick <michael.lawnick.ext@nsn.com>
> +/*
> + * Linux I2C core
> + *
> + * Copyright (C) 1995-99 Simon G. Vogl
> + *   With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki@cc.hut.fi>
> + * Copyright (C) 2013-2017 Wolfram Sang <wsa@the-dreams.de>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the=
 Free
> + * Software Foundation; either version 2 of the License, or (at your opt=
ion)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
 FITNESS
> + * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more=
 details.
>   */
>
>  #define pr_fmt(fmt) "i2c-core: " fmt
> @@ -57,9 +54,10 @@
>  #define I2C_ADDR_7BITS_MAX     0x77
>  #define I2C_ADDR_7BITS_COUNT   (I2C_ADDR_7BITS_MAX + 1)
>
> -/* core_lock protects i2c_adapter_idr, and guarantees
> -   that device detection, deletion of detected devices, and attach_adapt=
er
> -   calls are serialized */
> +/*
> + * core_lock protects i2c_adapter_idr, and guarantees that device detect=
ion,
> + * deletion of detected devices, and attach_adapter calls are serialized
> + */
>  static DEFINE_MUTEX(core_lock);
>  static DEFINE_IDR(i2c_adapter_idr);
>
> --
> 2.11.0
>



--=20
With Best Regards,
Andy Shevchenko
