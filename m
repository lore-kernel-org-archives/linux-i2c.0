From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/4] drivers/staging/lirc: Remove obsolete cleanup for
 clientdata
Date: Tue, 25 Jan 2011 08:49:30 +0100
Message-ID: <20110125084930.6d87161a@endymion.delvare>
References: <1295865880-27672-1-git-send-email-w.sang@pengutronix.de>
	<1295865880-27672-4-git-send-email-w.sang@pengutronix.de>
	<1295914142.2420.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295914142.2420.29.camel@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 24 Jan 2011 19:09:02 -0500, Andy Walls wrote:
> On Mon, 2011-01-24 at 11:44 +0100, Wolfram Sang wrote:
> > A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> > on exit or error. This is obsolete meanwhile, the core will do it. Simplify the
> > kfree() calls after that, the pointers don't need to be checked.
> > 
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> > Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
> 
> Nak.
> 
> In a module where I plan to do more cleanup and add reference counting
> to struct IR, IR_tx, and IR_rx objects, I'd like the explicit "NULL"s in
> pointer checks to stay in for now.
> 
> Removing the explicit constant "NULL" makes searching for checks against
> NULL pointers more difficult when auditing the code (No red syntax
> highlighting and a /NULL search misses).

I agree that Wolfram was too generous with his clean-ups this time.
Wolfram, you should only be removing the calls to i2c_set_clientdata(x,
NULL), not changing the logic of the code.

Furthermore, lirc_zilog is currently undergoing heavy changes, I'd
rather let Andy and Jarod work on that staging driver, and clean up
what needs to be later.

-- 
Jean Delvare
