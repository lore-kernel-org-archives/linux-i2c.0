From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Tue, 02 Jul 2013 10:16:09 +0200
Message-ID: <1372752969.4277.8.camel@weser.hi.pengutronix.de>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1372713261-20551-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Montag, den 01.07.2013, 18:14 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Recently we have been seing some reports about PIO mode not working properly.
> 
> - http://www.spinics.net/lists/linux-i2c/msg11985.html
> - http://marc.info/?l=linux-i2c&m=137235593101385&w=2
> - https://lkml.org/lkml/2013/6/24/430
> 
> Let's use DMA mode even for small transfers.
> 
> Without this patch, i2c reads the incorrect sgtl5000 version on a mx28evk when
> touchscreen is enabled:
>                                            
> [    5.856270] sgtl5000 0-000a: Device with ID register 0 is not a sgtl5000     
> [    9.877307] sgtl5000 0-000a: ASoC: failed to probe CODEC -19                 
> [    9.883528] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -19      
> [    9.892955] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-19)  
> 
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> Applies against 3.10
> 
> Changes since v1:
> - Keep the PIO code
> 
>  drivers/i2c/busses/i2c-mxs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 2039f23..6d8094d 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -494,7 +494,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
>  	 * based on this empirical measurement and a lot of previous frobbing.
>  	 */
>  	i2c->cmd_err = 0;
> -	if (msg->len < 8) {
> +	if (0) {	/* disable PIO mode until a proper fix is made */
>  		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
>  		if (ret)
>  			mxs_i2c_reset(i2c);

I still plan to take another look at the PIO mode, but higher priority
things keep popping up in front of me. So this patch is:
Acked-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
