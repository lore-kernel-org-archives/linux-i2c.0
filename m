From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] Frame buffers and early i2c
Date: Tue, 10 Jun 2008 12:18:53 +0200
Message-ID: <20080610121853.26b4d432@hyperion.delvare>
References: <200806091647.42757.u.luckas@road.de>
	<200806092359.36080.u.luckas@road.de>
	<20080610082527.0e6d643a@hyperion.delvare>
	<200806101131.19763.u.luckas@road.de>
	<20080610100249.GA30539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760905AbYFJKTd@vger.kernel.org>
In-Reply-To: <20080610100249.GA30539@fluff.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben@fluff.org>
Cc: Uli Luckas <u.luckas@road.de>, David Brownell <david-b@pacbell.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, adaplas@gmail.com, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 10 Jun 2008 11:02:50 +0100, Ben Dooks wrote:
> On Tue, Jun 10, 2008 at 11:31:19AM +0200, Uli Luckas wrote:
> > Just changing the initcall to subsys really did the trick. I thought, this was 
> > the first thing I tried and I thought it crashed my device. But obviousely I 
> > had some other problem.
> > If Russell gives his Ack, could this be pushed upstream through i2c?
> 
> Does this work if the code is built as a module?

subsys_initcall degrades to module_init in modules, so Uli's patch
doesn't change anything in that case.

> BTW, if people do have these sort of dependencies, then modules
> are another way of sorting out the load order, unless you have
> the module autoload enabled.

-- 
Jean Delvare
