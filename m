From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
Date: Tue, 17 Jul 2018 18:26:15 +0300
Message-ID: <c7704b44012f6b743cc3791eab3faf674f988ce9.camel@linux.intel.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-4-alexandre.belloni@bootlin.com>
         <1886510d2a828d3a246ef1f490c6819f073fbdcb.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1886510d2a828d3a246ef1f490c6819f073fbdcb.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-17 at 18:16 +0300, Andy Shevchenko wrote:
> On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> > The Microsemi Ocelot I2C controller is a designware IP. It also has
> > a
> > second set of registers to allow tweaking SDA hold time and spike
> > filtering.

> What do you think?

You can also split it to 2-3 patches, like:
- move to device_get_match_data()
- move OF device table above in the code (no func changes)
- add support for MSCC


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
