From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 2/2] i2c: versatile: Convert to use resource managed
 devm_* APIs
Date: Mon, 04 Jul 2016 14:56:13 +0100
Message-ID: <1467640573.23717.3.camel@arm.com>
References: <1460644236.6039.2.camel@ingics.com>
	 <1460644306.6039.3.camel@ingics.com>
	 <CAFRkauAarcYw6tCvM0_1VL-Wpf_OeLY=LEiR33DnQ1Q+2_C_KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47854 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbcGDN4S (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jul 2016 09:56:18 -0400
In-Reply-To: <CAFRkauAarcYw6tCvM0_1VL-Wpf_OeLY=LEiR33DnQ1Q+2_C_KQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-i2c@vger.kernel.org, Axel Lin <axel.lin@ingics.com>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org

Dnia 2016-06-25, Sat o godzinie 09:41 +0800, Axel Lin pisze:
> 2016-04-14 22:31 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> > Use devm_* APIs to simplify the code a bit.
> > This patch also fixes the memory leak when unload the module.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> > Hi,
> > I don't have this h/w, I'd appreciate if someone can test this
> > patch.
> 
> Obviously the module unload path has memory leak.
> Just wondering if anyone can review/test this patch.

Gentlemen? (referring to the VE maintainers here)

Original thread: thread.gmane.org/gmane.linux.drivers.i2c/27277

Thanks!

Pawel
