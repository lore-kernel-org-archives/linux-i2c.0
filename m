From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C_FUNC_SMBUS_QUICK on i2c-mxs
Date: Thu, 30 Aug 2012 13:39:45 +0200
Message-ID: <20120830133945.7c56ae0f@endymion.delvare>
References: <CAOMZO5Dyp-+GXkWZvgsFXbZv15N+4u3iuPjw-sqwLn=5bVGBsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5Dyp-+GXkWZvgsFXbZv15N+4u3iuPjw-sqwLn=5bVGBsw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek =?UTF-8?B?VmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Fabio,

On Mon, 27 Aug 2012 16:32:12 -0300, Fabio Estevam wrote:
> When using i2cdetect on a mx28 I get:
> 
> $ i2cdetect 0
> Error: Can't use SMBus Quick Write command on this bus (ISA bus?)

You must be using a somewhat old version of i2c-tools, as the stray
reference to the ISA bus was removed two years ago already.

> Enabling I2C_FUNC_SMBUS_QUICK the error goes away:
> ---
>  drivers/i2c/busses/i2c-mxs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 088c5c1..84484bb 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -322,7 +322,7 @@ static int mxs_i2c_xfer(struct i2c_adapter *adap,
> struct i2c_msg msgs[],
> 
>  static u32 mxs_i2c_func(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
> 
>  static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
>
> Could anyone clarify whether I2C_FUNC_SMBUS_QUICK option could be
> turned on or not?

Well, I2C_FUNC_SMBUS_QUICK was left out explicitly, so I would expect
there was a good reason for this. Looking at the driver code:

> static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
> 				int stop)
> {
> (...)
> 	if (msg->len == 0)
> 		return -EINVAL;

it seems that quick transactions are really not supported by the
driver. So your hack made the error message go away but presumably
i2cdetect couldn't see any slave device on your I2C bus (except for the
limited address range where it doesn't use quick writes by default.)

You may want to try "i2cdetect -r" on this bus, but first please read
the warning in the manual page.

What is on your bus and what are you trying to find with i2cdetect?

Looking at the code in i2cdetect, it appears the checks are more strict
than they need to be. Instead of bailing out by default if either quick
writes or short reads aren't supported, we could simply warn and skip
the addresses we can't probe. Only if both quick writes and short reads
are unsupported, we should bail out. I can implement this easily if it
solves your problem.

-- 
Jean Delvare
