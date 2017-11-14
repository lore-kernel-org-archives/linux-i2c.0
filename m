From: jacopo mondi <jacopo@jmondi.org>
Subject: Re: [PATCH] i2c: sh_mobile: send STOP according to datasheet
Date: Tue, 14 Nov 2017 10:10:16 +0100
Message-ID: <20171114091016.GF19070@w540>
References: <20171110115210.21955-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:55295 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754122AbdKNJeN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Nov 2017 04:34:13 -0500
Content-Disposition: inline
In-Reply-To: <20171110115210.21955-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram,

On Fri, Nov 10, 2017 at 12:52:10PM +0100, Wolfram Sang wrote:
> We initiate STOP (or REP_START) on the second last WAIT interrupt
> currently. This works fine but is not according to the datasheet which
> says to do it on the last WAIT interrupt. This also simplifies the code
> quite a lot, so let's do it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Jacopo: another one to test, pretty please.

No regressions on Migo-R during image capture.

Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

>
>  drivers/i2c/busses/i2c-sh_mobile.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 40a66d466c3c49..c904be631db302 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -40,21 +40,21 @@
>  /* BUS:     S     A8     ACK   P(*)                                         */
>  /* IRQ:       DTE   WAIT                                                    */
>  /* ICIC:                                                                    */
> -/* ICCR: 0x94 0x90                                                          */
> +/* ICCR: 0x94       0x90                                                    */
>  /* ICDR:      A8                                                            */
>  /*                                                                          */
>  /* 1 byte transmit                                                          */
>  /* BUS:     S     A8     ACK   D8(1)   ACK   P(*)                           */
>  /* IRQ:       DTE   WAIT         WAIT                                       */
>  /* ICIC:      -DTE                                                          */
> -/* ICCR: 0x94       0x90                                                    */
> +/* ICCR: 0x94                    0x90                                       */
>  /* ICDR:      A8    D8(1)                                                   */
>  /*                                                                          */
>  /* 2 byte transmit                                                          */
>  /* BUS:     S     A8     ACK   D8(1)   ACK   D8(2)   ACK   P(*)             */
>  /* IRQ:       DTE   WAIT         WAIT          WAIT                         */
>  /* ICIC:      -DTE                                                          */
> -/* ICCR: 0x94                    0x90                                       */
> +/* ICCR: 0x94                                  0x90                         */
>  /* ICDR:      A8    D8(1)        D8(2)                                      */
>  /*                                                                          */
>  /* 3 bytes or more, +---------+ gets repeated                               */
> @@ -113,7 +113,6 @@ enum sh_mobile_i2c_op {
>  	OP_TX_FIRST,
>  	OP_TX,
>  	OP_TX_STOP,
> -	OP_TX_STOP_DATA,
>  	OP_TX_TO_RX,
>  	OP_RX,
>  	OP_RX_STOP,
> @@ -319,10 +318,7 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
>  	case OP_TX: /* write data */
>  		iic_wr(pd, ICDR, data);
>  		break;
> -	case OP_TX_STOP_DATA: /* write data and issue a stop afterwards */
> -		iic_wr(pd, ICDR, data);
> -		/* fallthrough */
> -	case OP_TX_STOP: /* issue a stop */
> +	case OP_TX_STOP: /* issue a stop (or rep_start) */
>  		iic_wr(pd, ICCR, pd->send_stop ? ICCR_ICE | ICCR_TRS
>  					       : ICCR_ICE | ICCR_TRS | ICCR_BBSY);
>  		break;
> @@ -356,11 +352,6 @@ static bool sh_mobile_i2c_is_first_byte(struct sh_mobile_i2c_data *pd)
>  	return pd->pos == -1;
>  }
>
> -static bool sh_mobile_i2c_is_last_byte(struct sh_mobile_i2c_data *pd)
> -{
> -	return pd->pos == pd->msg->len - 1;
> -}
> -
>  static void sh_mobile_i2c_get_data(struct sh_mobile_i2c_data *pd,
>  				   unsigned char *buf)
>  {
> @@ -378,20 +369,12 @@ static int sh_mobile_i2c_isr_tx(struct sh_mobile_i2c_data *pd)
>  	unsigned char data;
>
>  	if (pd->pos == pd->msg->len) {
> -		/* Send stop if we haven't yet (DMA case) */
> -		if (pd->send_stop && pd->stop_after_dma)
> -			i2c_op(pd, OP_TX_STOP, 0);
> +		i2c_op(pd, OP_TX_STOP, 0);
>  		return 1;
>  	}
>
>  	sh_mobile_i2c_get_data(pd, &data);
> -
> -	if (sh_mobile_i2c_is_last_byte(pd))
> -		i2c_op(pd, OP_TX_STOP_DATA, data);
> -	else if (sh_mobile_i2c_is_first_byte(pd))
> -		i2c_op(pd, OP_TX_FIRST, data);
> -	else
> -		i2c_op(pd, OP_TX, data);
> +	i2c_op(pd, sh_mobile_i2c_is_first_byte(pd) ? OP_TX_FIRST : OP_TX, data);
>
>  	pd->pos++;
>  	return 0;
> --
> 2.11.0
>
