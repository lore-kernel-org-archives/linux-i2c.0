From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 01/40] i2c: qup: Move bus frequency definitions to
 i2c.h
Date: Tue, 25 Feb 2020 13:56:49 +0200
Message-ID: <20200225115649.GJ10400@smile.fi.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200225102233.GA3677@ninjato>
 <20200225104708.GF10400@smile.fi.intel.com>
 <20200225114400.GC3677@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBYL4u (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 06:56:50 -0500
Content-Disposition: inline
In-Reply-To: <20200225114400.GC3677@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>

On Tue, Feb 25, 2020 at 12:44:01PM +0100, Wolfram Sang wrote:
> > Motivation is simple:
> >  - Standardize the (small) set of mostly used bus frequences
> >  - Get rid of repetition of (subset) of above in many drivers
> >  - Reduce amount of potential typos
> > 
> > Let's discuss it here. I don't think new version of this would be good to have
> > without initial settlement.
> 
> Well, for me, this works. I agree to the typo thing and having less
> magic values. It's all OK; I think it is just nice to have some things
> in a coverletter.

Since it looks like we will have only few patches at the end, I think the
commit message for the first one would be good enough to describe this all.

> > I aware about that, but I would like to avoid I²C subsystem storming for
> > another change like this. So, let's consider this as a trampoline when in the
> > future we will switch entire subsystem to Linux wide header at once.
> 
> I can agree to that.
> 
> > > Furthermore, I'd prefer to
> > > have 'MAX' in there, e.g. I2C_MAX_STANDARD_MODE_FREQ etc. Just to make
> > > clear that I2C can have other bus speeds as well.
> > 
> > Works for me.
> 
> Thanks, that's the most important point to me.
> 
> > Btw, what about Vladimir's comment WRT STANDARD -> STD? My personal opinion
> > that STD is a bit too short.
> 
> No real opinion here. I think STD is understandable enough and I
> encounter it regularly. However, I also don't think the saving is huge
> enough to matter. Your call here.

I prefer STANDARD over STD due to consistency (we don't have good abbreviations
for Fast, Fast+, High Speed, etc, anyway).

> > I'm fine with either. For reviewers it would be better I think to see only
> > their portion. Since I got a lot of tags already I consider I may squash it
> > together. So, what do you prefer?
> 
> Sounds good to me. Keep collecting acks and squash all patches and tags
> in v2.

Good, thanks for review!

-- 
With Best Regards,
Andy Shevchenko
