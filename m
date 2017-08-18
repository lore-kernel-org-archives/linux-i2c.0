From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 0/2] i2c: {sh_mobile,rcar}: Trivial fixes of smatch
 warnings
Date: Fri, 18 Aug 2017 07:24:33 +0200
Message-ID: <20170818052433.GA23131@vmlxhi-102.adit-jv.com>
References: <20170815203624.19274-1-erosca@de.adit-jv.com>
 <20170817155020.wuhcsuc4m5wx56rc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:51613 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdHRFYq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Aug 2017 01:24:46 -0400
Content-Disposition: inline
In-Reply-To: <20170817155020.wuhcsuc4m5wx56rc@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, erosca@de.adit-jv.com, linux-i2c@vger.kernel.org


On Thu, Aug 17, 2017 at 05:50:20PM +0200, Wolfram Sang wrote:
> Hi Eugeniu,
> 
> > These simple fixes make smatch happy.
> 
> Ah, thanks! I use smatch, too, but always compile with DEBUG, so this
> went unnoticed.
> 
> > Thanks for taking them into account.
> 
> Sure, I just dropped the fixes tags. Thanks for supplying those, but
> fixing smatch warnings is not enough reason to go back to stable
> releases unless it fixes a real bug.

Hi Wolfram,

Feedback is very appreciated.
Including "Fixes:" line is just a habit. Feel free to drop it.

Many thanks,
Eugeniu.

> 
> Regards,
> 
>    Wolfram
> 
