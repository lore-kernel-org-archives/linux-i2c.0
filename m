From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
Date: Wed, 11 Sep 2013 14:24:06 +0300
Message-ID: <20130911112406.GB7393@intel.com>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
 <20130910213522.GG29403@sirena.org.uk>
 <2029393.u6DaKBPszu@vostro.rjw.lan>
 <522FC0DC.9030708@intel.com>
 <20130911095552.GI29403@sirena.org.uk>
 <20130911110543.GA7393@intel.com>
 <20130911111409.GO29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130911111409.GO29403@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 11, 2013 at 12:14:09PM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2013 at 02:05:43PM +0300, Mika Westerberg wrote:
> 
> > I'll also look into converting the existing I2C client drivers to use this
> > method. One question, though, is it better to have the conversion in the
> > same patch that introduces the I2C core runtime PM change or as a separate
> > patch?
> 
> In theory it ought to be part of the same patch but in practice a brief
> bit of bisection breakage on a single branch is probably worth the ease
> of review from my point of view, others may disagree though.

OK, I'll keep them separate, unless there are objections.

> Like I say I think you'll need to convert SPI at the same time due to the
> devices with both buses sharing code.

Yes, I'm looking into that :)
