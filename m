From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] i2c: rcar: use proper device with dma_mapping_error
Date: Thu, 25 Aug 2016 09:59:49 +0200
Message-ID: <CAMuHMdVUddscsJ-JzpEV344GD8o+OuCYKv6LkSXW-X7+EW6mow@mail.gmail.com>
References: <20160824091929.2082-1-wsa+renesas@sang-engineering.com> <20160824091929.2082-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33447 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932707AbcHYH7u (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 25 Aug 2016 03:59:50 -0400
In-Reply-To: <20160824091929.2082-2-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>

On Wed, Aug 24, 2016 at 11:19 AM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We must use the same device we used for mapping.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
