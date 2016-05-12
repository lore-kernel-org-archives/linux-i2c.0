From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v8 8/8] i2c: rk3x: support fast-mode plus for rk3399
Date: Thu, 12 May 2016 10:30:25 +0200
Message-ID: <6806722.VBDbziL6YI@phil>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com> <5153288.jNhUuzGC3g@phil> <CAD=FV=VzQ8PRokgAaTV00L31mcXFEzBG8c1NB4+Rqyx75hwwDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VzQ8PRokgAaTV00L31mcXFEzBG8c1NB4+Rqyx75hwwDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: David Wu <david.wu@rock-chips.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Am Mittwoch, 11. Mai 2016, 16:41:54 schrieb Doug Anderson:
> Heiko,
> 
> On Wed, May 11, 2016 at 2:09 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Additionally, the i2c-noob in me would wish for a short sentence on
> > where
> > the timing values come from (measured, somewhere in the TRM I didn't
> > find or something completely different).
> 
> If you search for "UM10204" you'll find the first link is
> <http://www.nxp.com/documents/user_manual/UM10204.pdf>.  That appears
> to be the official standard.  At least that's what
> <http://www.i2c-bus.org/fast-mode-plus/> says (though they have an old
> link).

I did find that document yesterday, but was to blind and somehow only saw the 
separate table for highspeed-timings. On a closer look, I now also found the 
timing-table for the other modes [due to the bigger font-size used there? 
;-) ]
