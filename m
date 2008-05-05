From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] Fix of_i2c include for module compilation
Date: Mon, 5 May 2008 14:15:14 +1000
Message-ID: <18462.35282.374180.770237@cargo.ozlabs.ibm.com>
References: <481C5DD0.5090503@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754084AbYEEEYy@vger.kernel.org>
In-Reply-To: <481C5DD0.5090503@scram.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jochen Friedrich <jochen@scram.de>
Cc: Kumar Gala <galak@kernel.crashing.org>, Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>, Jon Smirl <jonsmirl@gmail.com>, Laurent Pinchart <laurentp@cse-semaphore.com>, David Miller <davem@davemloft.net>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-i2c@vger.kernel.org

Jochen Friedrich writes:

> -#ifdef CONFIG_OF_I2C
> +#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
>  
>  void of_register_i2c_devices(struct i2c_adapter *adap,
>  			     struct device_node *adap_node);

Why do we have that ifdef there at all?  There's only that one
external declaration within it, so the #ifdef and #endif could just be
removed.  If the ifdef hadn't been there in the first place we
wouldn't have had this problem.

Paul.
