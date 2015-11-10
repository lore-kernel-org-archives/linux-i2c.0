From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] platform/chrome: Fix i2c-designware adapter name
Date: Mon, 9 Nov 2015 19:43:59 -0800
Message-ID: <20151110034359.GA11607@localhost>
References: <1446548940-19739-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20151103184959.GA4215@newt.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35725 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbKNFQQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 14 Nov 2015 00:16:16 -0500
Received: by pacej9 with SMTP id ej9so13310012pac.2
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2015 21:16:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151103184959.GA4215@newt.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dudley Du <dudl@cypress.com>, linux-i2c@vger.kernel.org

On Tue, Nov 03, 2015 at 10:49:59AM -0800, Jeremiah Mahler wrote:
> Jarkko,
> 
> On Tue, Nov 03, 2015 at 01:09:00PM +0200, Jarkko Nikula wrote:
> > Commit d80d134182ba ("i2c: designware: Move common probe code into
> > i2c_dw_probe()") caused the I2C adapter lookup code here to fail for PCI
> > enumerated i2c-designware because commit changed the adapter name but
> > didn't update it here.
> > 
> > Fix the I2C adapter lookup by using the "Synopsys DesignWare I2C adapter"
> > name.
> > 
> > Reported-by: Jeremiah Mahler <jmmahler@gmail.com>
> > Fixes: d80d134182ba ("i2c: designware: Move common probe code into i2c_dw_probe()")
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > ---
> > Hi Jeremiah. This is the same diff I had in a reply to your bug report.
> > Can you test does this fix work for you as I don't have the HW.
> > ---
> >  drivers/platform/chrome/chromeos_laptop.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
> > index 02072749fff3..2b441e9ae593 100644
> > --- a/drivers/platform/chrome/chromeos_laptop.c
> > +++ b/drivers/platform/chrome/chromeos_laptop.c
> > @@ -47,8 +47,8 @@ static const char *i2c_adapter_names[] = {
> >  	"SMBus I801 adapter",
> >  	"i915 gmbus vga",
> >  	"i915 gmbus panel",
> > -	"i2c-designware-pci",
> > -	"i2c-designware-pci",
> > +	"Synopsys DesignWare I2C adapter",
> > +	"Synopsys DesignWare I2C adapter",
> >  };
> >  
> >  /* Keep this enum consistent with i2c_adapter_names */
> > -- 
> > 2.6.2
> > 
> 
> Yes, this patch fixes the problem.
> 
> Tested-by: Jeremiah Mahler <jmmahler@gmail.com>

Thanks, applied!


-Olof
