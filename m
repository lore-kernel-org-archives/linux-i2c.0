From: Max Schwarz <max.schwarz@online.de>
Subject: Re: [PATCH] i2c-rk3x: move setup to the earlier subsys initcall
Date: Mon, 22 Sep 2014 18:20:20 +0200
Message-ID: <2856441.ivW6yi69vh@xq-nb>
References: <1411370675-27866-1-git-send-email-zyw@rock-chips.com> <7192455.FveG5nGWsJ@xq-nb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7192455.FveG5nGWsJ@xq-nb>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Zhong <zyw@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Chris,

> > +subsys_initcall(rk3x_i2c_init_driver);
> > +module_exit(rk3x_i2c_exit_driver);
> 
> This means that the driver cannot be used as a loadable module any more,
> right?
> 
> In that case, you should probably turn the tristate option in Kconfig into a
> bool.

I'm sorry, I see now that subsys_initcall() gets mapped to module_init() if 
the driver is built as a loadable module. Everything is fine ;-)

Acked-By: Max Schwarz <max.schwarz@online.de>

Cheers,
  Max
