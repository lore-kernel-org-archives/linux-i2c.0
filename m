From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/3] i2c: smbus: use get/put_unaligned_le16 when
 working with word data
Date: Mon, 18 Nov 2019 08:36:59 +0100
Message-ID: <20191118073659.7yomkvqthuenqjpu@pengutronix.de>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
 <20191112203132.163306-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112203132.163306-3-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.orgi, Luca Ceresoli <luca@lucaceresoli.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Dmitry,

On Tue, Nov 12, 2019 at 12:31:31PM -0800, Dmitry Torokhov wrote:
> It is potentially more performant, and also shows intent more clearly,
> to use get_unaligned_le16() and put_unaligned_le16() when working with
> word data.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> ---
> 
> Changes in v3:
> - split put_unaligned_le16 into a separate patch
> - more call sites converted to get/put_unaligned_le16
> 
>  drivers/i2c/i2c-core-smbus.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index f8708409b4dbc..7b4e2270eeda1 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -15,6 +15,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-smbus.h>
>  #include <linux/slab.h>
> +#include <asm/unaligned.h>
>  
>  #include "i2c-core.h"
>  
> @@ -370,8 +371,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  			msg[1].len = 2;
>  		else {
>  			msg[0].len = 3;
> -			msgbuf0[1] = data->word & 0xff;
> -			msgbuf0[2] = data->word >> 8;
> +			put_unaligned_le16(data->word, msgbuf0 + 1);

You claim this was clearer. For me it is not. With the explicit
assignment to msgbuf0[1] and msbbuf0[2] it is immediatly obvious to me
what happens.  Even though the endianness is explicitly mentioned in
put_unaligned_le16, it takes a bit longer for me to understand what it
does and which part of data->word ends up in which byte.

Concerning the "potentially more performant" part: I wonder if this is
backed by numbers and if it is indeed benificial on some platforms if
this is a compiler problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
