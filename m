From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: raw read and write endian fix
Date: Thu, 21 Nov 2013 19:05:26 +0200
Message-ID: <528E3D56.5010908@ti.com>
References: <1384971824-7707-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384971824-7707-1-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 11/20/2013 08:23 PM, Taras Kondratiuk wrote:
> I2C IP block expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.
>
> Changes are trivial sed like replacement of __raw_xxx functions
> with xxx_relaxed variant.

Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

>
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Based on Linus' master tip (b4789b8).
> Tested on Keystone2 EVM.
>
>   drivers/i2c/busses/i2c-davinci.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 132369f..a629447 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -125,12 +125,12 @@ static struct davinci_i2c_platform_data davinci_i2c_platform_data_default = {
>   static inline void davinci_i2c_write_reg(struct davinci_i2c_dev *i2c_dev,
>   					 int reg, u16 val)
>   {
> -	__raw_writew(val, i2c_dev->base + reg);
> +	writew_relaxed(val, i2c_dev->base + reg);
>   }
>
>   static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
>   {
> -	return __raw_readw(i2c_dev->base + reg);
> +	return readw_relaxed(i2c_dev->base + reg);
>   }
>
>   /* Generate a pulse on the i2c clock pin. */
>
