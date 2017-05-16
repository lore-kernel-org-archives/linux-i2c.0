From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/2] i2c: mv64xxx: propagate the return value of
 platform_get_irq()
Date: Tue, 16 May 2017 23:34:44 +0200
Message-ID: <20170516233444.6620935e@free-electrons.com>
References: <1494936445-27331-1-git-send-email-thomas.petazzoni@free-electrons.com>
        <1494936445-27331-2-git-send-email-thomas.petazzoni@free-electrons.com>
        <20170516212812.brbmsqjvntwgjcgd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55695 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbdEPVeq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 May 2017 17:34:46 -0400
In-Reply-To: <20170516212812.brbmsqjvntwgjcgd@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>

Hello,

On Tue, 16 May 2017 23:28:12 +0200, Wolfram Sang wrote:
> On Tue, May 16, 2017 at 02:07:25PM +0200, Thomas Petazzoni wrote:
> > platform_get_irq() returns an error code, so instead of inventing our
> > own error code (-ENXIO), return the one provided by
> > platform_get_irq(). Most notably, this allows an -EPROBE_DEFER
> > returned by platform_get_irq() to be propagate as the return value of  
> > ->probe(), which allows deferred probing of the interrupt controller.  
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>  
> 
> Thanks! I squashed the two commits into one because then I can count it
> as a bugfix and apply it to for-current. I hope you are fine with this.

Sounds good to me. Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
