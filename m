From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in i2c_del_adapter
Date: Wed, 14 Jan 2015 15:54:52 +0200
Message-ID: <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113152957.GL7660@katana> <20150114144938.4e3c3f52@endymion.delvare>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150114144938.4e3c3f52-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> On Jan 14, 2015, at 15:49 , Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
>=20
> Hi Wolfram, Pantelis,
>=20
> On Tue, 13 Jan 2015 16:29:57 +0100, Wolfram Sang wrote:
>> On Mon, Jan 12, 2015 at 07:00:50PM +0200, Pantelis Antoniou wrote:
>>> Waiting for the device release method to be called when
>>> going through i2c_del_adapter is wrong and leads to deadlock
>>> when removing an i2c mux device.
>>=20
>> Adding Jean to the list, maybe he knows more details from the past.
>>=20
>>> For instance when using the OF i2c mux unitest removal we get this.
>=20
> I can't parse the sentence above, sorry. What is "unitest=E2=80=9D?
>=20

The DT overlay patchset contains a number of OF unitests for its featur=
es.

One of the new tests is performing a runtime insertion and removal of a=
n i2c mux containing
an i2c device on one of the channels.

When removing the mux device we get a deadlock.

>>> [<c055dfdc>] (__schedule) from [<c0561b74>] (schedule_timeout+0x18/=
0x198)
>>> [<c0561b74>] (schedule_timeout) from [<c055ee74>] (wait_for_common+=
0xf8/0x138)
>>> [<c055ee74>] (wait_for_common) from [<c03f724c>] (i2c_del_adapter+0=
x174/0x1cc)
>>> [<c03f724c>] (i2c_del_adapter) from [<c03f8480>] (i2c_del_mux_adapt=
er+0x48/0x60)
>>> [<c03f8480>] (i2c_del_mux_adapter) from [<c046cf00>] (selftest_i2c_=
mux_remove+0x28/0x34)
>>> [<c046cf00>] (selftest_i2c_mux_remove) from [<c03f5234>] (i2c_devic=
e_remove+0x34/0x70)
>>> [<c03f5234>] (i2c_device_remove) from [<c03322ec>] (__device_releas=
e_driver+0x7c/0xc0)
>>> [<c03322ec>] (__device_release_driver) from [<c0332968>] (driver_de=
tach+0x8c/0xb4)
>>> [<c0332968>] (driver_detach) from [<c0332088>] (bus_remove_driver+0=
x64/0x8c)
>>> [<c0332088>] (bus_remove_driver) from [<c07f1858>] (of_selftest+0x1=
f84/0x20f0)
>>> [<c07f1858>] (of_selftest) from [<c0008b04>] (do_one_initcall+0x104=
/0x1b4)
>>> [<c0008b04>] (do_one_initcall) from [<c07c4d9c>] (kernel_init_freea=
ble+0x110/0x1d8)
>>> [<c07c4d9c>] (kernel_init_freeable) from [<c05591ec>] (kernel_init+=
0x8/0xe4)
>>> [<c05591ec>] (kernel_init) from [<c000deb8>] (ret_from_fork+0x14/0x=
3c)
>>> 2 locks held by swapper/0/1:
>>> #0:  (&dev->mutex){......}, at: [<c0332944>] driver_detach+0x68/0xb=
4
>>> #1:  (&dev->mutex){......}, at: [<c0332954>] driver_detach+0x78/0xb=
4
>>> Kernel panic - not syncing: hung_task: blocked tasks
>>> CPU: 0 PID: 16 Comm: khungtaskd Not tainted 3.19.0-rc4-00022-g26164=
7c #443
>>> Hardware name: Generic AM33XX (Flattened Device Tree)
>>> [<c00140a8>] (unwind_backtrace) from [<c00110dc>] (show_stack+0x10/=
0x14)
>>> [<c00110dc>] (show_stack) from [<c055c3ac>] (dump_stack+0x70/0x8c)
>>> [<c055c3ac>] (dump_stack) from [<c055ad10>] (panic+0x88/0x1f0)
>>> [<c055ad10>] (panic) from [<c00adef8>] (watchdog+0x2d4/0x350)
>>> [<c00adef8>] (watchdog) from [<c004e984>] (kthread+0xd8/0xec)
>>> [<c004e984>] (kthread) from [<c000deb8>] (ret_from_fork+0x14/0x3c)
>>>=20
>>> The device release method is never called and we hang waiting for i=
t.
>>>=20
>>> This patch is marked as an [RFC] since the original code seems to
>>> really want to protect against a race from sysfs accessors, which
>>> I don't see how it could be a problem.
>=20
> The code is not from me, it's from Greg KH. It was written in August
> 2003 when Greg converted the i2c subsystem to somewhat fit into the
> (then) new device driver model. So that was a long time ago and it is
> possible that this is no longer necessary. FWIW I can't see anything
> similar in other subsystems.
>=20
> In fact I'm not sure what purpose the completion serves exactly. I
> expected it to delay the i2c adapter removal until no sysfs user of i=
t
> was left (as the comment suggests.) However I just tested unloading a=
n
> i2c bus driver while its adapter's new_device attribute was opened an=
d
> rmmod returned immediately. So it doesn't look like accessing sysfs
> attributes actually takes a reference to the underlying i2c_adapter.
>=20

That=E2=80=99s what got me stumped too. I haven=E2=80=99t seen somethin=
g like this before.

> That being said, nobody complained about this in 11 years, so I would
> be surprised if it was plain wrong. I'd rather question the test code=
=2E
> Where is it?
>=20

No-one has apparently tested removing an i2c mux device on a running sy=
stem
before.

It=E2=80=99s in a new patchset I posted earlier.

Search for "of: unitest: Add I2C overlay unit tests.=E2=80=9D

https://www.mail-archive.com/devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg57577.html

> --=20
> Jean Delvare
> SUSE L3 Support

Regards

=E2=80=94 Pantelis
