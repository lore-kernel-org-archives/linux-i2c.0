From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Wed, 9 Jan 2008 13:21:28 -0800
Message-ID: <200801091321.29212.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080109142906.23a55f5f@hyperion.delvare>
	<20080109171934.4f894bdc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080109171934.4f894bdc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 09 January 2008, Jean Delvare wrote:
> Here's what I get with CONFIG_LOCKDEP=3Dn:

OK, that's more like I'd expect.  Essentially a self-deadlock:

 - increment usecount on the device

 - call i2c_detach_client(), which waits till usecount falls to zero
   and then frees the device (because this is a legacy driver)

 - expect to *then* be able to decrement the usecount, and continue

Yuck.


> rmmod =A0 =A0 =A0 =A0 D ffffffff804365c0 =A0 =A0 0 =A04198 =A0 4181
> =A0ffff81002db39cd8 0000000000000082 ffff81002d907100 ffff81003f83d7e0
> =A0ffff81003c5d0370 ffff81002db39d08 ffff81002d8408f8 7fffffffffffffff
> =A07fffffffffffffff ffff81002d840a38 0000000000000002 ffff81002db39d58
> Call Trace:
> =A0[<ffffffff80423c15>] schedule_timeout+0x95/0xd0

... the schedule() call, which will be left when someone issues
the completion being waited for ... =


> =A0[<ffffffff802bfa30>] sysfs_remove_dir+0x60/0x80
> =A0[<ffffffff80308029>] kobject_put+0x19/0x20
> =A0[<ffffffff80423a28>] wait_for_common+0xc8/0x130
> =A0[<ffffffff80228330>] default_wake_function+0x0/0x10
> =A0[<ffffffff80423af8>] wait_for_completion+0x18/0x20

... but that completion can never arrive ...

> =A0[<ffffffff803b4fd4>] i2c_detach_client+0x54/0x90
> =A0[<ffffffff882f4071>] :lm90:lm90_detach_client+0x71/0x90
> =A0[<ffffffff803b3fbc>] detach_legacy_clients+0x8c/0xc0
> =A0[<ffffffff803b3f30>] detach_legacy_clients+0x0/0xc0
> =A0[<ffffffff8038cbb3>] device_for_each_child+0x33/0x60

... since this iteration holds the refount it won't yet drop ...

> =A0[<ffffffff803b531c>] i2c_del_driver+0x11c/0x140
> =A0[<ffffffff882f4f00>] :lm90:sensors_lm90_exit+0x10/0x12
> =A0[<ffffffff802501d2>] sys_delete_module+0x132/0x1d0
> =A0[<ffffffff8020b99e>] system_call+0x7e/0x83

Right now I'm thinking that we'll need a multi-phase approach:

(a) Start phasing out users of i2c_client.list and its lock, ASAP;
    merging those DVB driver patches, and some i2c-core changes.

(b) But don't remove that list from the deletion path until ...

(c) ... We have a solution that removes that wait_for_completion()
    and its infrastructure.  (Note the similar i2c_adapter logic
    too, sigh.)

(d) Meanwhile, come up with a different solution to the deadlock
    observed with i2c_adapter.clist ... which for some unknown
    reason has *NOT* shown up for me with lockdep.

Of course, if (c) happens soon soon, this problem simplifies.  And
maybe someone will come up with a non-invasive solution to that
problem ... but if nobody does so before, say, Monday, I'm thinking
that (d) becomes a priority.

- Dave
