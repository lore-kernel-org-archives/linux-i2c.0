From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2] i2c: ismt: fix wrong device address when unmap the
 data buffer
Date: Thu, 15 Jun 2017 15:54:44 +0200
Message-ID: <20170615135444.vfl2j75psl63wmtd@ninjato>
References: <1497329993-197698-1-git-send-email-liwei.song@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mat5oul5hnrr5qda"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37398 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdFONyr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Jun 2017 09:54:47 -0400
Content-Disposition: inline
In-Reply-To: <1497329993-197698-1-git-send-email-liwei.song@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Song liwei <liwei.song@windriver.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>


--mat5oul5hnrr5qda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 12:59:53AM -0400, Song liwei wrote:
> From: Liwei Song <liwei.song@windriver.com>
>=20
> Fix the following kernel bug:
>=20
> kernel BUG at drivers/iommu/intel-iommu.c:3260!
> invalid opcode: 0000 [#5] PREEMPT SMP
> Hardware name: Intel Corp. Harcuvar/Server, BIOS HAVLCRB0.X64.0013.D39.16=
08311820 08/31/2016
> task: ffff880175389950 ti: ffff880176bec000 task.ti: ffff880176bec000
> RIP: 0010:[<ffffffff8150a83b>]  [<ffffffff8150a83b>] intel_unmap+0x25b/0x=
260
> RSP: 0018:ffff880176bef5e8  EFLAGS: 00010296
> RAX: 0000000000000024 RBX: ffff8800773c7c88 RCX: 000000000000ce04
> RDX: 0000000080000000 RSI: 0000000000000000 RDI: 0000000000000009
> RBP: ffff880176bef638 R08: 0000000000000010 R09: 0000000000000004
> R10: ffff880175389c78 R11: 0000000000000a4f R12: ffff8800773c7868
> R13: 00000000ffffac88 R14: ffff8800773c7818 R15: 0000000000000001
> FS:  00007fef21258700(0000) GS:ffff88017b5c0000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000066d6d8 CR3: 000000007118c000 CR4: 00000000003406e0
> Stack:
>  00000000ffffac88 ffffffff8199867f ffff880176bef5f8 ffff880100000030
>  ffff880176bef668 ffff8800773c7c88 ffff880178288098 ffff8800772c0010
>  ffff8800773c7818 0000000000000001 ffff880176bef648 ffffffff8150a86e
> Call Trace:
>  [<ffffffff8199867f>] ? printk+0x46/0x48
>  [<ffffffff8150a86e>] intel_unmap_page+0xe/0x10
>  [<ffffffffa039d99b>] ismt_access+0x27b/0x8fa [i2c_ismt]
>  [<ffffffff81554420>] ? __pm_runtime_suspend+0xa0/0xa0
>  [<ffffffff815544a0>] ? pm_suspend_timer_fn+0x80/0x80
>  [<ffffffff81554420>] ? __pm_runtime_suspend+0xa0/0xa0
>  [<ffffffff815544a0>] ? pm_suspend_timer_fn+0x80/0x80
>  [<ffffffff8143dfd0>] ? pci_bus_read_dev_vendor_id+0xf0/0xf0
>  [<ffffffff8172b36c>] i2c_smbus_xfer+0xec/0x4b0
>  [<ffffffff810aa4d5>] ? vprintk_emit+0x345/0x530
>  [<ffffffffa038936b>] i2cdev_ioctl_smbus+0x12b/0x240 [i2c_dev]
>  [<ffffffff810aa829>] ? vprintk_default+0x29/0x40
>  [<ffffffffa0389b33>] i2cdev_ioctl+0x63/0x1ec [i2c_dev]
>  [<ffffffff811b04c8>] do_vfs_ioctl+0x328/0x5d0
>  [<ffffffff8119d8ec>] ? vfs_write+0x11c/0x190
>  [<ffffffff8109d449>] ? rt_up_read+0x19/0x20
>  [<ffffffff811b07f1>] SyS_ioctl+0x81/0xa0
>  [<ffffffff819a351b>] system_call_fastpath+0x16/0x6e
>=20
> This happen When run "i2cdetect -y 0" detect SMBus iSMT adapter.
>=20
> After finished I2C block read/write, when unmap the data buffer,
> a wrong device address was pass to dma_unmap_single().
>=20
> To fix this, give dma_unmap_single() the "dev" parameter, just like
> what dma_map_single() does, then unmap can find the right devices.
>=20
> Fixes: 13f35ac14cd0 ("i2c: Adding support for Intel iSMT SMBus 2.0 host c=
ontroller")
> Signed-off-by: Liwei Song <liwei.song@windriver.com>

Applied to for-current, thanks!


--mat5oul5hnrr5qda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllCkaQACgkQFA3kzBSg
KbYnXBAAjr0kIisR0e892kRSsfctkv0L44uFwaBDlJUtYQl1+2lJ/+Cs8QmX30sF
aislmVeiw/WuREgzSZl2isx/2SE286E67wrM9zhQP3iBDPq1B1ZsW6voUUOixfQg
CnAHoD/twzCppB7xqiK1wzR/tJ4lR+dAcqmC+T0ev0bAU0f5KvGw0RKjXwKIThkU
LB24OoT+grnPxvBKSkssKLMpG7qIQTZLEjPYJwn13zgGJkBft3Sx0N+pCisNOLgl
iPTwL48Dh3RLayM8MR4xb/Vpji1qB1rRtXvmPp414fLjkejwW47PBUrXhf9OsWDg
rsqmsCXHuHwmTbEHrURDAkBIlzi/D5iLwsK43P5cP/oAI3uztf0tI3v7AD1YpT47
fkDHZmreiJjuTlz97Ypd71jphOxaOO/im1vGbPm8m6ACq5iDWnu0o98/ZcmLu+Sh
X5ax6pakVvOj1/PepFcNqVsRqC9EFgZx14KNjdVCsX9Ul0I8QiX7KlPL3aHMipun
XTTqIIERkI1w3i85VTONk43UgUxvogZtyK8t86qmLJ/y6cASklVfaXmh/gUDRO/e
7T8sSGFNRfH3Yrj16zkaTuv4Mwk73DAGnSkNI3UPTyXsEy2Uv0UFaEZlyL6oeZqy
f68vy8AKjnIA7OvBxEB3TfSjEYW+/kI2E+XD4NVdDWs7F2qkDi0=
=qy5i
-----END PGP SIGNATURE-----

--mat5oul5hnrr5qda--
