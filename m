From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/6] i2c: designeware: Add Baikal-T1 SoC DW I2C specifics
 support
Date: Fri, 6 Mar 2020 15:54:45 +0200
Message-ID: <20200306135445.GE1748204@smile.fi.intel.com>
References: <20200306132001.1B875803087C@mail.baikalelectronics.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:41481 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgCFNys (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Mar 2020 08:54:48 -0500
Content-Disposition: inline
In-Reply-To: <20200306132001.1B875803087C@mail.baikalelectronics.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sergey.Semin@baikalelectronics.ru
Cc: Serge Semin <fancer.lancer@gmail.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>, Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>, Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>, Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>, Vadim Vlasov <V.Vlasov@baikalelectronics.ru>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

First of all, I got only 3 out of 6 patches. Are you sure you properly prepared
the series?

On Fri, Mar 06, 2020 at 04:19:49PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>

Same comment as per DMA series, try next time to link the cover letter to the
series correctly.

> There are three DW I2C controllers embedded into the Baikal-T1 SoC. Two
> of them are normal with standard DW I2C IP-core configurations and registers
> accessible over normal MMIO space - so they are acceptable by the available
> DW I2C driver with no modification.

> But there is a third, which is a bit
> different. Its registers are indirectly accessed be means of "command/data
> in/data out" registers tuple. In order to have it also supported by the DW
> I2C driver, we must modify the code a bit. This is a main purpose of this
> patchset.
> 
> First of all traditionally we replaced the legacy plain text-based dt-binding
> file with yaml-based one. Then we found and fixed a bug in the DW I2C FIFO size
> detection algorithm which tried to do it too early before dw_readl/dw_writel
> methods could be used.

So far so good (looks like, I think colleagues of mine and myself will review
individual patches later on).

> Finally we introduced a platform-specific flag
> ACCESS_INDIRECT, which would enable the indirect access to the DW I2C registers
> implemented for one of the Baikal-T1 SoC DW I2C controllers. See the commit
> message of the corresponding patch for details.

This is quite questionable. In Intel SoCs we have indirect I²C controllers to
access (inside PMIC, for example). The approach used to do that is usually to
have an IPC mechanism and specific bus controller driver. See i2c-cht-wc.c for
instance.

I'm not sure if it makes a lot of duplication and if actually switching I²C
DesignWare driver to regmap API will solve it. At least that is the second
approach I would consider.

But I'll wait others to comment on this. We have to settle the solution before
going further.

> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").

`git format-patch --base ...` should do the job.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>

Same comment as per UART patch. Who is the Alexey in relation to the work done?

-- 
With Best Regards,
Andy Shevchenko
