From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC
Date: Mon, 20 May 2019 14:41:07 +0200
Message-ID: <20190520124107.GA25785@lunn.ch>
References: <1558354817-12034-1-git-send-email-sagar.kadam@sifive.com>
 <1558354817-12034-4-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1558354817-12034-4-git-send-email-sagar.kadam@sifive.com>
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

> @@ -406,7 +416,7 @@ static int ocores_xfer(struct i2c_adapter *adap,
>  {
>  	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
>  
> -	if (i2c->flags & OCORES_FLAG_POLL)
> +	if ((i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ)))
>  		return ocores_xfer_polling(adap, msgs, num);
>  	return ocores_xfer_core(i2c, msgs, num, false);
>  }

You are not listening to what i said. All you need to know here is
that you must poll. It does not matter if the IRQ is broken or not.

>  	irq = platform_get_irq(pdev, 0);
>  	if (irq == -ENXIO) {
> -		i2c->flags |= OCORES_FLAG_POLL;

If there is no interrupt, you need to poll. So keep this line.

> +		/*
> +		 * Set a OCORES_FLAG_BROKEN_IRQ to enable workaround for
> +		 * FU540-C000 SoC in polling mode interface of i2c-ocore driver.
> +		 * Else enable default polling mode interface for SIFIVE/OCORE
> +		 * device types.
> +		 */
> +		match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
> +		if (match && (long)match->data == TYPE_SIFIVE_REV0)
> +			i2c->flags |= OCORES_FLAG_BROKEN_IRQ;

If it is a OCORE, IRQ is broken, so OR in OCORES_FLAG_BROKEN_IRQ.

>  
> -	if (!(i2c->flags & OCORES_FLAG_POLL)) {
> +	if (!(i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ))) {
>  		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
>  				       pdev->name, i2c);

Here you just need to know if you are polling. Broken IRQ does not
matter.

	Andrew
