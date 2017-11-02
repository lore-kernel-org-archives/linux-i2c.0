From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 09/15] hwmon: (w83781d) Remove duplicate NULL check
Date: Thu, 02 Nov 2017 14:23:29 +0200
Message-ID: <1509625409.10233.184.camel@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
         <20171031142149.32512-9-andriy.shevchenko@linux.intel.com>
         <4b621f23-f251-7fa6-c79c-059b48f27345@roeck-us.net>
         <1509542817.10233.156.camel@linux.intel.com>
         <20171101230734.6zsxizhcwazffhrx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20171101230734.6zsxizhcwazffhrx@ninjato>
Sender: linux-hwmon-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-11-02 at 00:07 +0100, Wolfram Sang wrote:
> > > I'll keep the hwmon patches from this series on hold until the
> > > changes
> > > to i2c_unregister_device make it into the tree. Ok with me if the
> > > patches
> > > are merged through some other tree.
> > 
> > Wolfram, what do you think?
> > 
> > At least we have couple of options:
> > - apply i2c core patch now and wait until rc1
> > - apply everything through i2c tree
> > - ...
> 
> I just applied patches 1-3 to my for-4.15 branch. So, other subsystems
> could pick it at rc1 time. If you are going to resend, you can add my
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
> to all of the remaining patches.

Noted, thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
