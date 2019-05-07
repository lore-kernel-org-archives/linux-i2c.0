From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 v2 1/3] dt-bindings: i2c: extend existing opencore
 bindings.
Date: Tue, 7 May 2019 17:24:41 +0200
Message-ID: <20190507152441.GC25013@lunn.ch>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
 <1557242108-13580-2-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557242108-13580-2-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com, palmer@sifive.com, paul.walmsley@sifive.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> +or
> +	/*
> +	  An Opencore based I2C node in FU540-C000 chip from SiFive
> +	  This chip has a hardware erratum for broken IRQ
> +	  so it's recommended not to define interrupt in the device node
> +	*/
> +	i2c@10030000 {
> +			compatible = "sifive,i2c0","sifive,fu540-c000-i2c";

The most specific compatible comes first.

You also need to be forward thinking. The next revision of the silicon
could have the bug fixed. You can then use plain "sifive,i2c0" to
indicate just polling is needed, not bug workaround. But for that to
work, you need "sifive,fu540-c000-i2c" first.

      Andrew
