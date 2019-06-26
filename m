From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v6 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Wed, 26 Jun 2019 13:58:45 +0100
Message-ID: <20190626125845.GD54126@ediswmail.ad.cirrus.com>
References: <20190621100815.12417-1-ckeepax@opensource.cirrus.com>
 <20190621100815.12417-5-ckeepax@opensource.cirrus.com>
 <20190625115011.GE2640@lahna.fi.intel.com>
 <20190625124245.GC54126@ediswmail.ad.cirrus.com>
 <20190625132515.GA9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625132515.GA9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 25, 2019 at 04:25:15PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 25, 2019 at 01:42:45PM +0100, Charles Keepax wrote:
> > On Tue, Jun 25, 2019 at 02:50:11PM +0300, Mika Westerberg wrote:
> 
> > I would be happy to squash the two patches, and go back to the
> > i2c_client approach, if that was preferred and  as long as Andy
> > doesn't mind.
> 
> I don't.
> 

Groovy alright think I will squash these two patches and return
to the i2c_client interface.

Thanks,
Charles
