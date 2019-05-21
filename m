From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/5] i2c: core: Move ACPI IRQ handling to probe time
Date: Tue, 21 May 2019 16:20:04 +0300
Message-ID: <20190521132004.GG9224@smile.fi.intel.com>
References: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
 <20190520084936.10590-4-ckeepax@opensource.cirrus.com>
 <20190521112728.GX2781@lahna.fi.intel.com>
 <20190521125704.GF9224@smile.fi.intel.com>
 <20190521131104.GB99937@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521131104.GB99937@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 21, 2019 at 02:11:04PM +0100, Charles Keepax wrote:
> On Tue, May 21, 2019 at 03:57:04PM +0300, Andy Shevchenko wrote:
> > On Tue, May 21, 2019 at 02:27:28PM +0300, Mika Westerberg wrote:
> > > On Mon, May 20, 2019 at 09:49:34AM +0100, Charles Keepax wrote:
> > > > Bring the ACPI path in sync with the device tree path and handle all the
> > > > IRQ fetching at probe time. This leaves the only IRQ handling at device
> > > > registration time being that which is passed directly through the board
> > > > info as either a resource or an actual IRQ number.
> > > 
> > > I don't see issues with this approach. Cc'd Jarkko and Andy just in case
> > > I missed something.
> > 
> > I failed to see the i2c_acpi_get_irq() in the current code.
> > What kernel version do you use?
> > Can we see the changes against vanilla / i2c-next?
> > 
> 
> It's added by the first patch in the chain:
> 
> https://lkml.org/lkml/2019/5/20/281
> 
> I could resend the series with you and Jarkko on CC if that would
> be better.

That would be better.

-- 
With Best Regards,
Andy Shevchenko
