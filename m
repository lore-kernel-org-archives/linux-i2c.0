From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: fix NULL pointer dereference under race
 condition
Date: Fri, 4 Nov 2016 20:42:26 +0100
Message-ID: <20161104194226.GA1478@katana>
References: <1477943184-3419-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38733 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753178AbcKDTmj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 4 Nov 2016 15:42:39 -0400
Content-Disposition: inline
In-Reply-To: <1477943184-3419-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2016 at 09:46:24PM +0200, Vladimir Zapolskiy wrote:
> Race condition between registering an I2C device driver and
> deregistering an I2C adapter device which is assumed to manage that
> I2C device may lead to a NULL pointer dereference due to the
> uninitialized list head of driver clients.
>=20
> The root cause of the issue is that the I2C bus may know about the
> registered device driver and thus it is matched by bus_for_each_drv(),
> but the list of clients is not initialized and commonly it is NULL,
> because I2C device drivers define struct i2c_driver as static and
> clients field is expected to be initialized by I2C core:
>=20
>   i2c_register_driver()             i2c_del_adapter()
>     driver_register()                 ...
>       bus_add_driver()                ...
>         ...                           bus_for_each_drv(..., __process_rem=
oved_adapter)
>       ...                               i2c_do_del_adapter()
>     ...                                   list_for_each_entry_safe(..., &=
driver->clients, ...)
>     INIT_LIST_HEAD(&driver->clients);
>=20
> To solve the problem it is sufficient to do clients list head
> initialization before calling driver_register().
>=20
> The problem was found while using an I2C device driver with a sluggish

That one must have been really sluggish :)

> registration routine on a bus provided by a physically detachable I2C
> master controller, but practically the oops may be reproduced under
> the race between arbitraty I2C device driver registration and managing
> I2C bus device removal e.g. by unbinding the latter over sysfs:
>=20
> % echo 21a4000.i2c > /sys/bus/platform/drivers/imx-i2c/unbind
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
>   Internal error: Oops: 17 [#1] SMP ARM
>   CPU: 2 PID: 533 Comm: sh Not tainted 4.9.0-rc3+ #61
>   Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>   task: e5ada400 task.stack: e4936000
>   PC is at i2c_do_del_adapter+0x20/0xcc
>   LR is at __process_removed_adapter+0x14/0x1c
>   Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>   Control: 10c5387d  Table: 35bd004a  DAC: 00000051
>   Process sh (pid: 533, stack limit =3D 0xe4936210)
>   Stack: (0xe4937d28 to 0xe4938000)
>   Backtrace:
>   [<c0667be0>] (i2c_do_del_adapter) from [<c0667cc0>] (__process_removed_=
adapter+0x14/0x1c)
>   [<c0667cac>] (__process_removed_adapter) from [<c0516998>] (bus_for_eac=
h_drv+0x6c/0xa0)
>   [<c051692c>] (bus_for_each_drv) from [<c06685ec>] (i2c_del_adapter+0xbc=
/0x284)
>   [<c0668530>] (i2c_del_adapter) from [<bf0110ec>] (i2c_imx_remove+0x44/0=
x164 [i2c_imx])
>   [<bf0110a8>] (i2c_imx_remove [i2c_imx]) from [<c051a838>] (platform_drv=
_remove+0x2c/0x44)
>   [<c051a80c>] (platform_drv_remove) from [<c05183d8>] (__device_release_=
driver+0x90/0x12c)
>   [<c0518348>] (__device_release_driver) from [<c051849c>] (device_releas=
e_driver+0x28/0x34)
>   [<c0518474>] (device_release_driver) from [<c0517150>] (unbind_store+0x=
80/0x104)
>   [<c05170d0>] (unbind_store) from [<c0516520>] (drv_attr_store+0x28/0x34)
>   [<c05164f8>] (drv_attr_store) from [<c0298acc>] (sysfs_kf_write+0x50/0x=
54)
>   [<c0298a7c>] (sysfs_kf_write) from [<c029801c>] (kernfs_fop_write+0x100=
/0x214)
>   [<c0297f1c>] (kernfs_fop_write) from [<c0220130>] (__vfs_write+0x34/0x1=
20)
>   [<c02200fc>] (__vfs_write) from [<c0221088>] (vfs_write+0xa8/0x170)
>   [<c0220fe0>] (vfs_write) from [<c0221e74>] (SyS_write+0x4c/0xa8)
>   [<c0221e28>] (SyS_write) from [<c0108a20>] (ret_fast_syscall+0x0/0x1c)
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Good catch! Applied to for-current, thanks!


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYHOSiAAoJEBQN5MwUoCm2jbsP/1X6t4v3n0V2WaVCdDnYZC1A
PG0iczyVavyRBjsKwlhBndDqdG8zDW4d+VqluB8clZzEVyKfS7ChYUD/8O9v5BBO
eg2zYYKaXVYjMdO9lU6lN+Oqx5/L/3O7tAgWUw9CjCyMdhnlxqRgqS1og+0lMo0n
iCjkgx4Yl3nLAdwjFYs1iXg8uFw5m9beKaPGOSFlRZCn49S4Yorp22P4VPKItU8A
e9vcjVn3mjG1gtU36YLgHU7sV+RLMEHatcOjC/EQsDgIn8erQDgIhewg4Y4SJkfl
IDTBb5Vd9mb0IVLGfTbvAx4G7WQzvnsTzppdfqYrqcAtYqVLQ/OnHxSEf1PKkwiR
WWtL6m13EaTGRxQ5fUqkv42S3OBrSAr1PSJ3+ftDJj68Bv3mLykDTUMjOmAuA+kE
cS9K8rRzpHWY6nUgjXrgDgqKkPPYYRq3IV/vkyqwSEp4qTcoBsZ8t/xbljdy7egS
3/+fnFsI+aV8tJY9Kwmi0/KojBfP005ocMCJwvwnK37uRDbcrTtQV048WPEiHYEG
omggu/WuBTlzrCakV/PAHGrT0yGBfZ2MPnsrP+ZNEIi+4eLhzhWaxx8d05FMM+MF
Ntm4VyGmTWNK3cx8txY6FVEr23kUh58oTL+medVxOeDxrz6KeP6C+jRKIbjYXYEy
5J51JJNnLBKd6xvG5pIW
=DlqH
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
