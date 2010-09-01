From: Joe Perches <joe@perches.com>
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
Date: Tue, 31 Aug 2010 22:24:14 -0700
Message-ID: <1283318654.1797.140.camel@Joe-Laptop>
References: <4C7DB9CF.5000905@dsn.okisemi.com>
	 <1283309032.1797.123.camel@Joe-Laptop>
	 <001e01cb4993$bc0d75d0$66f8800a@maildom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001e01cb4993$bc0d75d0$66f8800a@maildom.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Crane Cai <crane.cai@amd.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, Ralf Baechle <ralf@linux-mips.org>, srinidhi kasagar <srinidhi.kasagar@stericsson.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Wang Yong Y\"" <yong.y.wang@intel.com>, "Wang Qi\"" <qi.wang@intel.com>, "Andrew\"" <andrew.chih.howe.khor@intel.com>, arjan@linux.intel.com, Tomoya MORINAGA <morinaga526@dsn.okisemi.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2010-09-01 at 14:08 +0900, Masayuki Ohtake wrote:
> I have a question.
> Current our I2C driver  has the following 2 patterns dev_err().
> (1) dev_err(adap->pch_adapter.dev.parent, "...");
> (2) dev_err(&pdev->dev, "...");
> > #define pch_err(adap, fmt, arg...) \
> > dev_err(adap->pch_adapter.dev.parent, fmt, ##arg)
> In case of using the above code, pattern (1) can apply, but (2) can't.
> As to (2),
> Should we use as dev_err or define another macro?

Hello Ohtake.

To me, it's a visual complexity vs std pattern trade-off.

A 2 level dereference like dev_info(&dev->dev, ...)
isn't overly difficult to read.
3 or more dereferences can be harder and a bit error prone.
So I would only use pch_<level> for (1) and dev_err for (2).

There are also times when there are additional standard
arguments that you want to prefix to dev_<level> calls
and that can be simplified with a custom XXX_<level>
define for dev_<level>

Look at the current uses in the tree and see what you like.

$ grep -rP --include=*.[ch] "#define\s*.+\s+dev_[a-z]{3,7}\s*\(" *

These aren't requirements, do what you think best.

cheers, Joe
