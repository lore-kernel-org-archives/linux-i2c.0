From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 13/13] i2c: designware: Convert to use unified device
 property API
Date: Tue, 24 Nov 2015 13:03:29 +0200
Message-ID: <20151124110329.GJ1587@lahna.fi.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448360579-79260-14-git-send-email-andriy.shevchenko@linux.intel.com>
 <56544192.1030708@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56544192.1030708@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 24, 2015 at 12:53:06PM +0200, Jarkko Nikula wrote:
> Mika, Andy: Was this one able to go separately? At least it builds without
> rest of the set but is there anything that could break DT based system if
> there are no patches 1-8/13?

As far as I can tell this should not break existing DT systems but I
have not been able to test myself since I don't have any DT systems
here.

> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks!
