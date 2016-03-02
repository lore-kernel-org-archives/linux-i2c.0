From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: rcar: don't open code of_device_get_match_data()
Date: Wed, 2 Mar 2016 10:06:51 +0100
Message-ID: <CAMuHMdXd5JYKSAd1D3=gmSQFfCOeYzxzOvT6EDuGY+t1y4+_=w@mail.gmail.com>
References: <1456850216-8197-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37527 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbcCBJGw (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Mar 2016 04:06:52 -0500
In-Reply-To: <1456850216-8197-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>

On Tue, Mar 1, 2016 at 5:36 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This change will also make Coverity happy by avoiding a theoretical NULL
> pointer dereference; yet another reason is to use the above helper function
> to tighten the code and make it more readable.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
