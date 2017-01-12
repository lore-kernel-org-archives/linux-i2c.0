From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [PATCH -next] i2c: mux: mlxcpld: remove unused including
 <linux/version.h>
Date: Thu, 12 Jan 2017 15:40:18 +0000
Message-ID: <AM5PR0501MB209796E88D6CD41B21BCE65DA2790@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <20170112142904.17582-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:44856
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751109AbdALPkW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 10:40:22 -0500
In-Reply-To: <20170112142904.17582-1-weiyj.lk@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Michael Shych <michaelsh@mellanox.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



> -----Original Message-----
> From: Wei Yongjun [mailto:weiyj.lk@gmail.com]
> Sent: Thursday, January 12, 2017 4:29 PM
> To: Vadim Pasternak <vadimp@mellanox.com>; Michael Shych
> <michaelsh@mellanox.com>; Wolfram Sang <wsa@the-dreams.de>; Peter
> Rosin <peda@axentia.se>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-i2c@vger.kernel.org
> Subject: [PATCH -next] i2c: mux: mlxcpld: remove unused including
> <linux/version.h>
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> Remove including <linux/version.h> that don't need it.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Acked-by: Vadim Pasternak <vadimp@mellanox.com>

>  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-
> mux-mlxcpld.c
> index b7ca249..e53f2ab 100644
> --- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> @@ -40,7 +40,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#include <linux/version.h>
>  #include <linux/i2c/mlxcpld.h>
>=20
>  #define CPLD_MUX_MAX_NCHANS	8
>=20
>=20
