From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv7 10/11] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Mon, 7 Nov 2016 16:20:19 -0300
Message-ID: <1ac3a33e-a85c-e781-81b6-c39f3d533da8@osg.samsung.com>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-11-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:60878
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750862AbcKGTUZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Nov 2016 14:20:25 -0500
In-Reply-To: <1478522866-29620-11-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com

Hello Kieran,

On 11/07/2016 09:47 AM, Kieran Bingham wrote:
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
> 
>  drivers/mfd/as3722.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index f87342c211bc..7d8c5e4136e2 100644
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

This is OK...

>  	struct as3722 *as3722;
>  	unsigned long irq_flags;
> @@ -441,12 +440,6 @@ static const struct of_device_id as3722_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, as3722_of_match);
>  
> -static const struct i2c_device_id as3722_i2c_id[] = {
> -	{ "as3722", 0 },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
> -

... but I don't think this is correct. Otherwise you will break module
autoload for this driver since modpost needs the I2C device ID table
info to fill the i2c modalias in the drivers' module.

Remember that i2c_device_uevent() always reports modalias of the form
MODALIAS=i2c:<foo> even when your series allows to match without a I2C
device ID table.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
