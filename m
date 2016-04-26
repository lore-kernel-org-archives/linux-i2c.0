From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v7 05/15] i2c: octeon: Enable High-Level Controller
Date: Tue, 26 Apr 2016 07:51:22 +0200
Message-ID: <20160426055122.GA5758@hardcore>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-6-git-send-email-jglauber@cavium.com>
 <20160425214429.GE1550@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bon0079.outbound.protection.outlook.com ([157.56.111.79]:22144
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751027AbcDZFvl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 01:51:41 -0400
Content-Disposition: inline
In-Reply-To: <20160425214429.GE1550@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Mon, Apr 25, 2016 at 11:44:29PM +0200, Wolfram Sang wrote:
> On Mon, Apr 25, 2016 at 04:33:34PM +0200, Jan Glauber wrote:
> > From: David Daney <ddaney@caviumnetworks.com>
> > 
> > Use High-Level Controller (HLC) when possible. The HLC can read/write
> > up to 8 bytes and is completely optional. The most important difference
> > of the HLC is that it only requires one interrupt for a transfer
> > (up to 8 bytes) where the low-level read/write requires 2 interrupts
> > plus one interrupt per transferred byte. Since the interrupts are costly
> > using the HLC improves the performance. Also, the HLC provides improved
> > error handling.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> Applied to for-next, thanks!
> 
> I can recommend using --strict with checkpatch. It found some issues:

I thought checkpatch is always strict, but seriously, I didn't know that
option. Thanks for fixing that!

Jan

> total: 0 errors, 0 warnings, 18 checks, 427 lines checked
> 
> CHECK: No space is necessary after a cast
> #327: FILE: drivers/i2c/busses/i2c-octeon.c:563:
> +		ext |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
> 
> I fixed all 14 of those.
> 
> CHECK: braces {} should be used on all arms of this statement
> #325: FILE: drivers/i2c/busses/i2c-octeon.c:561:
> +	if (msgs[0].len == 2) {
> [...]
> +	} else
> [...]
> 
> and 2 of those.
> 
