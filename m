From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: [possible bug] removing i2c busses while /dev/i2c-X is opened
Date: Sun, 14 Jun 2009 16:50:31 +0200
Message-ID: <20090614165031.74673b25@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wm2j/lZHZXxkIS+4u=DO1k2";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--Sig_/wm2j/lZHZXxkIS+4u=DO1k2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

after writing drivers for some home-brew hardware which also has an
i2c bus, I suspect there is a bug in i2c-core causing=20
i2c-dev to access fields of the i2c_adapter struct when the
bus is already removed (but not the corresponding kernel module.

After looking on the sources I found out that in i2c-dev.c
I found out that there seem to be no checks whether the adapter still exists
in the functions accessing the device.
By using i2c_get_adapter() the module is locked so it cannot be unloaded.
So if i2c_del_adapter() is called outside the module exit function,
in some circumstances I i2cdev_ioctl then seems to play around
with the zero addresses. I tortured the bus using
while true; do i2cdetect -y X ; done

Calling i2cdev_check_addr from i2cdev_ioctl seems to be devil in that
case.=20

Another question is when the i2c bus driver can free the i2c_adapter struct.

Backtrace:=20
[<c02d3eb0>] (klist_next+0x0/0xcc) from [<c01ca7dc>] (next_device+0x10/0x24)
 r7:c6e69f0c r6:c021922c r5:c6e69ee0 r4:00000000
[<c01ca7cc>] (next_device+0x0/0x24) from [<c01ca830>] (device_for_each_chil=
d+0x4
0/0x68)
[<c01ca7f0>] (device_for_each_child+0x0/0x68) from [<c0219220>] (i2cdev_che=
ck_ad
dr+0x28/0x34)
 r7:00000036 r6:00000703 r5:0000001b r4:c79ddc00
[<c02191f8>] (i2cdev_check_addr+0x0/0x34) from [<c0219a10>] (i2cdev_ioctl+0=
xd8/0
x198)
[<c0219938>] (i2cdev_ioctl+0x0/0x198) from [<c00ad654>] (vfs_ioctl+0x3c/0x9=
c)
 r5:0000001b r4:c6d79120
[<c00ad618>] (vfs_ioctl+0x0/0x9c) from [<c00add10>] (do_vfs_ioctl+0x184/0x1=
ac)
 r6:c6d79120 r5:0000001b r4:00000003
[<c00adb8c>] (do_vfs_ioctl+0x0/0x1ac) from [<c00add78>] (sys_ioctl+0x40/0x6=
0)
 r6:00000703 r5:fffffff7 r4:c6d79120
[<c00add38>] (sys_ioctl+0x0/0x60) from [<c002a880>] (ret_fast_syscall+0x0/0=
x2c)
 r6:00000000 r5:0000001b r4:0000000b


Greetings
Andreas Kemnade

--Sig_/wm2j/lZHZXxkIS+4u=DO1k2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko1DjcACgkQvUy8S31NDeYnxwCdE6vY4VFfOMD0CmnFgr0bavOd
vokAn3oQilNALANqMBP4f0R7HpYlT6Xm
=f8iJ
-----END PGP SIGNATURE-----

--Sig_/wm2j/lZHZXxkIS+4u=DO1k2--
