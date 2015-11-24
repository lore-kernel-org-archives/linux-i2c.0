From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 11/13] mfd: intel-lpss: Pass HSUART configuration via
 properties
Date: Tue, 24 Nov 2015 13:13:50 +0200
Message-ID: <20151124111350.GK1587@lahna.fi.intel.com>
References: <1448360579-79260-12-git-send-email-andriy.shevchenko@linux.intel.com>
 <201511241832.3nOM8ymb%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201511241832.3nOM8ymb%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 24, 2015 at 06:44:53PM +0800, kbuild test robot wrote:
> Hi Mika,
> 
> [auto build test ERROR on v4.4-rc2]
> [also build test ERROR on next-20151124]
> [cannot apply to ljones-mfd/for-mfd-next]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/device-property-always-check-for-fwnode-type/20151124-183221
> config: x86_64-randconfig-x019-11241713 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> drivers/mfd/intel-lpss-pci.c:68:30: error: array type has incomplete element type 'struct property_entry'
>     static struct property_entry uart_properties[] = {

Thanks kbuild robot!

This patch misses include of <linux/property.h>. It seems that it got
added by a subsequent patch which was not sent out.

We will fix this.
