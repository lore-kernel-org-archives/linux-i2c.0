From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 3/3] i2c: qcom-geni: Drop of_platform.h include
Date: Tue, 10 Mar 2020 12:42:11 -0700
Message-ID: <20200310194211.GO264362@yoga>
References: <20200310154358.39367-1-swboyd@chromium.org>
 <20200310154358.39367-4-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42359 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgCJTmP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Mar 2020 15:42:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so6766641pgs.9
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2020 12:42:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200310154358.39367-4-swboyd@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Brendan Higgins <brendanhiggins@google.com>

On Tue 10 Mar 08:43 PDT 2020, Stephen Boyd wrote:

> This driver doesn't call any DT platform functions like of_platform_*().
> Remove the include as it isn't used.
> 
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 2f5fb2e83f95..18d1e4fd4cf3 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -10,7 +10,6 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
> -- 
> Sent by a computer, using git, on the internet
> 
