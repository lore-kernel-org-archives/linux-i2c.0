From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH3/7] i2c: OF helpers for the i2c API
Date: Fri, 11 Apr 2008 10:43:06 -0700 (PDT)
Message-ID: <20080411.104306.93639801.davem@davemloft.net>
References: <47FF710D.2040208@scram.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761932AbYDKRnT@vger.kernel.org>
In-Reply-To: <47FF710D.2040208@scram.de>
Sender: linux-kernel-owner@vger.kernel.org
To: jochen@scram.de
Cc: galak@kernel.crashing.org, khali@linux-fr.org, scottwood@freescale.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, jonsmirl@gmail.com, laurentp@cse-semaphore.com
List-Id: linux-i2c@vger.kernel.org

From: Jochen Friedrich <jochen@scram.de>
Date: Fri, 11 Apr 2008 16:09:17 +0200

> +
> +config OF_I2C
> +	def_bool y
> +	depends on OF && PPC_OF && I2C
> +	help
> +	  OpenFirmware I2C accessors

I wouldn't mind trying to use this infrastructure on
sparc64, and I don't see any powerpc specific interfaces
being invoked, so if you could remove the PPC_OF
requirement I'd appreciate it.

Thanks.
