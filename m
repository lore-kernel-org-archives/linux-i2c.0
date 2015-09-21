From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] i2c: tegra: drop duplicated code for assigning algo
Date: Mon, 21 Sep 2015 11:20:03 +0800
Message-ID: <CAGsJ_4zT-AFOvvFPo3U9d4ijQsjTD++QS3KXsOhx+-mMPkJ1HA@mail.gmail.com>
References: <1441595335-31672-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34754 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbbIUDUY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 20 Sep 2015 23:20:24 -0400
Received: by lahg1 with SMTP id g1so60388559lah.1
        for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2015 20:20:22 -0700 (PDT)
In-Reply-To: <1441595335-31672-1-git-send-email-21cnbao@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
Cc: Barry Song <21cnbao@gmail.com>, Donglin Peng <pengdonglin137@163.com>

ping...

2015-09-07 11:08 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> This code is repeated in probe:
> i2c_dev->adapter.algo = &tegra_i2c_algo;
>
> Cc: Donglin Peng <pengdonglin137@163.com>
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 78a3668..9ab720b 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -825,7 +825,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>         i2c_dev->adapter.class = I2C_CLASS_DEPRECATED;
>         strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
>                 sizeof(i2c_dev->adapter.name));
> -       i2c_dev->adapter.algo = &tegra_i2c_algo;
>         i2c_dev->adapter.dev.parent = &pdev->dev;
>         i2c_dev->adapter.nr = pdev->id;
>         i2c_dev->adapter.dev.of_node = pdev->dev.of_node;
> --
> 1.9.1
>
