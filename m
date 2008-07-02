From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Export the i2c_bus_type symbol, standalone V1
Date: Wed, 2 Jul 2008 14:37:33 +0200
Message-ID: <20080702143733.31727d6c@hyperion.delvare>
References: <20080701182036.14694.30720.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080701182036.14694.30720.stgit@terra>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Tue, 01 Jul 2008 14:20:36 -0400, Jon Smirl wrote:
> Export the root of the i2c bus so that PowerPC device tree code can iterate over devices on the i2c bus.
> 
> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> 
>  drivers/i2c/i2c-core.c |    3 ++-
>  include/linux/i2c.h    |    3 +++
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index d0175f4..05866ef 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -208,7 +208,7 @@ static struct device_attribute i2c_dev_attrs[] = {
>  	{ },
>  };
>  
> -static struct bus_type i2c_bus_type = {
> +struct bus_type i2c_bus_type = {
>  	.name		= "i2c",
>  	.dev_attrs	= i2c_dev_attrs,
>  	.match		= i2c_device_match,
> @@ -219,6 +219,7 @@ static struct bus_type i2c_bus_type = {
>  	.suspend	= i2c_device_suspend,
>  	.resume		= i2c_device_resume,
>  };
> +EXPORT_SYMBOL_GPL(i2c_bus_type);
>  
>  
>  /**
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index fb9af6a..186b22d 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -92,6 +92,9 @@ extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
>  extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
>  					  u8 command, u8 length,
>  					  const u8 *values);
> +					  
> +/* Base of the i2c bus */
> +extern struct bus_type i2c_bus_type; 
>  
>  /*
>   * A driver is capable of handling one or more physical devices present on

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
