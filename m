From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 14/16] mfd: intel-lpss: Pass SDA hold time to I2C host
 controller driver
Date: Mon, 8 Feb 2016 12:29:11 +0200
Message-ID: <20160208102911.GC1794@lahna.fi.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448896304-87928-15-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160208100942.GA2220@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160208100942.GA2220@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 08, 2016 at 11:09:43AM +0100, Wolfram Sang wrote:
> On Mon, Nov 30, 2015 at 05:11:42PM +0200, Andy Shevchenko wrote:
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Intel Skylake the LPSS I2C pad circuit has internal delays that require
> > programming non-zero SDA hold time for the I2C host controller. If this is
> > not done communication to slave devices may fail with arbitration lost
> > errors like the one seen below taken from Lenovo Yoga 900:
> > 
> >   i2c_hid i2c-SYNA2B29:00: Fetching the HID descriptor
> >   i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=20 00
> >   i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitration
> > 
> > To fix this we follow what the Windows driver is doing and pass the default
> > SDA hold time of 230 ns to all Intel Skylake host controllers. This still
> > allows the platform to override these values by passing special ACPI
> > methods SSCN and FMCN.
> > 
> > Reported-by: Kevin Fenzi <kevin@scrye.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There has been a request to get this into stable:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=108581
> 
> Since we probably don't want to backport the whole device_property
> series, is there a simpler fix to backport for stable?

Basically all it needs is to have:

	dev->sda_hold_time = 28

in dw_i2c_acpi_configure(). However, we cannot just unconditionally set
it as it will break existing non-SKL systems so there should be some way
to check if this is SKL or not. Perhaps we could look for DMI entries of
the affected machines?

BTW, this is not a regression in a sense as SKL I2C never worked before
this series.
