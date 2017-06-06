From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue, 6 Jun 2017 12:37:33 +0200
Message-ID: <CAMuHMdWv9hBtYO_Xqwx_A64anC=4d3o_EE7FOSbknPYb-N5X8g@mail.gmail.com>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
 <20170606092034.1516-3-wsa+renesas@sang-engineering.com> <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
 <20170606102447.cftuyhtx7zo2fe2g@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170606102447.cftuyhtx7zo2fe2g@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, Jun 6, 2017 at 12:24 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > +Therefore, it is *not* mandatory that the buffer of an i2c message is DMA safe.
>> > +It does not seem reasonable to apply additional burdens when the feature is so
>> > +rarely used. However, it is recommended to use a DMA-safe buffer, if your
>> > +message size is likely applicable for DMA (FIXME: > 8 byte?).
>>
>> So you expect drivers to fall back to PIO automatically if the buffer is
>> not DMA safe.  Sounds good to me.
>
> Yes, I strongly recommend that. Otherwise, drivers can always deal with
> bounce buffers on their own.
>
>> However, your check for a DMA-capable buffer is invoked only if
>> CONFIG_DMA_API_DEBUG is enabled:
>
> is *NOT* enabled!

Oops ;-)

>>     #if !defined(CONFIG_DMA_API_DEBUG)
>>            if (!virt_addr_valid(msg->buf) || object_is_on_stack(msg->buf)) {
>>                    pr_debug("msg buffer to 0x%04x might not be DMA capable\n",
>>                             msg->addr);
>>                    return -EFAULT;
>>            }
>>     #endif
>>
>
> The #if block is there because DMA_API_DEBUG does a lot more, but if the
> check in the helper is enabled, the core will fall back to PIO and you
> won't get the additional info from DMA_API_DEBUG.
>
> I think this needs a comment :)
>
> Now OK?

So it won't fall back to PIO if CONFIG_DMA_API_DEBUG is enabled?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
