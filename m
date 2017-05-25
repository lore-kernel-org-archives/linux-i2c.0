From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/3] gpio: pcf857x: move header file out of I2C realm
Date: Thu, 25 May 2017 14:22:04 +0530
Message-ID: <41555985-34c3-da9c-e4a4-f61d4eb2ec38@ti.com>
References: <20170521215727.1243-1-wsa@the-dreams.de>
 <20170521215727.1243-3-wsa@the-dreams.de>
 <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jonathan Cameron <jic23@cam.ac.uk>, Ralf Baechle <ralf@linux-mips.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

On Tuesday 23 May 2017 03:05 PM, Linus Walleij wrote:
> On Sun, May 21, 2017 at 11:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
>> include/linux/i2c is not for client devices. Move the header file to a
>> more appropriate location.
>>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>> ---
>>  arch/arm/mach-davinci/board-da830-evm.c        | 2 +-
>>  arch/arm/mach-davinci/board-dm644x-evm.c       | 2 +-
>>  arch/arm/mach-davinci/board-dm646x-evm.c       | 2 +-
>>  arch/arm/mach-pxa/balloon3.c                   | 2 +-
>>  arch/arm/mach-pxa/stargate2.c                  | 2 +-
>>  arch/mips/ath79/mach-pb44.c                    | 2 +-
>>  drivers/gpio/gpio-pcf857x.c                    | 2 +-
>>  include/linux/{i2c => platform_data}/pcf857x.h | 0
>>  8 files changed, 7 insertions(+), 7 deletions(-)
>>  rename include/linux/{i2c => platform_data}/pcf857x.h (100%)
> 
> Patch applied.
> 
> BTW ARM SoC maintainers be warned, I optimistically assume this will
> not collide with any ARM SoC work...

Thanks for the heads-up. The mach-davinci part does not clash with
anything I have queued. I added this patch to a branch of my tree which
I merge together but don't sent upstream. So I will know if I end up
queuing anything which clashes.

Thanks,
Sekhar
