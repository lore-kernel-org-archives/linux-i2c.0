From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ARM: mach-shmobile: add INTCS macros
Date: Wed, 7 Apr 2010 16:32:03 +0900
Message-ID: <20100407073203.GA17971@linux-sh.org>
References: <20100311100526.15227.50813.sendpatchset@t400s> <20100311065233.31275.37948.sendpatchset@t400s> <20100311053030.26699.955.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100311100526.15227.50813.sendpatchset@t400s> <20100311065233.31275.37948.sendpatchset@t400s> <20100311053030.26699.955.sendpatchset@t400s>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nishimoto.hiroki-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 11, 2010 at 02:30:30PM +0900, Magnus Damm wrote:
> Add SH-Mobile ARM INTCS macros for the INTCS controller.

On Thu, Mar 11, 2010 at 03:52:33PM +0900, Magnus Damm wrote:
> Add support for the sh7367 INTCS interrupt controller.
> 
> INTCS is the interrupt controller for the sh7367 SuperH
> processor core. It is tied into the INTCA interrupt
> controller which interfaces to the ARM processor.
> 
> INTCS support is implemented using a new INTC table
> together with a chained interrupt handler that ties
> into the already supported INTCA controller.

On Thu, Mar 11, 2010 at 07:05:26PM +0900, Magnus Damm wrote:
> i2c: i2c-sh_mobile update for SH-Mobile ARM
> 
> [PATCH 01/03] i2c: i2c-sh_mobile register access code break out
> [PATCH 02/03] i2c: i2c-sh_mobile support for new ICIC bits
> [PATCH 03/03] i2c: i2c-sh_mobile kconfig update for SH-Mobile ARM
> 
> These patches add support for a newer version of the IIC block
> to the i2c-sh_mobile and enables the driver on SH-Mobile ARM.
> 
Applied, thanks.
