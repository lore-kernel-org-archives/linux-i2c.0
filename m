From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 3/5] i2c: mux: pca954x: Drop useless validation for
 optional GPIO descriptor
Date: Fri, 6 Mar 2020 11:56:15 +0200
Message-ID: <20200306095615.GR1224808@smile.fi.intel.com>
References: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
 <20200305155352.39095-3-andriy.shevchenko@linux.intel.com>
 <3a0bd56d-0efb-e1cf-c050-05deefc4433a@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:53557 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgCFJ4O (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Mar 2020 04:56:14 -0500
Content-Disposition: inline
In-Reply-To: <3a0bd56d-0efb-e1cf-c050-05deefc4433a@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Thu, Mar 05, 2020 at 09:19:05PM +0000, Peter Rosin wrote:
> On 2020-03-05 16:53, Andy Shevchenko wrote:
> > There is no need to perform a check for optional GPIO descriptor.
> > If it's NULL, the API can handle it correctly.
> 
> But, the removed test is not only (needlessly) protecting the optional
> descriptor, it also shortcuts the udelays. I think it is valid to
> skip those pointless udelays when no reset is happening anyway. Not
> that it matters all that much when the delays are as short as this, but
> I simply think it looks sensible to skip the delays when that are not
> needed.

Perhaps moving it to a helper where we may leave the check.

> So, I do not think this change is an improvement.

I have no strong opinion, I simple will drop it then.
Thank you for review!

-- 
With Best Regards,
Andy Shevchenko
