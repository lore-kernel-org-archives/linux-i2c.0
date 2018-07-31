From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/6] i2c: designware: use generic table matching
Date: Tue, 31 Jul 2018 17:53:17 +0300
Message-ID: <1cbe4c184a0a6db1fc5401dbd8bd3a9f6bf22527.camel@linux.intel.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
         <20180731134740.441-2-alexandre.belloni@bootlin.com>
         <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
         <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
         <20180731143059.GV28585@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731143059.GV28585@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-31 at 16:30 +0200, Alexandre Belloni wrote:
> On 31/07/2018 17:23:04+0300, Andy Shevchenko wrote:
> > On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> > > On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
 
> > > > +	dev->flags |= (u32)device_get_match_data(&pdev->dev);
> > > > +
> > 
> > And since it would be changed anyway, can you actually move this
> > line
> > closet to  if (has_acpi_companion()) one ?
> > 
> 
> I need that value to be set before calling of_configure though.

AFAICS, you added those lines later, so, it would be something like

dev->flags |= ...

if (of_node)
 of_configure()
if (has_acpi_companion())
 acpi_configure()

Would it work for you?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
