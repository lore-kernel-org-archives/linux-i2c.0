From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] i2c: rcar: make sure clocks are on when doing hw init
Date: Fri, 30 Oct 2015 09:16:40 +0100
Message-ID: <CAMuHMdV0_ej3z1EQ=1Q+XRc53CX5H=8Oa3sNjUwkfO62KfTpHA@mail.gmail.com>
References: <1446158791-29682-1-git-send-email-wsa@the-dreams.de>
	<1726774.W1OrN54TP1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1726774.W1OrN54TP1@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-i2c@vger.kernel.org

Hi Laurent,

On Fri, Oct 30, 2015 at 5:35 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> [    9.641533] Unable to handle kernel paging request at virtual address
> ffffffff
> [    9.648927] pgd = eb2adf40
> [    9.651695] [ffffffff] *pgd=80000040007003, *pmd=6bfde003, *pte=00000000
> [    9.658579] Internal error: Oops: a07 [#1] SMP ARM
> [    9.663475] Modules linked in: rcar_thermal adv7180(+) phy_rcar_gen2
> soundcore udc_core
> [    9.671719] CPU: 0 PID: 552 Comm: udevd Not tainted 4.3.0-rc7-07332-
> gfb990fd3ff96 #114
> [    9.679811] Hardware name: Generic R8A7791 (Flattened Device Tree)
> [    9.686125] task: eb11f400 ti: ea92e000 task.ti: ea92e000
> [    9.691653] PC is at rcar_i2c_irq+0xd4/0x3e4
> [    9.696018] LR is at rcar_i2c_write+0x28/0x38
> [    9.700471] pc : [<c0324588>]    lr : [<c0323cf0>]    psr: 80000193

> This only occurred once, I don't know how to reproduce it.

Do you still have the kernel binary, so you can see where exactly the crash
happened?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
