From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] i2c: add helpers to ease DMA handling
Date: Thu, 15 Jun 2017 22:31:51 +0200
Message-ID: <CAMuHMdVe1tBMZO9weMsf2Tj7pQ_AUeVu_X=uKbs+JbziLFQHvQ@mail.gmail.com>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com> <20170615183039.22925-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170615183039.22925-2-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Jun 15, 2017 at 8:30 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> One helper checks if DMA is suitable and optionally creates a bounce
> buffer, if not. The other function returns the bounce buffer and makes
> sure the data is properly copied back to the message.

> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -764,6 +767,68 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
>         return (msg->addr << 1) | (msg->flags & I2C_M_RD ? 1 : 0);
>  }
>
> +/**
> + * i2c_check_msg_for_dma - check if a message is suitable for DMA
> + * @msg: the message to be checked
> + * @threshold: the amount of byte from which using DMA makes sense
> + * @ptr_for_bounce_buf: if not NULL, a bounce buffer will be attached to this
> + *                     ptr, if needed. The bounce buffer must be freed by the
> + *                     caller using i2c_release_bounce_buf().
> + *
> + * Return: -ERANGE if message is smaller than threshold
> + *        -EFAULT if message buffer is not DMA capable and no bounce buffer
> + *                was requested
> + *        -ENOMEM if a bounce buffer could not be created
> + *        0 if message is suitable for DMA
> + *
> + * Note: This function should only be called from process context! It uses
> + * helper functions which work on the 'current' task.
> + */
> +static inline int i2c_check_msg_for_dma(struct i2c_msg *msg, unsigned int threshold,
> +                                       u8 **ptr_for_bounce_buf)

__must_check?

Isn't this function a bit large to be inlined?

> +/**
> + * i2c_release_bounce_buf - copy data back from bounce buffer and release it
> + * @msg: the message to be copied back to
> + * @bounce_buf: the bounce buffer obtained from i2c_check_msg_for_dma().
> + *             May be NULL.
> + */
> +static inline void i2c_release_bounce_buf(struct i2c_msg *msg, u8 *bounce_buf)

This one is smaller.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
