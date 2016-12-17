From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: i2c: xiic: Strange clk_prepare_enable() in xiic_i2c_remove()
Date: Sat, 17 Dec 2016 12:36:19 +0530
Message-ID: <CAKfKVtE5NC8L6gi642FhKQKvs-Lnmi4eqVkE6-9FQu=FEnno1A@mail.gmail.com>
References: <1481925285-594-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35647 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbcLQHGV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 17 Dec 2016 02:06:21 -0500
In-Reply-To: <1481925285-594-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Shubhrajyoti Datta <shubhraj@xilinx.com>, Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Sat, Dec 17, 2016 at 3:24 AM, Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> Dear Shubhrajyoti,
>
> Looking at 36ecbcab84d0 ("i2c: xiic: Implement power management")
> it is not clear why clk_prepare_enable(i2c->clk) is required in
> xiic_i2c_remove()?

834         ret = clk_prepare_enable(i2c->clk);
835         if (ret) {
836                 dev_err(&pdev->dev, "Unable to enable clock.\n");
837                 return ret;
838         }
839         xiic_deinit(i2c);
840         clk_disable_unprepare(i2c->clk);

so it is enabled and disabled after xiic_deinit.

>
> It is enabled in xiic_i2c_probe() and disabled/enabled in
> cdns_i2c_runtime_suspend()/cdns_i2c_runtime_resume().
>
> Could you please clarify the point.
>
> --
> Alexey Khoroshilov
> Linux Verification Center, ISPRAS
> web: http://linuxtesting.org
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
