From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Thu, 22 Oct 2015 14:43:35 +0300
Message-ID: <20151022114335.GL1526@lahna.fi.intel.com>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
 <20151020151935.GH5379@katana>
 <20151022082755.GK1526@lahna.fi.intel.com>
 <20151022110325.GA1572@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37053 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbbJVLnj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 07:43:39 -0400
Content-Disposition: inline
In-Reply-To: <20151022110325.GA1572@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, tbrandonau@gmail.com, eddi@depieri.net, galandilias@gmail.com

On Thu, Oct 22, 2015 at 01:03:25PM +0200, Wolfram Sang wrote:
> 
> > > > Please review and let me know required changes in order to get this upstream
> > > > finally.
> > > > 
> > > > Eddi, Thomas, it would be great if you could verify the changes on your
> > > > machines.
> > > 
> > > Yes, additional tests are always good for a patch series
> > > 
> > > Asking the Intel guys for help, I have not much expierence with x86
> > > platforms... Mika, Jarkko, Andy any chance to help?
> > 
> > Unfortunately I don't have hardware this old to test on :-/
> 
> And visual review? (That's what I need to do mostly, too)

Sure.

I don't have a copy of these patches but I went ahead and looked them up
from archives. Christian can you Cc me on next iteration?

Mostly they look good to me. Few comments though.

Patch 2/4: should we remove adapter in reverse order?

Patch 3/4: some stylistic issues, like:
	- ERROR label should not be in capital letters actually it is
	  not needed at all if you do unlock and return -EBUSY if
	  request_region() fails.
	- Block comment style

In addition I'm not sure if requesting io region for each transfer is
good idea. Can't we just request it once for this driver and handle the
necessary serialization using the mutex?
