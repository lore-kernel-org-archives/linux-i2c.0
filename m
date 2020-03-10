From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/3] i2c: qcom-geni: Let firmware specify irq trigger
 flags
Date: Tue, 10 Mar 2020 12:35:25 -0700
Message-ID: <20200310193525.GM264362@yoga>
References: <20200310154358.39367-1-swboyd@chromium.org>
 <20200310154358.39367-2-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46094 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgCJTf3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Mar 2020 15:35:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id w12so5830386pll.13
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2020 12:35:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200310154358.39367-2-swboyd@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Brendan Higgins <brendanhiggins@google.com>

On Tue 10 Mar 08:43 PDT 2020, Stephen Boyd wrote:

> We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> should take care of this for us. Just use 0 instead so that we use the
> flags from the firmware. Also, remove specify dev_name() for the irq
> name so that we can get better information in /proc/interrupts about
> which device is generating interrupts.
> 
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 17abf60c94ae..4efca130035a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -549,8 +549,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	init_completion(&gi2c->done);
>  	spin_lock_init(&gi2c->lock);
>  	platform_set_drvdata(pdev, gi2c);
> -	ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq,
> -			       IRQF_TRIGGER_HIGH, "i2c_geni", gi2c);
> +	ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq, 0,
> +			       dev_name(&pdev->dev), gi2c);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Request_irq failed:%d: err:%d\n",
>  			gi2c->irq, ret);
> -- 
> Sent by a computer, using git, on the internet
> 
