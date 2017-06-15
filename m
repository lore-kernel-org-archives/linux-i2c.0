From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Thu, 15 Jun 2017 22:30:04 +0200
Message-ID: <CAMuHMdVww1X6YDKxsCFtGG5W8qhvd3mP4GZbiCavqnVP09RQ1Q@mail.gmail.com>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com> <20170615183039.22925-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170615183039.22925-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Jun 15, 2017 at 8:30 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> --- /dev/null
> +++ b/Documentation/i2c/DMA-considerations
> @@ -0,0 +1,37 @@
> +Linux I2C and DMA
> +-----------------
> +
> +Given that I2C is a low-speed bus where largely small messages are transferred,
> +it is not considered a prime user of DMA access. At this time of writing, only
> +10% of I2C bus master drivers have DMA support implemented. And the vast
> +majority of transactions are so small that setting up DMA for it will likely
> +add more overhead than a plain PIO transfer.
> +
> +Therefore, it is *not* mandatory that the buffer of an I2C message is DMA safe.
> +It does not seem reasonable to apply additional burdens when the feature is so
> +rarely used. However, it is recommended to use a DMA-safe buffer if your
> +message size is likely applicable for DMA. Most drivers have this threshold
> +around 8 bytes. As of today, this is mostly an educated guess, however.
> +
> +To support this scenario, drivers wishing to implement DMA can use helper
> +functions from the I2C core. One checks if a message is DMA capable in terms of
> +size and memory type. It can optionally also create a bounce buffer:
> +
> +       i2c_check_msg_for_dma(msg, threshold, &bounce_buf);

Obviously the return value must be checked before proceeding.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
