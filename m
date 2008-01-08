From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Tue, 8 Jan 2008 11:12:46 -0800
Message-ID: <200801081112.46972.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080108151817.35e05c6c@hyperion.delvare>
	<20080108172001.33de6afc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080108172001.33de6afc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 08 January 2008, Jean Delvare wrote:
> Hi David,
> 
> On Tue, 8 Jan 2008 15:18:17 +0100, Jean Delvare wrote:
> > On Sun, 6 Jan 2008 11:30:31 -0800, David Brownell wrote:
> > > Though I was a bit worried it might have bugs in it, since all I had
> > > time to do was code it, and sanity check it with a couple variants of
> > > one new-style config.  (I no longer have those monster "build all I2C
> > > drivers" configs around.)
> > 
> > I'll give it good testing, don't worry too much about that.
> 
> Hmm, I get a lockup when removing any legacy chip driver or any bus
> driver with legacy clients attached. 

Lockup?  More details ...


> It seems to remove the 1st client 
> (no longer visible in sysfs) but never goes on with the second one.
> 
> Call Trace:
>   [<ffffffff802bdbd1>] sysfs_addrm_finish+0x191/0x1e0

What's it doing at that line in the call?

>   [<ffffffff8041bca5>] schedule_timeout+0x95/0xd0

This looks like stack garbage...

>   [<ffffffff802bdc50>] remove_dir+0x30/0x40
>   [<ffffffff802bdcb6>] sysfs_remove_dir+0x56/0x70
>   [<ffffffff8041bab8>] wait_for_common+0xc8/0x130
>   [<ffffffff80227e40>] default_wake_function+0x0/0x10
>   [<ffffffff80386e55>] device_del+0x1b5/0x290
>   [<ffffffff803ae4ce>] i2c_detach_client+0x4e/0x90
>   [<ffffffff882f0071>] :lm90:lm90_detach_client+0x71/0xa0
>   [<ffffffff803ae8ff>] detach_all_clients+0x6f/0xb0
>   [<ffffffff803ae890>] detach_all_clients+0x0/0xb0
>   [<ffffffff8038674d>] device_for_each_child+0x2d/0x60
>   [<ffffffff803af315>] i2c_del_adapter+0xa5/0x140
>   [<ffffffff8800b285>] :i2c_parport:i2c_parport_detach+0x55/0x110
>   [<ffffffff88000796>] :parport:parport_unregister_driver+0x46/0x80
>   [<ffffffff8024f001>] sys_delete_module+0x141/0x1e0
>   [<ffffffff8020b92e>] system_call+0x7e/0x83
> 
> Are you certain that it is safe to remove a device's child while
> walking the list of children?

As you point out below, it's supposed to be safe ...


> device_for_each_child() relies on a 
> klist_iter, and the documentation of klist_next mentions increasing the
> reference count of the "active" list item. I would guess that you can't
> remove a list item while its reference count is not zero, and that
> would explain the lockup. The original code used list_for_each_safe(),
> which explicitly allows the removal of the items while walking the list.
> 
> OTOH the header comment of lib/klist.c says:
> 
>  *	The entire point is to provide an interface for iterating over a list
>  *	that is safe and allows for modification of the list during the
>  *	iteration (e.g. insertion and removal), including modification of the
>  *	current node on the list.
> 
> So it is supposed to work somehow...

Yeah, but then again ... the i2c stack does that oddball stuff with
complete(&client->released) for legacy drivers, too.  That's always
been contrary to what the driver model expects, and I never quite
bothered to sort out the issues.  Maybe this is one of them (sigh).

- Dave
