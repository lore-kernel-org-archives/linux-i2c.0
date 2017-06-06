From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue, 6 Jun 2017 12:03:19 +0200
Message-ID: <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com> <20170606092034.1516-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170606092034.1516-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, Jun 6, 2017 at 11:20 AM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> --- /dev/null
> +++ b/Documentation/i2c/DMA-considerations
> @@ -0,0 +1,28 @@
> +Linux I2C and DMA
> +-----------------
> +
> +Given that I2C is a low-speed bus where largely small messages are transferred,
> +it is not considered a prime user of DMA access. At this time of writing, only
> +10% of I2C bus master drivers have DMA support implemented. And the vast
> +majority of transactions are so small that setting up DMA for it will likely
> +add more overhead than a plain PIO transfer.
> +
> +Therefore, it is *not* mandatory that the buffer of an i2c message is DMA safe.
> +It does not seem reasonable to apply additional burdens when the feature is so
> +rarely used. However, it is recommended to use a DMA-safe buffer, if your
> +message size is likely applicable for DMA (FIXME: > 8 byte?).

So you expect drivers to fall back to PIO automatically if the buffer is
not DMA safe.  Sounds good to me.

> +To support this, drivers wishing to implement DMA can use a helper function
> +checking if the size is suitable for DMA or if the buffer is DMA capable:
> +
> +       int i2c_check_msg_for_dma(msg, dma_threshold);
> +
> +Please check its in kernel documentation for details.
> +
> +It should be further noted that bounce buffer handling is left to be handled on
> +driver level because details like alignment requirements are best known on that
> +level.
> +
> +If you plan to use DMA with I2C (or with any other bus, actually) make sure you
> +have CONFIG_DMA_API_DEBUG enabled during development. It can help you find
> +various issues which can be complex to debug otherwise.

However, your check for a DMA-capable buffer is invoked only if
CONFIG_DMA_API_DEBUG is enabled:

    #if !defined(CONFIG_DMA_API_DEBUG)
           if (!virt_addr_valid(msg->buf) || object_is_on_stack(msg->buf)) {
                   pr_debug("msg buffer to 0x%04x might not be DMA capable\n",
                            msg->addr);
                   return -EFAULT;
           }
    #endif

So the system will work fine if CONFIG_DMA_API_DEBUG is enabled, and may fail
miserably in a production kernel?

Furthermore, pr_debug() messages are not printed by default, so the developer
who did enable CONFIG_DMA_API_DEBUG may not have noticed at all?

If you want to use i2c_check_msg_for_dma() as a generic helper to verify DMA
requirements, and decide when to fall back to PIO, I think it should always do
the buffer check.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
