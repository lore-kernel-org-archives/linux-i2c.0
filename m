From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/6] i2c: pca-platform: additional improvements
Date: Fri, 30 Jun 2017 11:48:06 +0300
Message-ID: <CAHp75Vfbvi40MjLmYScowsgRb6+fes5W8iV39_iiPgo4+=Bxjg@mail.gmail.com>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 30, 2017 at 3:54 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> This series addresses some of the points identified by Andy. The series is
> based on top of i2c/for-next.
>
> I haven't got a working sh4 toolchain so I haven't been able to compile test
> patch 1/1.
>

Cool! So, for patches 1-4

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch 5 needs more work I suppose which likely brings another patch or
extends existing one.
Patch 6 I didn't look deeply, so, only one concern is to check
bisectability (looks like it is in a right place).


> Chris Packham (6):
>   sh: sh7785lcr: add GPIO lookup table for i2c controller reset
>   i2c: pca-platform: correctly set algo_data.reset_chip
>   i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
>   i2c: pca-platform: unconditionally use devm_gpiod_get_optional
>   i2c: pca-platform: use device_property_read_u32
>   i2c: pca-platform: drop gpio from platform data
>
>  arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
>  arch/sh/boards/board-sh7785lcr.c          | 11 +++++++-
>  drivers/i2c/busses/i2c-pca-platform.c     | 42 +++++++++++--------------------
>  include/linux/i2c-pca-platform.h          |  3 ---
>  4 files changed, 25 insertions(+), 32 deletions(-)
>
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
