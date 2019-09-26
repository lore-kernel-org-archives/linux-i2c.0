From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] i2c: riic: Clear NACK in tend isr
Date: Thu, 26 Sep 2019 06:54:59 +0200
Message-ID: <20190926045459.GA1560081@kroah.com>
References: <20190925194327.28109-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190925194327.28109-1-chris.brandt@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 25, 2019 at 02:43:27PM -0500, Chris Brandt wrote:
> The NACKF flag should be cleared in INTRIICNAKI interrupt processing as
> description in HW manual.
> 
> This issue shows up quickly when PREEMPT_RT is applied and a device is
> probed that is not plugged in (like a touchscreen controller). The result
> is endless interrupts that halt system boot.
> 
> Fixes: 310c18a41450 ("i2c: riic: add driver")
> Reported-by: Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  drivers/i2c/busses/i2c-riic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
> index f31413fd9521..800414886f6b 100644
> --- a/drivers/i2c/busses/i2c-riic.c
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -202,6 +202,7 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
>  	if (readb(riic->base + RIIC_ICSR2) & ICSR2_NACKF) {
>  		/* We got a NACKIE */
>  		readb(riic->base + RIIC_ICDRR);	/* dummy read */
> +		riic_clear_set_bit(riic, ICSR2_NACKF, 0, RIIC_ICSR2);
>  		riic->err = -ENXIO;
>  	} else if (riic->bytes_left) {
>  		return IRQ_NONE;
> -- 
> 2.23.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
