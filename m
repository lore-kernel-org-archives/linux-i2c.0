From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: fix RX FIFO overrun
Date: Thu, 25 Apr 2013 19:43:48 +0200
Message-ID: <20130425174348.GA3612@the-dreams.de>
References: <alpine.DEB.2.02.1304191859570.17829@localhost>
 <20130422071943.GK1283@intel.com>
 <53398.163.33.213.79.1366630241.squirrel@linux.intel.com>
 <20130422122808.GO1283@intel.com>
 <alpine.DEB.2.02.1304221508050.31571@localhost>
 <20130423163543.GB3228@the-dreams.de>
 <51465.163.33.213.85.1366739082.squirrel@linux.intel.com>
 <20130423182707.GA3649@the-dreams.de>
 <alpine.DEB.2.02.1304241110480.32505@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1304241110480.32505@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 24, 2013 at 11:11:38AM +0100, Josef Ahmad wrote:
> From 8a4773d0c0df6fe2e816ad37fde30a2d90a1ad31 Mon Sep 17 00:00:00 2001
> From: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date: Fri, 19 Apr 2013 17:28:10 +0100
> Subject: [PATCH] i2c-designware: fix RX FIFO overrun
> 
> i2c_dw_xfer_msg() pushes a number of bytes to transmit/receive
> to/from the bus into the TX FIFO.
> For master-rx transactions, the maximum amount of data that can be
> received is calculated depending solely on TX and RX FIFO load.
> 
> This is racy - TX FIFO may contain master-rx data yet to be
> processed, which will eventually land into the RX FIFO. This
> data is not taken into account and the function may request more
> data than the controller is actually capable of storing.
> 
> This patch ensures the driver takes into account the outstanding
> master-rx data in TX FIFO to prevent RX FIFO overrun.
> 
> Signed-off-by: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Still can't apply :( Whitespace problems in the patch context :(
