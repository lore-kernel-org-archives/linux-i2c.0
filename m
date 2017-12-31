From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v1] i2c: ismt: Use %pad specifier for dma_addr_t variables
Date: Sun, 31 Dec 2017 10:48:52 -0500
Message-ID: <20171231154852.GA20616@neilslaptop.think-freely.org>
References: <20171110183358.86100-1-andriy.shevchenko@linux.intel.com>
 <1514474511.7000.422.camel@linux.intel.com>
 <20171230232201.fzh6l4tqxvvagyi4@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40207 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdLaPtp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 31 Dec 2017 10:49:45 -0500
Content-Disposition: inline
In-Reply-To: <20171230232201.fzh6l4tqxvvagyi4@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Seth Heasley <seth.heasley@intel.com>, linux-i2c@vger.kernel.org

On Sun, Dec 31, 2017 at 12:22:01AM +0100, Wolfram Sang wrote:
> On Thu, Dec 28, 2017 at 05:21:51PM +0200, Andy Shevchenko wrote:
> > On Fri, 2017-11-10 at 20:33 +0200, Andy Shevchenko wrote:
> > > ...which takes care of proper format and size of the value.
> > 
> > Wolfram, any comment on this?
> 
> I was leaving this for the driver maintainers, but well, this is an easy
> one, so...
> 
> > 
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Applied to for-next, thanks!
> 


Sorry for the delay, I was on holiday.  FWIW
Acked-by: Neil Horman <nhorman@tuxdriver.com>
