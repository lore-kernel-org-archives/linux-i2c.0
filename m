From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Date: Thu, 28 Mar 2019 09:10:02 +0100
Message-ID: <CAMuHMdVHWNcrjXGSPaK9XTTuGEaPPpwp6gzy8XD10_TYNF1PJQ@mail.gmail.com>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Mar 27, 2019 at 10:13 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> added in_atomic() to the I2C core. However, the use of in_atomic()
> outside of core kernel code is discouraged and was already[1] when this
> code was added in early 2008. The above commit was a preparation for
> b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit message says
> explicitly it was added "for cases where I2C transactions have to occur
> at times interrups are disabled". So, the intention was 'disabled
> interrupts'. This matches the use cases for atomic I2C transfers I have
> seen so far: very late communication (mostly to a PMIC) to powerdown or
> reboot the system. For those cases, interrupts are disabled then. It
> doesn't seem that in_atomic() adds value.
>
> Note that only ~10 out of ~120 bus master drivers support atomic
> transfers, mostly by polling always when no irq is supplied. A generic
> I2C client driver cannot assume support for atomic transfers. This is
> currently a platform-dependent corner case.
>
> The I2C core will soon gain an extra callback into bus drivers
> especially for atomic transfers to make them more generic. The code
> deciding which transfer to use (atomic/non-atomic) should mimic the
> behaviour which locking to use (trylock/lock). Because I don't want to
> add more in_atomic() to the I2C core, this patch simply removes it.
>
> [1] https://lwn.net/Articles/274695/
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

LGTM, so:
Ackeded-by: Geert Uytterhoeven <geert+renesas@glider.be>

But please wait for Peter and/or Frederic to give their fiat, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
