From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] i2c: versatile: Convert to use resource managed
 devm_* APIs
Date: Fri, 8 Jul 2016 14:44:17 +0100
Message-ID: <20160708134417.GF3784@red-moon>
References: <1460644236.6039.2.camel@ingics.com>
 <1460644306.6039.3.camel@ingics.com>
 <CAFRkauAarcYw6tCvM0_1VL-Wpf_OeLY=LEiR33DnQ1Q+2_C_KQ@mail.gmail.com>
 <1467640573.23717.3.camel@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42878 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486AbcGHNnZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Jul 2016 09:43:25 -0400
Content-Disposition: inline
In-Reply-To: <1467640573.23717.3.camel@arm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-i2c@vger.kernel.org, Axel Lin <axel.lin@ingics.com>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 04, 2016 at 02:56:13PM +0100, Pawel Moll wrote:
> Dnia 2016-06-25, Sat o godzinie 09:41 +0800, Axel Lin pisze:
> > 2016-04-14 22:31 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> > > Use devm_* APIs to simplify the code a bit.
> > > This patch also fixes the memory leak when unload the module.
> > > 
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > > ---
> > > Hi,
> > > I don't have this h/w, I'd appreciate if someone can test this
> > > patch.
> > 
> > Obviously the module unload path has memory leak.
> > Just wondering if anyone can review/test this patch.
> 
> Gentlemen? (referring to the VE maintainers here)
> 
> Original thread: thread.gmane.org/gmane.linux.drivers.i2c/27277

We weren't CC'ed, thanks for the heads-up anyway we will have a
look and test shortly (@Axel next time please CC us if you want
us to test your patches, thanks).

Lorenzo
