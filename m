From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 16/16] i2c: designware: Convert to use unified device
 property API
Date: Tue, 1 Dec 2015 11:08:33 +0200
Message-ID: <20151201090833.GF7422@lahna.fi.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448896304-87928-17-git-send-email-andriy.shevchenko@linux.intel.com>
 <20151130195858.GB16446@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151130195858.GB16446@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 30, 2015 at 08:58:58PM +0100, Wolfram Sang wrote:
> On Mon, Nov 30, 2015 at 05:11:44PM +0200, Andy Shevchenko wrote:
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > With ACPI _DSD (introduced in ACPI v5.1) it is now possible to pass device
> > configuration information from ACPI in addition to DT. In order to support
> > this, convert the driver to use the unified device property accessors
> > instead of DT specific.
> > 
> > Change to ordering a bit so that we first try platform data and if that's
> > not available look from device properties. ACPI *CNT methods are then used
> > as last resort to override everything else.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> What is the bug fix here described in the cover letter?

The bug fix is actually in patch [14/16] "mfd: intel-lpss: Pass SDA hold
time to I2C host controller driver".

> And shall this go via I2C or via the rest of the series?

Either way works. This should compile and work fine without the rest but
of course fix for the issue with Lenovo Yoga 900 toucpad still requires
all the patches.
