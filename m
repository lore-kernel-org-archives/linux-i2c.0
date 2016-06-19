From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: remove __init from i2c_register_board_info()
Date: Sun, 19 Jun 2016 14:15:38 +0200
Message-ID: <20160619121538.GB3072@tetsubishi>
References: <1465343547-19974-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58177 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbcFSMb4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 08:31:56 -0400
Content-Disposition: inline
In-Reply-To: <1465343547-19974-1-git-send-email-mcgrof@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, feng.tang@intel.com, linux-next@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 04:52:27PM -0700, Luis R. Rodriguez wrote:
> As of next-20160607 with allyesconfig we get this linker failure:
>=20
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x21bc0d): Section mismatch in reference from
> the function intel_scu_devices_create() to the function
> .init.text:i2c_register_board_info()
>=20
> This is caused by the fact that intel_scu_devices_create() calls
> i2c_register_board_info() and intel_scu_devices_create() is not
> annotated with __init. This typically involves manual code
> inspection and if one is certain this is correct we would
> just peg intel_scu_devices_create() with a __ref annotation.
>=20
> In this case this would be wrong though as the
> intel_scu_devices_create() call is exported, and used in
> the ipc_probe() on drivers/platform/x86/intel_scu_ipc.c.
> The issue is that even though builtin_pci_driver(ipc_driver)
> is used this just exposes the probe routine, which can occur
> at any point in time if this bus supports hotplug. A race
> can happen between kernel_init_freeable() that calls the init
> calls (in this case registeres the intel_scu_ipc.c driver, and
> later free_initmem(), which would free the i2c_register_board_info().
> If a probe happens later in boot i2c_register_board_info() would
> not be present and we should get a page fault.
>=20
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Applied to for-current, thanks! Do you think this should go to stable?


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZozqAAoJEBQN5MwUoCm27GQP/1ttY6h657MGQP3p/fCdW2Nx
rdJqm5kzPgcRzSHKBk0mNHfRLUm3UUl1mIp6wv/rtjlspA45iy46KsmTqmzpy9nn
PCaLP31WurjuR5zFECl5fOy5vr2p1e4myADKWMIaWPfpR0AbqHz1sDAd92ouns3i
kni+8K6Q9BkUW3JvvCICyeoD6URQoSx14G/gwHbPGhANaj181n7NCsRh5nHyxNGp
6+jjvaa2HFSI3PRhcvaTVXeLxFNn5PUCbVZOKHpPePRYf+wJjpRCopOLptiXA2Zd
E4b/qTFgL8Gxg4G1GWCmdHIq+kUrm1j0/ofqXeFwsd/6SmJlURjm438B/BXojC7P
bEiDxfxkOyQh4EhM1VFrOuY21wbdkHFd5Z8iSwIlXoIw/NwD1ifIty2i4fpgViG4
Yhj4/bHXp9bSX2AY3g0UfeB+jKo58Uhlmf0FOaLhZvQy7IMGSw2ZMMoO5X9yurQW
GyddvKZbGqK0DzuHCo9wp59TQBfOWDbQ7SisCKrAAiQKfLxZDU/XuBck4Ik7OvT1
hsng6Toj3bG8FQpT/A84Dd6Rz7Zy3u1QI6qjCZK5qx3n28CGn0bj1IzkXN3CAvOB
gafLfvADmWgYDmVq5/WuUJapMlOcm+9+C98HGu3S+gF9RJ3KXZW0L9WHtiZYv0F5
DiQ3h4UuoBkdXXsEXKD3
=sbUQ
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
