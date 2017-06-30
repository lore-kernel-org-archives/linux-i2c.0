From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/6] i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
Date: Fri, 30 Jun 2017 11:40:51 +0300
Message-ID: <CAHp75VejpMcgsyncpbFnDXbwYcwdD1BPqy53s98xcNmfAnJTFw@mail.gmail.com>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz> <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32987 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdF3Ikx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 30 Jun 2017 04:40:53 -0400
In-Reply-To: <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 30, 2017 at 3:54 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Rather than returning -ENODEV if i2c_pca_add_numbered_bus() fails,
> propagate the error to aid debugging.
>

+ Suggested-by ?

You or Wolfram can use below if you agree on it (I'm fine either way):

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

> ---
>  drivers/i2c/busses/i2c-pca-platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
> index daccef6865e8..853a2abedb05 100644
> --- a/drivers/i2c/busses/i2c-pca-platform.c
> +++ b/drivers/i2c/busses/i2c-pca-platform.c
> @@ -232,9 +232,9 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
>                         return ret;
>         }
>
> -       if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
> -               return -ENODEV;
> -       }
> +       ret = i2c_pca_add_numbered_bus(&i2c->adap);
> +       if (ret)
> +               return ret;
>
>         platform_set_drvdata(pdev, i2c);
>
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
