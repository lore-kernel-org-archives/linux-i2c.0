From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 11/13] mfd: intel-lpss: Pass HSUART configuration via
 properties
Date: Wed, 25 Nov 2015 14:12:52 +0200
Message-ID: <20151125121252.GY1587@lahna.fi.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448360579-79260-12-git-send-email-andriy.shevchenko@linux.intel.com>
 <6720400.mTdslW7yXO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6720400.mTdslW7yXO@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 24, 2015 at 08:53:04PM +0100, Arnd Bergmann wrote:
> On Tuesday 24 November 2015 12:22:57 Andy Shevchenko wrote:
> > +static struct property_entry uart_properties[] = {
> > +       PROPERTY_ENTRY_U32("reg-io-width", 4),
> > +       PROPERTY_ENTRY_U32("reg-shift", 2),
> > +       PROPERTY_ENTRY_U8("snps,uart-16550-compatible", 1),
> > +       { },
> > 
> 
> If I read the binding correctly, the "snps,uart-16550-compatible" property
> is meant to be boolean, meaning true if present and zero-length or false
> if absent. Using a u8 propert instead feels wrong.
> 
> Maybe we can have a PROPERTY_ENTRY_BOOL() for that?

That's a good idea. We'll add it to the next revision of the series.
