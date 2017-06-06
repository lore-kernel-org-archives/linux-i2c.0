From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue, 6 Jun 2017 17:29:26 +0200
Message-ID: <CAMuHMdXxRKxk1G5uK5rc5jym2FE=Mroaj5nuFdVCrmU3PPYS4Q@mail.gmail.com>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
 <20170606092034.1516-3-wsa+renesas@sang-engineering.com> <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
 <20170606102447.cftuyhtx7zo2fe2g@ninjato> <CAMuHMdWv9hBtYO_Xqwx_A64anC=4d3o_EE7FOSbknPYb-N5X8g@mail.gmail.com>
 <20170606105431.bm7jiclz2k7h7lj2@ninjato> <CAMuHMdVQmFqC3pZh8BcNROnrdqQ+gx+4Mg40Y1AY=WXE9i83wQ@mail.gmail.com>
 <20170606112348.GA3275@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35789 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFFP32 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 6 Jun 2017 11:29:28 -0400
In-Reply-To: <20170606112348.GA3275@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Wolfram,

On Tue, Jun 6, 2017 at 1:23 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> I have it enabled all the time. So my devices may stop working...
>
> If you have enabled it all the time, then there won't be a difference
> from now. Or?
>
> That also shows how rarely I2C DMA transfers are triggered from within
> the kernel :)

... how rarely i2c DMA transfers from possibly unsafe buffers...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
