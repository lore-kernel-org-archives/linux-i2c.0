From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v6 07/19] i2c: octeon: Use i2c recovery framework
Date: Thu, 21 Apr 2016 19:51:10 +0200
Message-ID: <20160421175110.GA2710@hardcore>
References: <cover.1460387640.git.jglauber@cavium.com>
 <ab24627b5928f23967633243639b431d2113dbe1.1460387640.git.jglauber@cavium.com>
 <20160420213121.GC1546@katana>
 <20160421130835.GA2623@hardcore>
 <20160421135450.GA5566@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0096.outbound.protection.outlook.com ([157.56.110.96]:2149
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751611AbcDURv2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 13:51:28 -0400
Content-Disposition: inline
In-Reply-To: <20160421135450.GA5566@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Thu, Apr 21, 2016 at 03:54:50PM +0200, Wolfram Sang wrote:
> 
> > I assumed this check was bogus and there are no valid 0-length
> > messages...
> 
> They are valid (check SMBUS_QUICK), but not every controller can handle
> them correctly. Your driver has SMBUS_QUICK enabled, so this is a
> contradiction to the check above where it rejects it.

Oops, this mismatch dates back to the inital driver code. From the
documentation I would say SMBUS_QUICK is not supported, although nothing
terrible happens in the write case.

> So, it looks like it needs to be tested again (and documented this
> time). If the HW can't do it, the FUNC bit for QUICK needs to be masked
> out. If it can do SMBUS_QUICK, the check can probably go away.
> 

I would like to disable SMBUS_QUICK. It never worked for the read case.
Could we break something by disabling the quick-write case or is
the quick-write emulated by a larger write if the feature bit is not
set?
