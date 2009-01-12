From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] Incremental i2c-mpc driver fix for multi-master i2c
 busses.
Date: Mon, 12 Jan 2009 14:12:00 -0800
Message-ID: <20090112141200.ca89caab.akpm@linux-foundation.org>
References: <20090105132102.GA27855@clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090105132102.GA27855-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 5 Jan 2009 14:21:02 +0100
Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org> wrote:

> Incremental i2c-mpc driver fix for multi-master i2c busses.
> 
> This is an incremental bugfix for the i2c-mpc driver. It is based
> on the bugfix I've sent on 2008-12-22:
> 
> 	http://lkml.org/lkml/2008/12/22/99
> 
> There still was a remaining problem with multi-master i2c busses
> when an i2c bus access is interrupted by a unix signal while
> waiting for bus arbitration.
> 
> This is an extreamly rare case but I managed to stumble over it in
> multi master i2c performance tests.
> 
> Tested with a freescale MPC8349E host cpu.

That's not a very good changelog - it has basically no information,
apart from the linked-to original changelog.

And the linked-to changelog has no description of the bug which is
being fixed.

> --- drivers/i2c/busses/i2c-mpc.c	(revision 2216)
> +++ drivers/i2c/busses/i2c-mpc.c	(working copy)

Please prepare patches in `patch -p1' form:

--- a/drivers/i2c/busses/i2c-mpc.c
+++ a/drivers/i2c/busses/i2c-mpc.c
