From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: riic, sh_mobile, rcar: Use ARCH_RENESAS
Date: Mon, 22 Feb 2016 14:44:34 +0100
Message-ID: <CAMuHMdV7XKdCYoJMYzv8zdUgiQrzWFtzVE2NuOY6Sj=6dnD-dg@mail.gmail.com>
References: <1456103719-10818-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33419 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbcBVNof (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 22 Feb 2016 08:44:35 -0500
In-Reply-To: <1456103719-10818-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

On Mon, Feb 22, 2016 at 2:15 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
