From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 0/7] i2c: of: reserve unknown and ancillary addresses
Date: Fri, 21 Feb 2020 11:15:04 +0100
Message-ID: <CAMuHMdX+SJPTvDqKDwD_3DaAxDT3KcEbcjLNjj4JsbcpRwd92w@mail.gmail.com>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-i3c@lists.infradead.org, Kieran Bingham <kieran@ksquared.org.uk>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Luca Ceresoli <luca@lucaceresoli.net>, Jacopo Mondi <jacopo@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vladimir Zapolskiy <vz@mleia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Feb 20, 2020 at 6:26 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> One outcome of my dynamic address assignment RFC series[1] was that we
> need a way to describe an I2C bus in DT fully. This includes unknown
> devices and devices requiring multiple addresses. This series implements
> that.
>
> Patches 1+2 do some preparational refactoring. After patch 3, we can
> have child nodes with an address, but no compatible. Those addresses
> will be marked busy now. They are handled by the dummy driver as well,
> but named "reserved" instead of dummy. Patches 4+5 are again some
> preparational refactoring. After patch 6, all addresses in a 'reg' array
> are now blocked by the I2C core, also using the dummy driver but named
> "reserved". So, we can have something like this:
>
>         dummy@13 {

Hence should that be "reserved@13"?

>                reg = <0x13>, <0x14>;
>         };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
