From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] hwmon: ads7828 optional parameters from the device
 tree
Date: Fri, 24 Mar 2017 11:10:03 -0500
Message-ID: <20170324161003.hv2bqpyspjdkx5j4@rob-hp-laptop>
References: <20170321032434.9268-1-kernel.development@povil.us>
 <20170322084240.xspj432z2mpyzykq@ninjato>
 <20170322130555.wgwrkeju43dvj232@irascible.povil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34595 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935710AbdCXQLC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Mar 2017 12:11:02 -0400
Content-Disposition: inline
In-Reply-To: <20170322130555.wgwrkeju43dvj232@irascible.povil.us>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sam Povilus <kernel.development@povil.us>
Cc: Wolfram Sang <wsa@the-dreams.de>, jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On Wed, Mar 22, 2017 at 07:05:55AM -0600, Sam Povilus wrote:
> On Wed, Mar 22, 2017 at 09:42:40AM +0100, Wolfram Sang wrote:
> > 
> > >  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 --
> > 
> > This file is about to get moved one directory up:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=b7e252fcddfa573bb1ee275b53bba6cef85671d4
> > 
> > Just so you know already...
> > 
> 
> Thanks! I'm a bit new to this, what's the best way for me to handle
> this? Submit against Linus' tree (presumably making a merge nightmare
> for someone) or rebase my branch off robh's (and presumably risking some
> other branch's patch conflicting)?

Send me a separate patch for just this file and I'll pick it up.

Rob
