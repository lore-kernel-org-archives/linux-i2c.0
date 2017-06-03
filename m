From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] i2c: designware: do not show SDA hold time warning when
 not needed
Date: Sat, 3 Jun 2017 15:18:21 +0200
Message-ID: <20170603151821.736e6236@free-electrons.com>
References: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
        <1492502087.24567.47.camel@linux.intel.com>
        <20170418095939.68788787@free-electrons.com>
        <7b011e1e-8fa3-07c4-6688-5e258fd64dbd@linux.intel.com>
        <20170602201502.yobk7f7sdp34ez3d@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59959 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFCNSf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 3 Jun 2017 09:18:35 -0400
In-Reply-To: <20170602201502.yobk7f7sdp34ez3d@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Fri, 2 Jun 2017 22:15:02 +0200, Wolfram Sang wrote:
> > hardware that doesn't support SDA hold time. But needless spamming have
> > negative value so this is worth to fix. (I would do this as a single liner
> > by else if ()).
> > 
> > Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>  
> 
> I agree with Jarkko on everything, including the 'else if' fix.

I am not sure to understand what Jarkko suggested to fix, besides using
"else if" in one line. Could you be more specific about the changes you
expect me to do?

Andy suggested to turn the warning into a debug message, to which I
objected, and my understanding was that Jarkko agreed with me that a
warning message was better, and only made the suggestion of the "else
if".

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
