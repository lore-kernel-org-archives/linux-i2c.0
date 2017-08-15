From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] mfd: dm355evm_msp: move header file out of I2C
 realm
Date: Tue, 15 Aug 2017 08:01:22 +0100
Message-ID: <20170815070122.m6mesqzqbilnwrab@dell>
References: <20170814163424.2197-1-wsa@the-dreams.de>
 <20170814163424.2197-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814163424.2197-2-wsa@the-dreams.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Aug 2017, Wolfram Sang wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Change since V1:
> 
> * rebased to v4.13-rc5, no changes needed
> * acks added. I think none are missing.
> 
>  drivers/input/misc/dm355evm_keys.c        | 2 +-
>  drivers/mfd/dm355evm_msp.c                | 2 +-
>  drivers/rtc/rtc-dm355evm.c                | 2 +-
>  include/linux/{i2c => mfd}/dm355evm_msp.h | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
