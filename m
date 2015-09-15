From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: core: fix a code to suppress a warning
Date: Tue, 15 Sep 2015 14:25:59 +0300
Message-ID: <55F80047.4000805@mentor.com>
References: <1442311867-60185-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442311867-60185-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Andy,

On 15.09.2015 13:11, Andy Shevchenko wrote:
> There is a warning when compiling i2c-core.c
> drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y
> 
> Fix it by using ternary operator.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 3a4c54e..d13a8a0 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2591,7 +2591,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t count)
>  static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
>  {
>  	/* The address will be sent first */
> -	u8 addr = (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
> +	u8 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) ? 1 : 0);
>  	pec = i2c_smbus_pec(pec, &addr, 1);
>  
>  	/* The data buffer follows */
> 

I2C_M_RD is defined as 1, probably (msg->flags & I2C_M_RD) is good
enough here.

--
With best wishes,
Vladimir
