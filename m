From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v8 8/8] i2c: rk3x: support fast-mode plus for rk3399
Date: Wed, 11 May 2016 16:41:54 -0700
Message-ID: <CAD=FV=VzQ8PRokgAaTV00L31mcXFEzBG8c1NB4+Rqyx75hwwDg@mail.gmail.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
	<1462908794-27333-1-git-send-email-david.wu@rock-chips.com>
	<5153288.jNhUuzGC3g@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35565 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbcEKXlz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 19:41:55 -0400
Received: by mail-vk0-f47.google.com with SMTP id f66so77507039vkh.2
        for <linux-i2c@vger.kernel.org>; Wed, 11 May 2016 16:41:55 -0700 (PDT)
In-Reply-To: <5153288.jNhUuzGC3g@phil>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: David Wu <david.wu@rock-chips.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Heiko,

On Wed, May 11, 2016 at 2:09 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Additionally, the i2c-noob in me would wish for a short sentence on where
> the timing values come from (measured, somewhere in the TRM I didn't find or
> something completely different).

If you search for "UM10204" you'll find the first link is
<http://www.nxp.com/documents/user_manual/UM10204.pdf>.  That appears
to be the official standard.  At least that's what
<http://www.i2c-bus.org/fast-mode-plus/> says (though they have an old
link).

Agree that it wouldn't hurt to mention that in the commit message.

-Doug
