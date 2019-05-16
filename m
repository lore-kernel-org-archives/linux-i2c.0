From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC
Date: Thu, 16 May 2019 14:31:20 +0200
Message-ID: <20190516123120.GB14298@lunn.ch>
References: <1557983320-14461-1-git-send-email-sagar.kadam@sifive.com>
 <1557983320-14461-4-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557983320-14461-4-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, palmer@sifive.com, paul.walmsley@sifive.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> @@ -682,13 +693,24 @@ static int ocores_i2c_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq == -ENXIO) {
> -		i2c->flags |= OCORES_FLAG_POLL;
> +		/*
> +		 * Set a OCORES_FLAG_BROKEN_IRQ to enable workaround for
> +		 * FU540-C000 SoC in polling mode interface of i2c-ocore driver.
> +		 * Else enable default polling mode interface for SIFIVE/OCORE
> +		 * device types.
> +		 */
> +		match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
> +		if (match && (long)match->data ==
> +				(TYPE_SIFIVE_REV0 | OCORES_FLAG_BROKEN_IRQ))

This looks wrong. You added:

+       {
+               .compatible = "sifive,fu540-c000-i2c",
+               .data = (void *)TYPE_SIFIVE_REV0,
+       },
+       {
+               .compatible = "sifive,i2c0",
+               .data = (void *)TYPE_SIFIVE_REV0,
+       },

So match->data just has TYPE_SIFIVE_REV0.

> +			i2c->flags |= OCORES_FLAG_BROKEN_IRQ;
> +		else
> +			i2c->flags |= OCORES_FLAG_POLL;

These two don't need to be exclusive. It makes more sense to say
SIFIVE needs to poll and it its IRQ is broken. A lot of your other
changes then go away.

       Andrew
