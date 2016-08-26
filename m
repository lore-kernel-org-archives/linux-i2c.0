From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: designware-baytrail: Fix the Kconfig dependency
 fix
Date: Fri, 26 Aug 2016 17:40:41 +0200
Message-ID: <20160826174041.720d29bb@endymion>
References: <20160722102403.5c2d3c7e@endymion>
        <20160825202425.GH1614@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36465 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754135AbcHZPkp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Aug 2016 11:40:45 -0400
In-Reply-To: <20160825202425.GH1614@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>

Hi Wolfram, Jarkko,

On Thu, 25 Aug 2016 22:24:25 +0200, Wolfram Sang wrote:
> On Fri, Jul 22, 2016 at 10:24:03AM +0200, Jean Delvare wrote:
> > Commit b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for
> > proper Kconfig dependencies") claims that the "Baytrail driver" isn't
> > tristate. But in fact there is no such thing as a "Baytrail driver",
> > i2c-designware-baytrail is not a stand-alone driver but an optional
> > addition to the i2c-designware-platform driver, and that driver *is*
> > tristate. So there is no reason why I2C_DESIGNWARE_BAYTRAIL couldn't
> > be enabled when IOSF_MBI=m, as long as I2C_DESIGNWARE_PLATFORM=m too.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Fixes: b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for proper Kconfig dependencies")
> > Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: David E. Box <david.e.box@linux.intel.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> 
> I applied a patch from Jarkko on 19.6.2016 which also changed the
> dependencies. Not sure if it is equal to your change, but this patch
> doesn't apply anymore.

As I understand it, Jarkko's patch sets the same dependencies my patch
was setting, just expressed differently. So we are good, you can drop
my patch.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
