From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] i2c: sh_mobile: List rmobile fallback compatibility last
Date: Wed, 7 Dec 2016 13:16:58 +0100
Message-ID: <CAMuHMdX0ONE9SR=av5SpfpTf7psUsEz+SNsSTooJJ91eFyHCSA@mail.gmail.com>
References: <1481106689-22312-1-git-send-email-horms+renesas@verge.net.au> <1481107176-32409-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33758 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbcLGMRA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Dec 2016 07:17:00 -0500
In-Reply-To: <1481107176-32409-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Dec 7, 2016 at 11:39 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Improve readability by listing the rmobile fallback compatibility string
> after the more-specific compatibility strings they provide a fallback for.
>
> This does not effect run-time behaviour as it is the order in the DTB that
> determines which compatibility string is used.
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
