From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [5/7] i2c-designware: enable/disable the controller properly
Date: Tue, 9 Apr 2013 11:09:14 +0200
Message-ID: <20130409090914.GD28509@the-dreams.de>
References: <1363867800-23861-5-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363867800-23861-5-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Jean Delvare <khali@linux-fr.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Ruppert <christian.ruppert@abilis.com>
List-Id: linux-i2c@vger.kernel.org


> +static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
> +{
> +	int timeout = 100;
> +
> +	do {
> +		dw_writel(dev, enable, DW_IC_ENABLE);
> +		if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable)
> +			return;
> +
> +		usleep_range(25, 250);

This would wait 25ms max. Is there a timeout value specified in the docs?

> +	} while (timeout-- > 0);

while (timeout--)?
