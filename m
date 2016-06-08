From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v10 0/8] add i2c driver supported for rk3399
Date: Wed, 08 Jun 2016 17:47:38 +0200
Message-ID: <2239664.BKqQWGCl8U@diego>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:57336 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbcFHPr7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 8 Jun 2016 11:47:59 -0400
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: David Wu <david.wu@rock-chips.com>, robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wolfram,

Am Montag, 16. Mai 2016, 21:57:35 schrieb David Wu:
> There are three points differert from others:
>  - new method to caculate i2c timings for rk3399
>  - pclk and function clk are separated at rk3399
>  - add fast-plus mode supported for rk3399

this series looks pretty nice now and it seems most everybody is happy with it 
by now. Do you still have it in your inbox to look at, or should David resend 
it again?


Heiko

> David Wu (8):
>   i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
>   i2c: rk3x: use struct "rk3x_i2c_calced_timings"
>   i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
>   i2c: rk3x: Change SoC data to not use array
>   i2c: rk3x: Move spec timing data to "static const" structs
>   dt-bindings: i2c: rk3x: add support for rk3399
>   i2c: rk3x: add i2c support for rk3399 soc
>   i2c: rk3x: support fast-mode plus for rk3399
> 
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-
>  drivers/i2c/busses/i2c-rk3x.c                      | 498
> +++++++++++++++++---- 2 files changed, 434 insertions(+), 80 deletions(-)
