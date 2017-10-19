From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] irqchip/aspeed-i2c-ic: Fix return value check in aspeed_i2c_ic_of_init()
Date: Wed, 18 Oct 2017 18:01:27 -0700
Message-ID: <CAFd5g46PbfU1OTVT7S5WsYUXt6itqRzf+6uU0ti6z+CAY0atNw@mail.gmail.com>
References: <1507719023-127618-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:49844 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdJSBB3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 21:01:29 -0400
Received: by mail-qk0-f196.google.com with SMTP id q83so8537254qke.6
        for <linux-i2c@vger.kernel.org>; Wed, 18 Oct 2017 18:01:28 -0700 (PDT)
In-Reply-To: <1507719023-127618-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Joel Stanley <joel@jms.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On Wed, Oct 11, 2017 at 3:50 AM, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> In case of error, the function of_iomap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test..
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/irqchip/irq-aspeed-i2c-ic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
> index 815b88d..f20200a 100644
> --- a/drivers/irqchip/irq-aspeed-i2c-ic.c
> +++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
> @@ -76,8 +76,8 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
>                 return -ENOMEM;
>
>         i2c_ic->base = of_iomap(node, 0);
> -       if (IS_ERR(i2c_ic->base)) {
> -               ret = PTR_ERR(i2c_ic->base);
> +       if (!i2c_ic->base) {
> +               ret = -ENOMEM;
>                 goto err_free_ic;
>         }
>
>
>
>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
