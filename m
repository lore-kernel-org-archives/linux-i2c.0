From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 5/7] i2c: of: error message unification
Date: Fri, 21 Feb 2020 10:54:18 +0100
Message-ID: <CAMuHMdXy=B6ZjC=X12yeOjSfr5-Z6HNL4vp0vQciMsW31i-CPw@mail.gmail.com>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com> <20200220172403.26062-6-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200220172403.26062-6-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-i3c@lists.infradead.org, Kieran Bingham <kieran@ksquared.org.uk>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Luca Ceresoli <luca@lucaceresoli.net>, Jacopo Mondi <jacopo@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vladimir Zapolskiy <vz@mleia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thanks for your patch!

On Thu, Feb 20, 2020 at 6:26 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> - don't prefix the device if %pOF is provided. That information is
>   enough.

While that information is sufficient to identify the device, using a mix
of dev_*() and pr_*("... %pOF...") makes it harder to grep for relevant
information in the kernel log.  Hence I'm not convinced this is an
improvement.

> - move the prefix to pr_fmt
> - change prefix from "of_i2c" to "i2c_of" because the code was moved
>   out of the of-domain long ago
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Nevertheless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
