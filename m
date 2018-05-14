From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 03/21] i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 19:59:37 +0300
Message-ID: <CAHp75Vcz72q1Oi9hCf1vp32h3GrrYSoR0BR7qacnka9eKB8XAQ@mail.gmail.com>
References: <20180514145330.4857-1-peda@axentia.se> <20180514145330.4857-4-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-4-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 14, 2018 at 5:53 PM, Peter Rosin <peda@axentia.se> wrote:
> Because it looks neater.

>  drivers/i2c/algos/i2c-algo-pcf.c | 5 +----

I guess for such trivial no functional change patches you may do them
one per folder, and not one-per driver.

-- 
With Best Regards,
Andy Shevchenko
