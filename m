From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [crash, bisected] I2C,
	kobject (ffff81003e8c4160): tried to	init an initialized object
Date: Thu, 17 Jul 2008 11:59:44 +0200
Message-ID: <20080717095944.GA2097@elte.hu>
References: <20080714224945.629446fa@hyperion.delvare>
	<20080716082352.GA30483@elte.hu>
	<20080716110702.3ca61eb2@hyperion.delvare>
	<20080716120801.3e9b4c80@hyperion.delvare>
	<20080716141826.1d88d05e@hyperion.delvare>
	<20080717092655.GA6115@elte.hu> <20080717093329.GA20032@elte.hu>
	<20080717094858.GA18687@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080717094858.GA18687-QDJVlCTZ4KWTKS93B3g+7KFoa47nwP16@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Alexey Dobriyan <adobriyan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: john stultz <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Ulrich Drepper <drepper-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


* Alexey Dobriyan <adobriyan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Jul 17, 2008 at 11:33:30AM +0200, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org> wrote:
> > 
> > > Jean,
> > > 
> > > -tip testing found another (similar) i2c crash with latest -git, on a 
> > > Core2Duo laptop:
> > > 
> > > calling  nforce2_init+0x0/0x1b
> > > initcall nforce2_init+0x0/0x1b returned 0 after 0 msecs
> > > calling  nforce2_s4985_init+0x0/0x275
> > > BUG: unable to handle kernel NULL pointer dereference at 0000000c
> > > IP: [<c04af2cf>] i2c_smbus_xfer+0x27/0x3f0
> > > *pdpt = 00000000009cb001 *pde = 0000000000000000 
> > > Oops: 0000 [#1] SMP 
> > 
> > turning off I2C_NFORCE2_S4985 makes the system boot up fine. Workaround 
> > patch below.
> 
> Well, it's pretty easy oops unless I misread something.
> It happened on not nforce2 motherboard, right?

yeah.

> nforce2_init will just register PCI driver,
> no matching PCI ids => nforce2_set_reference() isn't called =>
> nforce2_smbus stays NULL.
> 
> Second module loads and tries to i2c_smbus_xfer(NULL, ) in module_init()
> hook which oopses.

can try patches, but got other 5 fresh upstream oopses/hangs/crashes to 
investigate now. (so i went for the minimal-effort 
turn-off-the-failing-part approach)

	Ingo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
