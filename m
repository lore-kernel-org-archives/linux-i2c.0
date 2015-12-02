From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 16/16] i2c: designware: Convert to use unified device property API
Date: Wed, 02 Dec 2015 02:28:29 +0100
Message-ID: <3465575.VLD33ozkzD@vostro.rjw.lan>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com> <20151130195858.GB16446@katana> <1448966031.15393.131.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1448966031.15393.131.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, December 01, 2015 12:33:51 PM Andy Shevchenko wrote:
> On Mon, 2015-11-30 at 20:58 +0100, Wolfram Sang wrote:
> > On Mon, Nov 30, 2015 at 05:11:44PM +0200, Andy Shevchenko wrote:
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > With ACPI _DSD (introduced in ACPI v5.1) it is now possible to pass
> > > device
> > > configuration information from ACPI in addition to DT. In order to
> > > support
> > > this, convert the driver to use the unified device property
> > > accessors
> > > instead of DT specific.
> > > 
> > > Change to ordering a bit so that we first try platform data and if
> > > that's
> > > not available look from device properties. ACPI *CNT methods are
> > > then used
> > > as last resort to override everything else.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > 
> > What is the bug fix here described in the cover letter?
> 
> The cover letter mentioned 'last part' which I refer to as patches 14,
> 15 (though this is for UART), and 16.

Hmm.

So may I assume that patches [1-13/16] are for me and the rest is to be applied
by the other respective maintainers?

That should be easiest logistically IMHO.

Thanks,
Rafael

