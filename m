From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL
 boiler-plate
Date: Mon, 19 Mar 2018 12:03:14 +0100
Message-ID: <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
References: <20180319091721.18193-1-brgl@bgdev.pl>
 <20180319091721.18193-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-5-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-19 10:17, Bartosz Golaszewski wrote:
> Replace the GPL header with an SPDX identifier for GPL-2.0.

Great care should be exercised when dealing with copyrights of others.

> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2a4154eeb1bd..0e06201d33c9 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -1,14 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This should be 2.0+

Also, use a // style comment for the SPDX line in C files.

Cheers,
Peter

>  /*
>   * at24.c - handle most I2C EEPROMs
>   *
>   * Copyright (C) 2005-2007 David Brownell
>   * Copyright (C) 2008 Wolfram Sang, Pengutronix
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>   */
> +
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> 
