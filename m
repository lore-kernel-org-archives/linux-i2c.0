From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [Patch v1] i2c: imx7ulp: add i.MX7ULP i2c controller bus driver
Date: Tue, 15 Mar 2016 14:42:09 +0200
Message-ID: <56E80321.6090105@mentor.com>
References: <1458035482-14905-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:56770 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbcCOMmO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 08:42:14 -0400
In-Reply-To: <1458035482-14905-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com

Hello,

On 15.03.2016 11:51, Gao Pan wrote:
> Add i.MX7ULP i2c bus driver which can continue operating
> in stop modes provided an appropriate clock is available.
> 
> It is also designed for low CPU overhead with DMA offloading
> of FIFO register accesses.
> 
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> ---

[snip]

> +
> +static int i2c_imx7ulp_start(struct imx7ulp_i2c_struct *i2c_imx7ulp)
> +{
> +	int ret;
> +	unsigned int temp;
> +
> +	dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s>\n", __func__);
> +
> +	ret = clk_prepare_enable(i2c_imx7ulp->bus_clk);
> +	if (ret) {
> +		dev_err(&i2c_imx7ulp->adapter.dev,
> +			"can't enable I2C bus clock, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(i2c_imx7ulp->per_clk);
> +	if (ret) {
> +		dev_err(&i2c_imx7ulp->adapter.dev,
> +			"can't enable I2C peripheral clock, ret=%d\n", ret);
> +		return ret;

Leaked prepared/enabled i2c_imx7ulp->bus_clk clock on error path.

> +	}
> +

--
With best wishes,
Vladimir
