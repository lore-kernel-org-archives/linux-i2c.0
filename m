From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/7] dma: iop-adma: include prefetch.h
Date: Wed, 14 Aug 2019 17:29:03 +0200
Message-ID: <CAK8P3a0jWunQFvt4bVn0GtqN5xwcnO2a1jO0EaqxWqw4VMGL5Q@mail.gmail.com>
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
 <20190809163334.489360-2-arnd@arndb.de> <20190813043324.GN12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813043324.GN12733@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: soc@kernel.org, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, kbuild test robot <lkp@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 13, 2019 at 6:34 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 09-08-19, 18:33, Arnd Bergmann wrote:
> > Compile-testing this driver fails on m68k without the
> > extra header inclusion.
>
> Please change title to "dmaengine: iop-adma: include prefetch.h"
>
> After that:
>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Ok, thanks!

One day I will remember all the subsystem prefixes. ;-)

       Arnd
