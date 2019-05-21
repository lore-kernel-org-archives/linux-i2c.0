From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC.
Date: Tue, 21 May 2019 15:54:39 +0200
Message-ID: <20190521135439.GM22024@lunn.ch>
References: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
 <1558445574-16471-4-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1558445574-16471-4-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, palmer@sifive.com, paul.walmsley@sifive.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>  static void ocores_process_polling(struct ocores_i2c *i2c)
>  {
> +	const struct of_device_id *match;
> +
> +	match = of_match_node(ocores_i2c_match, i2c->adap.dev.of_node);
> +
>  	while (1) {
>  		irqreturn_t ret;
>  		int err;

Please keep with the idea of i2c->flags, which is set during probe.
Just because it was removed because it was no longer needed does not
stop you from putting it back again if it is needed.

       Andrew
