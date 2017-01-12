From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH -next] i2c: mux: mlxcpld: remove unused including
 <linux/version.h>
Date: Thu, 12 Jan 2017 15:36:49 +0100
Message-ID: <a07d121b-824c-7db7-f585-0caa4a2c43c3@axentia.se>
References: <20170112142904.17582-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0100.outbound.protection.outlook.com ([104.47.2.100]:63024
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750720AbdALOg6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 09:36:58 -0500
In-Reply-To: <20170112142904.17582-1-weiyj.lk@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-i2c@vger.kernel.org

On 2017-01-12 15:29, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Remove including <linux/version.h> that don't need it.

s/don't need it/is not needed/

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> index b7ca249..e53f2ab 100644
> --- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> @@ -40,7 +40,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>

I don't see a reason to keep slab.h either?

Cheers,
peda

> -#include <linux/version.h>
>  #include <linux/i2c/mlxcpld.h>
>  
>  #define CPLD_MUX_MAX_NCHANS	8
> 
> 
> 
