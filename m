From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ARM: DaVinci: I2C: enable zero-length transfer
 hack
Date: Tue, 12 Feb 2008 16:56:06 +0100
Message-ID: <20080212165606.6ad455f6@hyperion.delvare>
References: <1202781587-3274-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1202781587-3274-1-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Troy,

On Mon, 11 Feb 2008 18:59:47 -0700, Troy Kisky wrote:
> From: Vladimir Barinov <vbarinov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> 
> ARM: DaVinci: I2C: enable zero-length transfer hack
> 
> Signed-off-by: Vladimir Barinov <vbarinov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 6767988..f348ee0 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -41,6 +41,11 @@
>  
>  #include <asm/arch/i2c.h>
>  
> +/* Hack to enable zero length transfers and smbus quick until clean fix
> + * is available
> + */
> +#define DAVINCI_HACK
> +
>  /* ----- global defines ----------------------------------------------- */
>  
>  #define DAVINCI_I2C_TIMEOUT	(1*HZ)
> @@ -236,9 +241,14 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	u32 stat;
>  	u16 w;
>  	int r;
> +#ifdef DAVINCI_HACK
> +	u8 zero_byte = 0;
> +#endif
>  
> +#ifndef DAVINCI_HACK
>  	if (msg->len == 0)
>  		return -EINVAL;
> +#endif
>  
>  	if (!pdata)
>  		pdata = &davinci_i2c_platform_data_default;
> @@ -249,8 +259,18 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	/* set the slave address */
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
>  
> +#ifndef DAVINCI_HACK
>  	dev->buf = msg->buf;
>  	dev->buf_len = msg->len;
> +#else
> +	if (msg->len == 0) {
> +		dev->buf = &zero_byte;
> +		dev->buf_len = 1;
> +	} else {
> +		dev->buf = msg->buf;
> +		dev->buf_len = msg->len;
> +	}
> +#endif
>  
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len);
>  
> @@ -349,7 +369,11 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  static u32 i2c_davinci_func(struct i2c_adapter *adap)
>  {
> +#ifndef DAVINCI_HACK
>  	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
> +#else
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +#endif
>  }
>  
>  /*

Nack. If the hardware doesn't support zero-byte transactions, it
doesn't support them, period. The new i2c framework makes it very easy
to live without these transactions anyway.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
