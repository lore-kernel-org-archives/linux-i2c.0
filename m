From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C: S3C2410: Fixup error codes returned rom a transfer.
Date: Tue, 3 Jun 2008 17:28:05 +0200
Message-ID: <20080603172805.04bcbea0@hyperion.delvare>
References: <20080602192733.802003003@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080602192733.802003003-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Mon, 02 Jun 2008 20:27:34 +0100, Ben Dooks wrote:
> The driver should be returning -ENXIO for transfers that do not
> pass the initial address byte stage.
> 
> Note, also small tidyups to the driver comments in the area.

I prefer not mixing fixes with cleanups, but if you're going to push
this to Linus yourself, I don't care too much ;)

> Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 
> Index: linux-2.6.26-rc4-quilt3/drivers/i2c/busses/i2c-s3c2410.c
> ===================================================================
> --- linux-2.6.26-rc4-quilt3.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-06-02 20:19:14.000000000 +0100
> +++ linux-2.6.26-rc4-quilt3/drivers/i2c/busses/i2c-s3c2410.c	2008-06-02 20:20:02.000000000 +0100
> @@ -290,12 +290,12 @@ static int i2s_s3c_irq_nextbyte(struct s
>  		 * bus, or started a new i2c message
>  		 */
>  		
> -		if (iicstat  & S3C2410_IICSTAT_LASTBIT &&
> +		if (iicstat & S3C2410_IICSTAT_LASTBIT &&
>  		    !(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
>  			/* ack was not received... */
>  
>  			dev_dbg(i2c->dev, "ack was not received\n");
> -			s3c24xx_i2c_stop(i2c, -EREMOTEIO);
> +			s3c24xx_i2c_stop(i2c, -ENXIO);
>  			goto out_ack;
>  		}
>  
> @@ -305,7 +305,7 @@ static int i2s_s3c_irq_nextbyte(struct s
>  			i2c->state = STATE_WRITE;
>  
>  		/* terminate the transfer if there is nothing to do
> -		 * (used by the i2c probe to find devices */
> +		 * as this is used by the i2c probe to find devices. */

The "as" doesn't really fit.

>  
>  		if (is_lastmsg(i2c) && i2c->msg->len == 0) {
>  			s3c24xx_i2c_stop(i2c, 0);
> 

Other than that, patch looks fine to me.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
