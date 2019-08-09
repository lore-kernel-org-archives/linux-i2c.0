From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] [RFC] ARM: remove Intel iop33x and iop13xx support
Date: Fri, 9 Aug 2019 11:34:12 -0700
Message-ID: <CAA9_cmdDbBm0ookyqGJMcyLVFHkYHuR3mEeawQKS2UqYJoWWaQ@mail.gmail.com>
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809163334.489360-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, Russell King <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>
List-Id: linux-i2c@vger.kernel.org

[ add Martin (if cyrius.com address is still valid) ]

On Fri, Aug 9, 2019 at 9:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> There are three families of IOP machines we support in Linux: iop32x
> (which includes EP80219), iop33x and iop13xx (aka IOP34x aka WP8134x).
>
> All products we support in the kernel are based on the first of these,
> iop32x, the other families only ever supported the Intel reference
> boards but no actual machine anyone could ever buy.
>
> While one could clearly make them all three work in a single kernel
> with some work, this takes the easy way out, removing the later two
> platforms entirely, under the assumption that there are no remaining
> users.
>
> Earlier versions of OpenWRT and Debian both had support for iop32x
> but not the others, and they both dropped iop32x as well in their 2015
> releases.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm just guessing that iop32x is still needed, and the other two are
> not. If anyone disagrees with that assessment, let me know so we
> can come up with an alternative approach.

I'm not sure who would scream if iop32x support went away as well, but
I have not followed this space in years hence copying Martin.

In any event:

Acked-by: Dan Williams <dan.j.williams@intel.com>
