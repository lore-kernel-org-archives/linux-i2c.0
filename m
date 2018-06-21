From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v4] i2c: slave: Apply SPDX Lincense-Information
Date: Thu, 21 Jun 2018 20:23:55 +0200
Message-ID: <02958ae6-e6c7-5483-5797-c4de5515ed15@axentia.se>
References: <20180621160530.GA20061@sesnaco>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621160530.GA20061@sesnaco>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-06-21 18:05, Mawanda Henry wrote:
> SPDX license header eases work for developers and machines to know the
> license that is governing a particular file
> 
> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 4a78c65..6f56e65 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+

Why did you not change this to "GPL-2.0-or-later"?

Also, you now have a spelling error in the subject. Why did you not use
the subject exactly as I suggested?

I will not respond if there are further issues with this patch, this is
getting ridiculous...

Cheers,
Peter

>  /*
>   * Linux I2C core slave support code
>   *
>   * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
>   */
>  
>  #include <dt-bindings/i2c/i2c.h>
> 
