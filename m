From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Tue, 26 Apr 2016 14:34:44 +0200
Message-ID: <20160426123444.GB9796@hardcore>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-4-git-send-email-jglauber@cavium.com>
 <20160425221621.GI1550@katana>
 <20160426055845.GB5758@hardcore>
 <20160426064242.GC5758@hardcore>
 <20160426073620.GA1543@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0064.outbound.protection.outlook.com ([207.46.100.64]:18752
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751082AbcDZMe7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 08:34:59 -0400
Content-Disposition: inline
In-Reply-To: <20160426073620.GA1543@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Tue, Apr 26, 2016 at 09:36:20AM +0200, Wolfram Sang wrote:
> 
> > > Yes, I thought briefly about splitting SMBUS_QUICK into read-write
> > > variants too. To me the question is if this feature is still used on modern
> > > devices or if this is more a relict of the past. I don't know enough
> > > about SMBUS to answer that.
> 
> Well, note that there are zero-length messages in I2C allowed as well.
> Not only in SMBUS. I mainly use the term SMBUS_QUICK because it covers
> both cases.
> 
> 
> > Checking on ThunderX:
> ...
> > Do all these other numbers make sense (although there are no
> > devices)?
> 
> It makes sense in a way that it shows SMBUS_QUICK_WRITE is broken :) It
> doesn't react to ACK/NACK properly. So, what needs to be done:
> 
> 1) remove SMBUS_QUICK as you did in this patch 2) move the length check
> so it doesn't only check read messages but also write messages. That is
> to prevent handling custom setup I2C messages with a length of 0 (which
> is legal). I'd suggest to return -EOPNOTSUPP in this case.

OK, I'll do that. Should I rebase the remaining patches or would you
like to review them first ? :)

Thanks,
Jan

> Thanks,
> 
>    Wolfram
> 
