From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: expand I2C's id.name to 23 characters
Date: Fri, 19 Sep 2008 22:03:08 +0200
Message-ID: <20080919220308.3173320e@hyperion.delvare>
References: <20080919180339.GA13899@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080919180339.GA13899-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 19 Sep 2008 22:03:39 +0400, Anton Vorontsov wrote:
> It was discussed[1] that we should match on the first (most specific)
> entry in the device tree.
> 
> The most lengthy I2C compatible entry for the MPC8349E-mITX MCU
> devices is "mc9s08qg8-mpc8349emitx" (w/o vendor name). This means
> that we have to allow longer IDs to be used in the I2C subsystem.
> 
> [1] http://www.mail-archive.com/linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org/msg21196.html

Nack. Just come up with shorter names. "mc9s08qg8-mpc8349emitx" is
simply too long to start with. Looking at the mcu_mpc8349emitx driver
you just submitted, you are clearly abusing the i2c client name to pass
platform-specific information, and that's bad. I'm not even sure why
you do that, given that all the names are then handled the same as far
as I can see.

> 
> Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> ---
>  include/linux/mod_devicetable.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index c4db582..9d9d1f5 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -379,7 +379,7 @@ struct virtio_device_id {
>  
>  /* i2c */
>  
> -#define I2C_NAME_SIZE	20
> +#define I2C_NAME_SIZE	23
>  #define I2C_MODULE_PREFIX "i2c:"
>  
>  struct i2c_device_id {


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
