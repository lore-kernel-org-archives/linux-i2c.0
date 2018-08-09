From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/6] i2c: designware: use generic table matching
Date: Thu, 09 Aug 2018 12:29:41 +0300
Message-ID: <92b206fcb5af4ad809e6f2b103a21bce9f9af706.camel@linux.intel.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
         <20180806185412.7210-2-alexandre.belloni@bootlin.com>
         <20180808202210.qkocl4hckqla7exe@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808202210.qkocl4hckqla7exe@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2018-08-08 at 22:22 +0200, Wolfram Sang wrote:
> On Mon, Aug 06, 2018 at 08:54:07PM +0200, Alexandre Belloni wrote:
> > Switch to device_get_match_data in probe to match the device
> > specific data
> > instead of using the acpi specific function.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Andy, you happy with this patch?
> 

Yes, yes.
If you need my formal tag, here it is

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
