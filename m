From: Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 6/6] i2c: designware: Add Baikal-T1 SoC I2C controller
 support
Date: Wed, 25 Mar 2020 21:21:01 +0300
Message-ID: <20200325182101.k47u4cjnbv6knsag@ubsrv2.baikal.int>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132348.71E638030793@mail.baikalelectronics.ru>
 <20200321183349.GC5632@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.baikalelectronics.com ([87.245.175.226]:47894 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSVS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 25 Mar 2020 14:21:18 -0400
Content-Disposition: inline
In-Reply-To: <20200321183349.GC5632@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 07:33:49PM +0100, Wolfram Sang wrote:
> On Fri, Mar 06, 2020 at 04:19:58PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > A third I2C controller embedded into the Baikal-T1 SoC is also fully
> > based on the DW APB I2C core, but its registers are indirectly
> > accessible via "command/data in/data out" trio. There is no difference
> > other than that. So in order to have that controller supported by the
> > common DW APB I2C driver we only need to introduce a new flag
> > ACCESS_INDIRECT and use the access-registers to reach the I2C controller
> > normal registers space in the dw_readl/dw_writel methods. Currently this
> > flag is only enabled for the controllers with "be,bt1-i2c" compatible
> > string.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> 
> Patches 2,3, and 6 have comments which should be addressed. Patches 4+5
> can be dropped when sending next version.
> 

Great! Thanks. I'll have respond on the requests very soon.

Regards,
-Sergey
