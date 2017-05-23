From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] gpio: pcf857x: move header file out of I2C realm
Date: Tue, 23 May 2017 11:35:53 +0200
Message-ID: <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
References: <20170521215727.1243-1-wsa@the-dreams.de> <20170521215727.1243-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170521215727.1243-3-wsa@the-dreams.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jonathan Cameron <jic23@cam.ac.uk>, Ralf Baechle <ralf@linux-mips.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, May 21, 2017 at 11:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c       | 2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c       | 2 +-
>  arch/arm/mach-pxa/balloon3.c                   | 2 +-
>  arch/arm/mach-pxa/stargate2.c                  | 2 +-
>  arch/mips/ath79/mach-pb44.c                    | 2 +-
>  drivers/gpio/gpio-pcf857x.c                    | 2 +-
>  include/linux/{i2c => platform_data}/pcf857x.h | 0
>  8 files changed, 7 insertions(+), 7 deletions(-)
>  rename include/linux/{i2c => platform_data}/pcf857x.h (100%)

Patch applied.

BTW ARM SoC maintainers be warned, I optimistically assume this will
not collide with any ARM SoC work...

Yours,
Linus Walleij
