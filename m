From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH i2c/for-next] i2c: sh_mobile: document support for r8a7796
 (R-Car M3-W)
Date: Thu, 26 Jan 2017 10:04:12 +0100
Message-ID: <CAMuHMdV-WGVf+fk3AT-x3zMVf+==g_myuGBSvKmOxi8CqBUHJQ@mail.gmail.com>
References: <1485420451-11752-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33319 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdAZJEO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 26 Jan 2017 04:04:14 -0500
In-Reply-To: <1485420451-11752-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Thu, Jan 26, 2017 at 9:47 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Explicitly list per-SoC binding for r8a7796. No driver change
> is required as the initialisation sequence is currently the same
> as for the R-Car Gen3 fallback binding.
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
