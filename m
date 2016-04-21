From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] i2c: rk3x: add i2c support for rk3399 soc
Date: Fri, 22 Apr 2016 01:00:08 +0300
Message-ID: <CAHp75VdWz2sgWmBW30Jb5D4YCgUyM-LQQxzmGZ_3uW=iKUuKKQ@mail.gmail.com>
References: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
	<1461074137-23899-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33531 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbcDUWAJ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Apr 2016 18:00:09 -0400
In-Reply-To: <1461074137-23899-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Doug Anderson <dianders@chromium.org>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris Zhong <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Wu <wdc@rock-chips.com>

On Tue, Apr 19, 2016 at 4:55 PM, David Wu <david.wu@rock-chips.com> wrote:
> From: David Wu <wdc@rock-chips.com>
>
> - new method to caculate i2c timings for rk3399:
>   There was an timing issue about "repeated start" time at the I2C
>   controller of version0, controller appears to drop SDA at .875x (7/8)
>   programmed clk high. On version 1 of the controller, the rule(.875x)
>   isn't enough to meet tSU;STA
>   requirements on 100k's Standard-mode. To resolve this issue,
>   sda_update_config, start_setup_config and stop_setup_config for I2C
>   timing information are added, new rules are designed to calculate
>   the timing information at new v1.
> - pclk and function clk are separated at rk3399.
> - support i2c highspeed mode: 1.7MHz for rk3399
>

Remove redundant parens in cases like
1. x * (a->b)
2. x = (a + b);

Don't touch pieces of code that are not related (you removed one empty
line without any reason).

-- 
With Best Regards,
Andy Shevchenko
