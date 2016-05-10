From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 8/8] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Tue, 10 May 2016 01:20:16 -0400
Message-ID: <a34c73e5-afdb-5f2b-0775-4959cb09dbaa@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-9-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462374888-22888-9-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> Also remove unused second probe() parameter 'i2c_device_id'.
>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> 
> ---
> Changes since v4
>  - Rename .probe2 to probe_new
> ---
>  drivers/mfd/as3722.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index e1f597f97f86..28fc62af6861 100644
> --- a/drivers/mfd/as3722.c
> +++ b/drivers/mfd/as3722.c
> @@ -354,8 +354,7 @@ static int as3722_i2c_of_probe(struct i2c_client *i2c,
>  	return 0;
>  }
>  
> -static int as3722_i2c_probe(struct i2c_client *i2c,
> -			const struct i2c_device_id *id)
> +static int as3722_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct as3722 *as3722;
>  	unsigned long irq_flags;
> @@ -453,12 +452,6 @@ static const struct of_device_id as3722_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, as3722_of_match);
>  
> -static const struct i2c_device_id as3722_i2c_id[] = {
> -	{ "as3722", 0 },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
> -

Just a note that this can only be made because the driver's Kconfig symbol
is bool and not tristate. Since for drivers that can be built as a module,
the I2C core always reports a MODALIAS of the form "i2c:as3722" and so the
i2c_device_id array and the MODULE_DEVICE_TABLE() are needed even when not
used by the driver.

As mentioned the change is correct for this driver but I just wanted to
point out in case other authors try to do the same change for drivers that
can be built as a module and so breaking module auto-loading.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
