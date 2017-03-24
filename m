From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5] hwmon: ads7828 optional parameters from the device
 tree
Date: Fri, 24 Mar 2017 12:55:26 -0700
Message-ID: <20170324195526.GA28270@roeck-us.net>
References: <20170321032434.9268-1-kernel.development@povil.us>
 <20170322084240.xspj432z2mpyzykq@ninjato>
 <20170322130555.wgwrkeju43dvj232@irascible.povil.us>
 <20170324161003.hv2bqpyspjdkx5j4@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39960 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbdCXTza (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Mar 2017 15:55:30 -0400
Content-Disposition: inline
In-Reply-To: <20170324161003.hv2bqpyspjdkx5j4@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sam Povilus <kernel.development@povil.us>, Wolfram Sang <wsa@the-dreams.de>, jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On Fri, Mar 24, 2017 at 11:10:03AM -0500, Rob Herring wrote:
> On Wed, Mar 22, 2017 at 07:05:55AM -0600, Sam Povilus wrote:
> > On Wed, Mar 22, 2017 at 09:42:40AM +0100, Wolfram Sang wrote:
> > > 
> > > >  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 --
> > > 
> > > This file is about to get moved one directory up:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=b7e252fcddfa573bb1ee275b53bba6cef85671d4
> > > 
> > > Just so you know already...
> > > 
> > 
> > Thanks! I'm a bit new to this, what's the best way for me to handle
> > this? Submit against Linus' tree (presumably making a merge nightmare
> > for someone) or rebase my branch off robh's (and presumably risking some
> > other branch's patch conflicting)?
> 
> Send me a separate patch for just this file and I'll pick it up.
> 
Agreed, that seems to be the best approach.

Thanks,
Guenter
