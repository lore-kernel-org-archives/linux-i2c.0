From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/7] ARM: xscale: fix multi-cpu compilation
Date: Fri, 23 Aug 2019 09:44:19 +0200
Message-ID: <CACRpkdajapOw+fsEx1fqG3FL-n-WYmOUoGw_HGRHd730h+uv-w@mail.gmail.com>
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
 <20190809163334.489360-5-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809163334.489360-5-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 9, 2019 at 6:33 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Building a combined ARMv4+XScale kernel produces these
> and other build failures:
>
> /tmp/copypage-xscale-3aa821.s: Assembler messages:
> /tmp/copypage-xscale-3aa821.s:167: Error: selected processor does not support `pld [r7,#0]' in ARM mode
> /tmp/copypage-xscale-3aa821.s:168: Error: selected processor does not support `pld [r7,#32]' in ARM mode
> /tmp/copypage-xscale-3aa821.s:169: Error: selected processor does not support `pld [r1,#0]' in ARM mode
> /tmp/copypage-xscale-3aa821.s:170: Error: selected processor does not support `pld [r1,#32]' in ARM mode
> /tmp/copypage-xscale-3aa821.s:171: Error: selected processor does not support `pld [r7,#64]' in ARM mode
> /tmp/copypage-xscale-3aa821.s:176: Error: selected processor does not support `ldrd r4,r5,[r7],#8' in ARM mode
> /tmp/copypage-xscale-3aa821.s:180: Error: selected processor does not support `strd r4,r5,[r1],#8' in ARM mode

OK we certainly need this.

> Add an explict .arch armv5 in the inline assembly to allow the ARMv5
> specific instructions regardless of the compiler -march= target.

You probably mean...

> +.arch xscale                                   \n\
>         pld     [%0, #0]                        \n\

Explicit .arch xscale rather than .arch armv5.

Yours,
Linus Walleij
