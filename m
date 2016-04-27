From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v7 09/15] i2c: octeon: Add workaround for broken irqs on
 CN3860
Date: Wed, 27 Apr 2016 11:37:07 +0200
Message-ID: <20160427093707.GA2624@hardcore>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-10-git-send-email-jglauber@cavium.com>
 <20160426211759.GD4587@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426211759.GD4587@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 26, 2016 at 11:17:59PM +0200, Wolfram Sang wrote:
> On Mon, Apr 25, 2016 at 04:33:38PM +0200, Jan Glauber wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > CN3860 does not interrupt the CPU when the i2c status changes. If
> > we get a timeout, and see the status has in fact changed, we know we
> > have this problem, and drop back to polling.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> My code checkers say something:
> 
>     CHECKPATCH
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt
> #37: FILE: drivers/i2c/busses/i2c-octeon.c:390:
> +			udelay(50);
> 
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt
> #70: FILE: drivers/i2c/busses/i2c-octeon.c:529:
> +			udelay(50);
> 
> Dunno if you want to change that? Seems reasonable to me. Also:

Yes, makes sense.

>     SMATCH
> drivers/i2c/busses/i2c-octeon.c:544 octeon_i2c_hlc_wait() warn: inconsistent indenting
> 
> This is true as well.
> 

OK, I'll reply with an updated patch.
