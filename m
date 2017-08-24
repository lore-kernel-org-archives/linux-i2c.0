From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] i2c: designware: add i2c gpio recovery option
Date: Thu, 24 Aug 2017 14:59:55 +0300
Message-ID: <1503575995.25945.82.camel@linux.intel.com>
References: <1497598977-37622-1-git-send-email-preid@electromag.com.au>
         <c81a485d-b9da-fd64-c3ae-25fcf8744f80@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58691 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbdHXL76 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Aug 2017 07:59:58 -0400
In-Reply-To: <c81a485d-b9da-fd64-c3ae-25fcf8744f80@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On Thu, 2017-08-24 at 17:21 +0800, Phil Reid wrote:
> On 16/06/2017 15:42, Phil Reid wrote:
> > Changes from V1:
> > - In review Andy suggested change the i2c core to use the gpiod
> >    I've added a patch that allows the gradual switching of drivers
> >    to using gpiod interface. The old interface is preserved so
> >    that changes can be made incrementally.
> > - I've update Tim's patch for the designware driver to use the new
> >    interface. Tweaked a couple of things to his patch and fixed
> >    up things Andy id in last review.
> >    The core changes in p1 don't require the get/set scl/sda
> > functions.
> >    Hopefully I've done the right thing with preserving authorship
> > and
> >    signoff.
> > 
> > Phil Reid (1):
> >    i2c: Switch to using gpiod interface for gpio bus recovery
> > 
> > Tim Sander (1):
> >    i2c: designware: add i2c gpio recovery option
> > 
> >   drivers/i2c/busses/i2c-designware-core.c    | 12 ++++--
> >   drivers/i2c/busses/i2c-designware-core.h    |  1 +
> >   drivers/i2c/busses/i2c-designware-platdrv.c | 58
> > +++++++++++++++++++++++++++++
> >   drivers/i2c/i2c-core-base.c                 | 22 +++++++++--
> >   include/linux/i2c.h                         |  2 +
> >   5 files changed, 88 insertions(+), 7 deletions(-)
> > 
> 
> Ping:
> 
> Any comments on these 2 patches?

Oops, overloaded. I will do latest next week. I would like to massage a
bit this and see the result.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
