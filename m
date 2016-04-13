From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFT][PATCH 2/2] i2c: sun6i-p2wi: Prevent potential division by
 zero
Date: Wed, 13 Apr 2016 09:49:18 +0200
Message-ID: <20160413094918.1f1ca765@bbrezillon>
References: <1460508570.6009.1.camel@ingics.com>
	<1460508870.6009.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59031 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757875AbcDMHta (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 13 Apr 2016 03:49:30 -0400
In-Reply-To: <1460508870.6009.3.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-i2c@vger.kernel.org

On Wed, 13 Apr 2016 08:54:30 +0800
Axel Lin <axel.lin@ingics.com> wrote:

> Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. The
> variable set here is later used as a divisor.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/i2c/busses/i2c-sun6i-p2wi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> index 7668e2e..6448291 100644
> --- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
> +++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> @@ -202,6 +202,11 @@ static int p2wi_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	if (clk_freq == 0) {
> +		dev_err(dev, "clock-frequency is set to 0 in DT\n");
> +		return -EINVAL;
> +	}
> +
>  	if (of_get_child_count(np) > 1) {
>  		dev_err(dev, "P2WI only supports one slave device\n");
>  		return -EINVAL;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
