From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v9 0/8] add i2c driver supported for rk3399
Date: Sat, 14 May 2016 13:30:41 +0200
Message-ID: <1649653.55gUf8lt1c@phil>
References: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Am Donnerstag, 12. Mai 2016, 15:52:58 schrieb David Wu:
> There are three points differert from others:
>  - new method to caculate i2c timings for rk3399
>  - pclk and function clk are separated at rk3399
>  - add fast-plus mode supported for rk3399

On a rk3288

Tested-by: Heiko Stuebner <heiko@sntech.de>

to make sure nothing currently working broke - and everything is running 
still fine.


Heiko
