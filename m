From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-au1550: properly terminate zero-byte
	transfers
Date: Thu, 17 Jan 2008 16:52:30 +0100
Message-ID: <20080117165230.711e87bf@hyperion.delvare>
References: <20080114084652.GA15392@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080114084652.GA15392-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, cd-8pe3aW1LYQvVtiohHAVwjA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

On Mon, 14 Jan 2008 09:46:52 +0100, Manuel Lauss wrote:
> Here is my third try to fix the corrupted RTC minute register
> on my board in conjunction with the i2c-au1550 driver.
> 
> Here's a trace of the controller accessing the RTC (0xA2):
> http://mlau.at/files/i2c-au1550-original_behav.png
> 
> Notice the missing stop condition after the quick probe.
> 
> Here's a trace with the patch applied:
> http://mlau.at/files/i2c-au1550-misbehavior-patch-behav.png
> 
> Please apply!

Nice pictures, it's really helpful to be able to visualize what's
happening on the I2C bus.

> 
> ---
> From 443520b88bda030ba304dcbbbf14f977abad5ff5 Mon Sep 17 00:00:00 2001
> From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> Date: Mon, 14 Jan 2008 09:28:11 +0100
> Subject: [PATCH] i2c: i2c-au1550: properly terminate zero-byte transfers
> 
> Zero-bytes transfers would leave the bus transaction unfinished
> (no i2c stop is sent), with the following transfer actually
> sending the slave address to the previously addressed device,
> resulting in weird device failures (e.g. reset minute register
> values in my RTC).
> This patch instructs the controller to send an I2C STOP right after
> the slave address in case of a zero-byte transfer.
> 
> Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-au1550.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
> index 2f68416..7d51a43 100644
> --- a/drivers/i2c/busses/i2c-au1550.c
> +++ b/drivers/i2c/busses/i2c-au1550.c
> @@ -105,7 +105,7 @@ wait_master_done(struct i2c_au1550_data *adap)
>  }
>  
>  static int
> -do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd)
> +do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd, int q)
>  {
>  	volatile psc_smb_t	*sp;
>  	u32			stat;
> @@ -134,6 +134,10 @@ do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd)
>  	if (rd)
>  		addr |= 1;
>  
> +	/* zero-byte xfers stop immediately */
> +	if (q)
> +		addr |= PSC_SMBTXRX_STP;
> +
>  	/* Put byte into fifo, start up master.
>  	*/
>  	sp->psc_smbtxrx = addr;
> @@ -142,7 +146,7 @@ do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd)
>  	au_sync();
>  	if (wait_ack(adap))
>  		return -EIO;
> -	return 0;
> +	return (q) ? wait_master_done(adap) : 0;
>  }
>  
>  static u32
> @@ -262,7 +266,8 @@ au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
>  
>  	for (i = 0; !err && i < num; i++) {
>  		p = &msgs[i];
> -		err = do_address(adap, p->addr, p->flags & I2C_M_RD);
> +		err = do_address(adap, p->addr, p->flags & I2C_M_RD,
> +				 (p->len == 0));
>  		if (err || !p->len)
>  			continue;
>  		if (p->flags & I2C_M_RD)

This approach looks much nicer than your previous proposal. I like it.
Applied, thanks!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
