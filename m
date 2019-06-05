From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 4/6] i2c: core: Move ACPI IRQ handling to probe time
Date: Wed, 5 Jun 2019 09:22:49 +0100
Message-ID: <20190605082249.GL28362@ediswmail.ad.cirrus.com>
References: <20190528142900.24147-1-ckeepax@opensource.cirrus.com>
 <20190528142900.24147-4-ckeepax@opensource.cirrus.com>
 <20190604170404.GR9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604170404.GR9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 04, 2019 at 08:04:04PM +0300, Andy Shevchenko wrote:
> On Tue, May 28, 2019 at 03:28:58PM +0100, Charles Keepax wrote:
> > Bring the ACPI path in sync with the device tree path and handle all the
> > IRQ fetching at probe time. This leaves the only IRQ handling at device
> > registration time being that which is passed directly through the board
> > info as either a resource or an actual IRQ number.
> > 
> 
> It seems my comments weren't addressed by one or another reason.
> This one I would rather to split with exporting function as a separate patch.
> 

With the switch to passing in i2c_client it makes for some fairly
awkward gymnastics and "ping pong" programming to do so. I guess
we could leave the function taking in an acpi_device but just
felt like a slightly less user friendly interface. Any thoughts?

Thanks,
Charles
