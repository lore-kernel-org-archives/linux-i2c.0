From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
Date: Fri, 03 Jan 2014 13:20:21 +0100
Message-ID: <52C6AB05.7000405@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com> <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388743185-24822-3-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jason,

On 03/01/2014 10:59, Gregory CLEMENT wrote:
> The first variants of Armada XP SoCs (A0 stepping) have issues related
> to the i2c controller which prevent to use the offload mechanism and
> lead to a kernel hang during boot.
> 
> The driver now check the revision of the SoC. If the revision is not
> more recent than the A0 or if the driver can't get the SoC revision
> then it disables the offload mechanism.
> 
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

I have just realized that it should be fair to add a

Reported-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>

Thanks,

Gregory


> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 8be7e42aa4de..634b04d241fb 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -24,6 +24,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/mvebu-soc-id.h>
>  
>  #define MV64XXX_I2C_ADDR_ADDR(val)			((val & 0x7f) << 1)
>  #define MV64XXX_I2C_BAUD_DIV_N(val)			(val & 0x7)
> @@ -779,8 +780,16 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  	 * Transaction Generator support and the errata fix.
>  	 */
>  	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
> -		drv_data->offload_enabled = true;
> +		u32 dev, rev;
> +
>  		drv_data->errata_delay = true;
> +		/*
> +		 * Only revison more recent than A0 support offload
> +		 * mechanism. In case we can't get the SoC revision
> +		 * weplay safe and we don't enable it
> +		 */
> +		if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
> +			drv_data->offload_enabled = true;
>  	}
>  
>  out:
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
