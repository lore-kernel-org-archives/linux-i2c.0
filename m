From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] drivers/i2c: include SPDX-license header
Date: Thu, 21 Jun 2018 12:09:34 +0200
Message-ID: <6243f83a-017c-11d4-2efa-f2124fcb8ed6@axentia.se>
References: <20180621100255.GA5564@sesnaco>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621100255.GA5564@sesnaco>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-06-21 12:02, Mawanda Henry wrote:
> SPDX license headers makes it easy for developers and machines to know
> the license that is governing that file

This patch appears to be on top of the previously rejected patch. Please
remove that broken patch first so that this patch applies to a clean
tree.

> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 883ca836..fd6a405 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,13 +1,9 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Linux I2C core slave support code
>   *
>   * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
>   *

Also, the above empty "*" line should also be removed.

Cheers,
Peter

> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
>   */
>  
>  #include <dt-bindings/i2c/i2c.h>
> 
