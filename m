From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 6/6] i2c: designware: Add Baikal-T1 SoC I2C controller
 support
Date: Fri, 6 Mar 2020 15:51:34 +0200
Message-ID: <20200306135134.GD1748204@smile.fi.intel.com>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132348.71E638030793@mail.baikalelectronics.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:41270 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFNvf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Mar 2020 08:51:35 -0500
Content-Disposition: inline
In-Reply-To: <20200306132348.71E638030793@mail.baikalelectronics.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sergey.Semin@baikalelectronics.ru
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:19:58PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> A third I2C controller embedded into the Baikal-T1 SoC is also fully
> based on the DW APB I2C core, but its registers are indirectly
> accessible via "command/data in/data out" trio. There is no difference
> other than that. So in order to have that controller supported by the
> common DW APB I2C driver we only need to introduce a new flag
> ACCESS_INDIRECT and use the access-registers to reach the I2C controller
> normal registers space in the dw_readl/dw_writel methods. Currently this
> flag is only enabled for the controllers with "be,bt1-i2c" compatible
> string.

See my response to cover letter.

>  drivers/i2c/busses/i2c-designware-common.c  | 79 ++++++++++++++++++---
>  drivers/i2c/busses/i2c-designware-core.h    | 14 ++++
>  drivers/i2c/busses/i2c-designware-master.c  |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c |  1 +
>  drivers/i2c/busses/i2c-designware-slave.c   |  1 +

This should be split at least to two patches (preparation in the core followed
by switching users).

-- 
With Best Regards,
Andy Shevchenko
