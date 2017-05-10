From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression: bd698d24b1b57: i2c: designware: Get selected speed
 mode sda-hold-time via ACPI
Date: Wed, 10 May 2017 10:24:50 +0100
Message-ID: <20170510092450.GA26012@red-moon>
References: <20170509140720.GA21122@red-moon>
 <1494341651.30052.82.camel@linux.intel.com>
 <20170509155253.GA21475@red-moon>
 <1494346848.30052.84.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494346848.30052.84.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chin.yew.tan@intel.com, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, wsa@the-dreams.de, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, ken.xue@amd.com, jeff.wu@amd.com
List-Id: linux-i2c@vger.kernel.org

On Tue, May 09, 2017 at 07:20:48PM +0300, Andy Shevchenko wrote:
> On Tue, 2017-05-09 at 16:52 +0100, Lorenzo Pieralisi wrote:
> > [+ Ken, Jeff]
> > 
> > On Tue, May 09, 2017 at 05:54:11PM +0300, Andy Shevchenko wrote:
> > > On Tue, 2017-05-09 at 15:07 +0100, Lorenzo Pieralisi wrote:
> > > > Hi guys,
> > > > 
> > > > as a heads-up, with today mainline (commit 2868b2513aa7) I get the
> > > > following splat on AMD Seattle, reverting the $SUBJECT commit
> > > > "solves"
> > > > the problem.
> > > > 
> > > > My I2C knowledge is a bit limited but I am not sure I understand
> > > > why
> > > > we should be reading eg ss_hcnt/ss_lcnt depending on the dev-
> > > > >clk_freq
> > > > but then i2c_dw_init() _always_ requires those values to be set
> > > > for
> > > > a given device. Again, I have no insights into I2C inner workings
> > > > so apologies for the silly assumption/question.
> > > > 
> > > > Please have a look into this, thanks.
> > > 
> > > Since there is no clock defined you got a warning.
> > 
> > IIUC there has never been a clock defined for this platform, that's
> > the problem. The warning appeared because the commit in $SUBJECT
> > prevents reading the ss_hcnt and ss_lcnt values from ACPI methods
> > that are there in ACPI tables (SSCN and FMCN), because it carries
> > out the SSCN FMCN look-up depending on the dev->clk_freq value.
> > 
> > Before $SUBJECT commit the values were read unconditionally from SSCN
> > and FMCN ACPI methods IIUC, again, I am no I2C expert so it is more
> > a question than anything else.
> > 
> > dev->clk_freq is set to 400000 by default because FW does not the
> > contain (ie never contained) "clock-frequency" property and
> > acpi_speed can't be ascertained through I2C resources, that's how
> > I read what's happening.
> > 
> > > It means either ID is not added to drivers/acpi/acpi_apd.c or
> 
> Just one question, did you look at all into above driver?
> I suppose it missed ID and properties for the device.

I looked into it yes. I have also looked at ACPI tables and they
contain the SSCN and FMCN methods and AFAIK the set-up was working
fine before the commit in $SUBJECT - AMD guys - please correct me
if I am wrong, I found this thread which explains things a bit:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/395983.html

If we have to patch drivers/acpi/acpi_apd.c to restore the previous
behaviour that's fine by me but this is a regression nonetheless unless
someone explains to me why the current firmware set-up (with SSCN and
FMCN) is unreliable/deprecated, it is not clear to me at all and it
may affect other platforms too.

Thanks,
Lorenzo
