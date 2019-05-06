From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v1 v1 3/3] i2c-ocores: sifive: add polling mode
 workaround for FU540-C000 SoC.
Date: Mon, 6 May 2019 15:29:24 +0200
Message-ID: <20190506132924.GD15291@lunn.ch>
References: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
 <1557147240-29551-4-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1557147240-29551-4-git-send-email-sagar.kadam@sifive.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, peter@korsgaard.com, palmer@sifive.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-i2c@vger.kernel.org, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

>  /*
>   * 'process_lock' exists because ocores_process() and ocores_process_timeout()
> @@ -239,8 +240,13 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
>  	struct ocores_i2c *i2c = dev_id;
>  	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
>  
> -	if (!(stat & OCI2C_STAT_IF))
> +	if (i2c->flags && SIFIVE_FLAG_POLL) {

Do you really want && here?

> +		if (stat & OCI2C_STAT_IF)
> +			if (!(stat & OCI2C_STAT_BUSY))
> +				return IRQ_NONE;
> +	} else if (!(stat & OCI2C_STAT_IF)) {
>  		return IRQ_NONE;
> +	}
>  
>  	ocores_process(i2c, stat);
>  
> @@ -356,6 +362,11 @@ static void ocores_process_polling(struct ocores_i2c *i2c)
>  		ret = ocores_isr(-1, i2c);
>  		if (ret == IRQ_NONE)
>  			break; /* all messages have been transferred */
> +		else {
> +			if (i2c->flags && SIFIVE_FLAG_POLL)

And here?

> +				if (i2c->state == STATE_DONE)
> +					break;
> +		}
>  	}
>  }
>  
> @@ -406,7 +417,7 @@ static int ocores_xfer(struct i2c_adapter *adap,
>  {
>  	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
>  
> -	if (i2c->flags & OCORES_FLAG_POLL)
> +	if ((i2c->flags & OCORES_FLAG_POLL) || (i2c->flags & SIFIVE_FLAG_POLL))

You can combine this

if ((i2c->flags & (OCORES_FLAG_POLL | SIFIVE_FLAG_POLL))

>  		return ocores_xfer_polling(adap, msgs, num);
>  	return ocores_xfer_core(i2c, msgs, num, false);
>  }
> @@ -597,6 +608,7 @@ static int ocores_i2c_probe(struct platform_device *pdev)
>  {
>  	struct ocores_i2c *i2c;
>  	struct ocores_i2c_platform_data *pdata;
> +	const struct of_device_id *match;
>  	struct resource *res;
>  	int irq;
>  	int ret;
> @@ -678,13 +690,21 @@ static int ocores_i2c_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq == -ENXIO) {
> -		i2c->flags |= OCORES_FLAG_POLL;
> +		/*
> +		 * Set a SIFIVE_FLAG_POLL to enable workaround for FU540
> +		 * in polling mode interface of i2c-ocore driver.
> +		 */
> +		match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
> +		if (match && (long)match->data == TYPE_SIFIVE_REV0)
> +			i2c->flags |= SIFIVE_FLAG_POLL;
> +		else
> +			i2c->flags |= OCORES_FLAG_POLL;

Please take a look at the whole code, and consider if it is better to
set both SIFIVE_FLAG_POLL and OCORES_FLAG_POLL. Maybe rename
SIFIVE_FLAG_POLL to OCORES_FLAG_BROKEN_IRQ_BIT?

Thanks
	Andrew
