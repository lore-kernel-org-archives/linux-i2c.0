From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: designware-baytrail: Fix the Kconfig dependency
 fix
Date: Thu, 4 Feb 2016 20:51:16 +0100
Message-ID: <20160204205116.1cc08fb8@endymion>
References: <20160202143324.780986be@endymion>
	<56B33A34.7000400@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44492 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbcBDTvU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 4 Feb 2016 14:51:20 -0500
In-Reply-To: <56B33A34.7000400@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "David E. Box" <david.e.box@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On Thu, 4 Feb 2016 13:47:00 +0200, Jarkko Nikula wrote:
> On 02/02/2016 03:33 PM, Jean Delvare wrote:
> > Commit b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for
> > proper Kconfig dependencies") claims that the "Baytrail driver" isn't
> > tristate. But in fact there is no such thing as a "Baytrail driver",
> > i2c-designware-baytrail is not a stand-alone driver but an optional
> > addition to the i2c-designware-platform driver, and that driver *is*
> > tristate. So there is no reason why I2C_DESIGNWARE_BAYTRAIL couldn't
> > be enabled when IOSF_MBI=m, as long as I2C_DESIGNWARE_PLATFORM=m too.
> >
> I had a similar patch waiting for David's ack because I didn't know are 
> there any problems when IOSF_MBI is module but I forgot to ping again.
> 
> David: can you ack this in case IOSF_MBI=m is ok.
> 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Fixes: b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for proper Kconfig dependencies")
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: David E. Box <david.e.box@linux.intel.com>
> > Cc: Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Wow, I messed up big time :( For clarity, this patch is not (yet)
signed-off by Wolfram, it's a copy-and-paste mistake on my side.

> > ---
> >   drivers/i2c/busses/Kconfig |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-4.5-rc2.orig/drivers/i2c/busses/Kconfig	2016-02-02 13:36:02.621152859 +0100
> > +++ linux-4.5-rc2/drivers/i2c/busses/Kconfig	2016-02-02 14:06:07.185912775 +0100
> > @@ -490,7 +490,7 @@ config I2C_DESIGNWARE_PCI
> >
> >   config I2C_DESIGNWARE_BAYTRAIL
> >   	bool "Intel Baytrail I2C semaphore support"
> > -	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI
> > +	depends on I2C_DESIGNWARE_PLATFORM && (IOSF_MBI=y || IOSF_MBI=I2C_DESIGNWARE_PLATFORM) && ACPI
> 
> One minor comment: could you split this into two depends on lines in 
> order to avoid long lines?

Certainly. I'll resend the patch with this change after David approves
it.

> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks for the reviews!

-- 
Jean Delvare
SUSE L3 Support
