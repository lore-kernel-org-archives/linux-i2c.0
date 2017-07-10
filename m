From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware-slave: constify i2c_algorithm structure
Date: Mon, 10 Jul 2017 13:26:32 +0300
Message-ID: <1499682392.22624.320.camel@linux.intel.com>
References: <20170709213517.GA31846@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28073 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbdGJK0g (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 10 Jul 2017 06:26:36 -0400
In-Reply-To: <20170709213517.GA31846@embeddedgus>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2017-07-09 at 16:35 -0500, Gustavo A. R. Silva wrote:
> Check for i2c_algorithm structures that are only stored in
> the algo field of an i2c_adapter structure. This field is
> declared const, so i2c_algorithm structures that have this
> property can be declared as const also.
> 

> This issue was identified using Coccinelle and the following
> semantic patch:
> 
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct i2c_algorithm i@p = { ... };
> 
> @ok@
> identifier r.i;
> struct i2c_adapter e;
> position p;
> @@
> e.algo = &i@p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> @@
> i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct i2c_algorithm i = { ... };

I don't think it's a good idea to copy'n'paste patch to each change
where you fixing the issue. Can you create a github repository of the
coccinelle recipes and give just a link?

Other than that, I'm fine with the change as long as it compiles without
troubles (had seen recently similar patch that has been sent without
actual testing).

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/i2c/busses/i2c-designware-slave.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-slave.c
> b/drivers/i2c/busses/i2c-designware-slave.c
> index 4012c74..e62799e 100644
> --- a/drivers/i2c/busses/i2c-designware-slave.c
> +++ b/drivers/i2c/busses/i2c-designware-slave.c
> @@ -344,7 +344,7 @@ static irqreturn_t i2c_dw_isr_slave(int this_irq,
> void *dev_id)
>  	return IRQ_RETVAL(ret);
>  }
>  
> -static struct i2c_algorithm i2c_dw_algo = {
> +static const struct i2c_algorithm i2c_dw_algo = {
>  	.functionality = i2c_dw_func,
>  	.reg_slave = i2c_dw_reg_slave,
>  	.unreg_slave = i2c_dw_unreg_slave,

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
