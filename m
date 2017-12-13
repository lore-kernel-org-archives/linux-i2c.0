From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Wed, 13 Dec 2017 17:30:14 +0200
Message-ID: <1513179014.7000.44.camel@linux.intel.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
         <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
         <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
         <20171205133848.nzrhysiz2twvlamx@ninjato>
         <CACRpkdYuHit1w1_d4h++vOuSWosf+iBdgimtCUbmic3mkbm1Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYuHit1w1_d4h++vOuSWosf+iBdgimtCUbmic3mkbm1Wg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2017-12-05 at 16:31 +0100, Linus Walleij wrote:
> On Tue, Dec 5, 2017 at 2:38 PM, Wolfram Sang <wsa@the-dreams.de>
> wrote:
> 


> Two statice inlines in <linux/gpio/consumer.h>
> named
> 
> int gpiod_is output()
> int gpiod_is_input()

Ha, just proposed similar.

> 
> should conform to Rusty Russell's API hierarchy.
> 
> Interested in fixing it, or should I?
> I can almost ACK it before you write the patch.

I vote for this type of API, and agree with Wolfram !_get_direction() is
confusing.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
