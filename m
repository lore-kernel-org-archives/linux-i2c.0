From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/5] i2c: pca-platform: use dev_warn/dev_info instead
 of printk
Date: Wed, 28 Jun 2017 12:28:01 +0300
Message-ID: <CAHp75Ve-JFBMofDwoKKENL-AggXqMpKd7CbRZwJuPKWML13apA@mail.gmail.com>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz> <20170626004434.2757-6-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35883 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdF1J2D (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 05:28:03 -0400
In-Reply-To: <20170626004434.2757-6-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 26, 2017 at 3:44 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

On the first glance I have thought this is _the_ only patch that
doesn't make my eyes hurt.

Not a chance! Where is the commit message?

Code below though looks fine.

> @@ -107,8 +107,8 @@ static int i2c_pca_pf_waitforcompletion(void *pd)
>  static void i2c_pca_pf_dummyreset(void *pd)
>  {
>         struct i2c_pca_pf_data *i2c = pd;
> -       printk(KERN_WARNING "%s: No reset-pin found. Chip may get stuck!\n",
> -               i2c->adap.name);
> +
> +       dev_warn(&i2c->adap.dev, "No reset-pin found. Chip may get stuck!\n");
>  }
>
>  static void i2c_pca_pf_resetchip(void *pd)
> @@ -236,7 +236,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, i2c);
>
> -       printk(KERN_INFO "%s registered.\n", i2c->adap.name);
> +       dev_info(&pdev->dev, "registered.\n");
>
>         return 0;
>  }
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
