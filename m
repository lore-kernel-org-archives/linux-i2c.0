From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] i2c: riic: fix restart condition
Date: Tue, 7 Mar 2017 07:42:58 +0100
Message-ID: <20170307064257.GC14208@verge.net.au>
References: <20170306202051.3158-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306202051.3158-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 06, 2017 at 03:20:51PM -0500, Chris Brandt wrote:
> While modifying the driver to use the STOP interrupt, the completion of the
> intermediate transfers need to wake the driver back up in order to initiate
> the next transfer (restart condition). Otherwise you get never ending
> interrupts and only the first transfer sent.
> 
> Fixes: 71ccea095ea1 ("i2c: riic: correctly finish transfers")
> Reported-by: Simon Horman <horms@verge.net.au>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks Chris,

with this patch applied on top of v4.11-rc1 Genmai once again boots
to userspace with shmobile_defconfig.

Tested-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/i2c/busses/i2c-riic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
> index 8f11d34..c811af4 100644
> --- a/drivers/i2c/busses/i2c-riic.c
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -218,8 +218,12 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
>  	}
>  
>  	if (riic->is_last || riic->err) {
> -		riic_clear_set_bit(riic, 0, ICIER_SPIE, RIIC_ICIER);
> +		riic_clear_set_bit(riic, ICIER_TEIE, ICIER_SPIE, RIIC_ICIER);
>  		writeb(ICCR2_SP, riic->base + RIIC_ICCR2);
> +	} else {
> +		/* Transfer is complete, but do not send STOP */
> +		riic_clear_set_bit(riic, ICIER_TEIE, 0, RIIC_ICIER);
> +		complete(&riic->msg_done);
>  	}
>  
>  	return IRQ_HANDLED;
> -- 
> 2.10.1
> 
> 
