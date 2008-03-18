From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301: Sync with linux-omap
Date: Tue, 18 Mar 2008 13:46:33 +0100
Message-ID: <20080318134633.16f6e5f1@hyperion.delvare>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-2-git-send-email-me@felipebalbi.com>
	<1205585237-21492-3-git-send-email-me@felipebalbi.com>
	<1205585237-21492-4-git-send-email-me@felipebalbi.com>
	<20080315124918.GA21547@kedavra.cpe.vivax.com.br>
	<20080315125458.GB21547@kedavra.cpe.vivax.com.br>
	<20080315131309.GA24990@kedavra.cpe.vivax.com.br>
	<20080316105617.GA4503@kedavra.cpe.vivax.com.br>
	<20080316110033.GB4503@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080316110033.GB4503-4vvIQG7NF+ITKvXZea5imILpUPVTGn5w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felipe,

On Sun, 16 Mar 2008 13:00:35 +0200, Felipe Balbi wrote:
> There are some changes on linux-omap's isp1301_omap.c
> that could already be in linux-mainline after
> omap1/2 got merged.
> 
> This patch sync such changes from linux-omap into linux-mailine.

I fear I will need a better description than this. Please explain what
the changes are and why they are needed. "sync with an external tree"
isn't sufficient.

> 
> Signed-off-by: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
> ---
>  drivers/i2c/chips/isp1301_omap.c |   40 +++++++++++++++++++++++++++++--------
>  1 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
> index 9f2ccaf..9e3a6f3 100644
> --- a/drivers/i2c/chips/isp1301_omap.c
> +++ b/drivers/i2c/chips/isp1301_omap.c
> @@ -84,7 +84,8 @@ struct isp1301 {
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#ifdef	CONFIG_MACH_OMAP_H2
> +#if	defined(CONFIG_MACH_OMAP_H2) || \
> +	defined(CONFIG_MACH_OMAP_H3)
>  
>  /* board-specific PM hooks */
>  
> @@ -122,17 +123,30 @@ static void enable_vbus_source(struct isp1301 *isp)
>  }
>  
>  
> -/* products will deliver OTG messages with LEDs, GUI, etc */
> -static inline void notresponding(struct isp1301 *isp)
> +#else
> +
> +static void enable_vbus_draw(struct isp1301 *isp, unsigned mA)
>  {
> -	printk(KERN_NOTICE "OTG device not responding.\n");
> +	pr_debug("%s UNIMPL\n", __FUNCTION__);
>  }
>  
> +static void enable_vbus_source(struct isp1301 *isp)
> +{
> +	pr_debug("%s UNIMPL\n", __FUNCTION__);
> +}
>  
>  #endif
>  
>  /*-------------------------------------------------------------------------*/
>  
> +/* products will deliver OTG messages with LEDs, GUI, etc */
> +static inline void notresponding(struct isp1301 *isp)
> +{
> +	printk(KERN_NOTICE "OTG device not responding.\n");
> +}
> +
> +/*-------------------------------------------------------------------------*/
> +
>  /* only two addresses possible */
>  static struct i2c_driver isp1301_driver;
>  
> @@ -495,6 +509,7 @@ static inline void check_state(struct isp1301 *isp, const char *tag) { }
>  static void update_otg1(struct isp1301 *isp, u8 int_src)
>  {
>  	u32	otg_ctrl;
> +	u8      int_id;
>  
>  	otg_ctrl = OTG_CTRL_REG
>  			& OTG_CTRL_MASK
> @@ -508,7 +523,10 @@ static void update_otg1(struct isp1301 *isp, u8 int_src)
>  	}
>  	if (int_src & INTR_VBUS_VLD)
>  		otg_ctrl |= OTG_VBUSVLD;
> -	if (int_src & INTR_ID_GND) {		/* default-A */
> +
> +	int_id = isp1301_get_u8(isp, ISP1301_INTERRUPT_SOURCE);
> +
> +	if (int_id & INTR_ID_GND) {		/* default-A */
>  		if (isp->otg.state == OTG_STATE_B_IDLE
>  				|| isp->otg.state == OTG_STATE_UNDEFINED) {
>  			a_idle(isp, "init");
> @@ -1063,7 +1081,7 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
>  	/* update the OTG controller state to match the isp1301; may
>  	 * trigger OPRT_CHG irqs for changes going to the isp1301.
>  	 */
> -	update_otg1(isp, isp_stat);
> +	update_otg1(isp, isp_stat); /* pass the actual interrupt latch status */
>  	update_otg2(isp, isp_bstat);
>  	check_state(isp, __FUNCTION__);
>  #endif
> @@ -1337,13 +1355,13 @@ isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
>  	power_up(isp);
>  	isp->otg.state = OTG_STATE_B_IDLE;
>  
> -	if (machine_is_omap_h2())
> +	if (machine_is_omap_h2() || machine_is_omap_h3())
>  		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
>  
>  	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
> -		INTR_SESS_VLD);
> +		INTR_SESS_VLD | INTR_VBUS_VLD);
>  	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
> -		INTR_VBUS_VLD);
> +		INTR_VBUS_VLD | INTR_SESS_VLD);
>  	dev_info(&isp->client->dev, "B-Peripheral sessions ok\n");
>  	dump_regs(isp, __func__);
>  
> @@ -1420,6 +1438,10 @@ isp1301_start_hnp(struct otg_transceiver *dev)
>  	 * So do this part as early as possible...
>  	 */
>  	switch (isp->otg.state) {
> +	case OTG_STATE_B_PERIPHERAL:
> +		isp->otg.state = OTG_STATE_B_WAIT_ACON;
> +		isp1301_defer_work(isp, WORK_UPDATE_ISP);
> +		break;
>  	case OTG_STATE_B_HOST:
>  		isp->otg.state = OTG_STATE_B_PERIPHERAL;
>  		/* caller will suspend next */


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
