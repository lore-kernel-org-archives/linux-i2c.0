From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] drivers/i2c: SPDX-License-header information
Date: Thu, 21 Jun 2018 15:31:51 +0200
Message-ID: <e81dac58-6807-c2d0-ebdc-2f5965f22560@axentia.se>
References: <20180621123652.GA8426@sesnaco>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621123652.GA8426@sesnaco>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-06-21 14:36, Mawanda Henry wrote:
> SPDX License header included to easy developers and machine to know the
> license governing a particular file
> 
> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

It is customary to make note of the patch revision in the subject. In your
case that would be [PATCH v3] for this patch and [PATCH v4] for the next
iteration. Speaking of the subject, a better subject for this message
would have been

Subject: [PATCH v3] i2c: slave: use SPDX license information

Also, when doing multiple revisions of a patch it is valuable to record
the history of changes, so that reviewers get a reminder of what has
happened. For a single patch, this space here, just before the first
"diff" line is a good spot for that patch history. For a trivial patch
like this, this is not super-important, but still best practice.

> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 4a78c65..d2cc8fc 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,12 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+

Apparently, GPL-2.0+ is a thing of the past. Should be GPL-2.0-or-later
according to https://spdx.org/licenses/

>  /*
>   * Linux I2C core slave support code
> - *

I said "line", not "lines". The above line should be left as-is.

Cheers,
Peter

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
