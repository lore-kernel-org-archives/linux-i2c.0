From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 04/15] ipmi_ssif: Remove duplicate NULL check
Date: Thu, 18 Jan 2018 18:46:12 +0200
Message-ID: <1516293972.7000.1098.camel@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
         <20171031142149.32512-4-andriy.shevchenko@linux.intel.com>
         <1516289388.7000.1092.camel@linux.intel.com>
         <9a4c8dda-2a5c-14f3-559f-f4d5260fbdb0@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:55948 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753406AbeARQqR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 11:46:17 -0500
In-Reply-To: <9a4c8dda-2a5c-14f3-559f-f4d5260fbdb0@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: openipmi-developer@lists.sourceforge.net

On Thu, 2018-01-18 at 09:41 -0600, Corey Minyard wrote:
> On 01/18/2018 09:29 AM, Andy Shevchenko wrote:
> > On Tue, 2017-10-31 at 16:21 +0200, Andy Shevchenko wrote:
> > > Since i2c_unregister_device() became NULL-aware we may remove
> > > duplicate
> > > NULL check.
> > 
> > Anyone?
> > 
> > Wolfram, I think if no one picks this soon it's quite safe to push
> > it
> > through i2c tree.
> > 
> 
> I'll pick this up for the next release.

Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
