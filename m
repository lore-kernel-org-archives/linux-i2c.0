From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: pnx: fix warnings caused by enabling unprepared
 clock
Date: Fri, 23 Oct 2015 22:21:06 +0200
Message-ID: <20151023202106.GF1520@katana>
References: <1445107947-2888-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36739 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbbJWUVK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 16:21:10 -0400
Content-Disposition: inline
In-Reply-To: <1445107947-2888-1-git-send-email-vz@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Vitaly Wool <vitalywool@gmail.com>, linux-i2c@vger.kernel.org


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2015 at 09:52:27PM +0300, Vladimir Zapolskiy wrote:
> If common clock framework is configured, the driver generates a warning,
> which is fixed by this change:
>=20
>     WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:727 clk_core_enable+0x2c/=
0xa4()
>     Modules linked in:
>     CPU: 0 PID: 1 Comm: swapper Not tainted 4.3.0-rc2+ #171
>     Hardware name: LPC32XX SoC (Flattened Device Tree)
>     Backtrace:
>     [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
>     [<>] (show_stack) from [<>] (dump_stack+0x20/0x28)
>     [<>] (dump_stack) from [<>] (warn_slowpath_common+0x90/0xb8)
>     [<>] (warn_slowpath_common) from [<>] (warn_slowpath_null+0x24/0x2c)
>     [<>] (warn_slowpath_null) from [<>] (clk_core_enable+0x2c/0xa4)
>     [<>] (clk_core_enable) from [<>] (clk_enable+0x24/0x38)
>     [<>] (clk_enable) from [<>] (i2c_pnx_probe+0x108/0x2a8)
>     [<>] (i2c_pnx_probe) from [<>] (platform_drv_probe+0x50/0xa0)
>     [<>] (platform_drv_probe) from [<>] (driver_probe_device+0x18c/0x408)
>     [<>] (driver_probe_device) from [<>] (__driver_attach+0x70/0x94)
>     [<>] (__driver_attach) from [<>] (bus_for_each_dev+0x74/0x98)
>     [<>] (bus_for_each_dev) from [<>] (driver_attach+0x20/0x28)
>     [<>] (driver_attach) from [<>] (bus_add_driver+0x11c/0x248)
>     [<>] (bus_add_driver) from [<>] (driver_register+0xa4/0xe8)
>     [<>] (driver_register) from [<>] (__platform_driver_register+0x50/0x6=
4)
>     [<>] (__platform_driver_register) from [<>] (i2c_adap_pnx_init+0x18/0=
x20)
>     [<>] (i2c_adap_pnx_init) from [<>] (do_one_initcall+0x11c/0x1dc)
>     [<>] (do_one_initcall) from [<>] (kernel_init_freeable+0x10c/0x1d4)
>     [<>] (kernel_init_freeable) from [<>] (kernel_init+0x10/0xec)
>     [<>] (kernel_init) from [<>] (ret_from_fork+0x14/0x24)
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Applied to for-next with your updated commit message, thanks!


--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKpayAAoJEBQN5MwUoCm2ID8P/AiAlvxujxgtZUDfnUwwfYy0
F6dsRm4JPZmpFOY02bXpsRHASMjSc+vpE+/9QlQV8zs9lbbzaGXKp1Zlg5XXkw2l
1y0o5ZMXVHz8iYai2mYN56cFiC7/kMv8iXU2ICVrSOetLVzAyn78psVL33WkMOVx
NsceqjOlklcarqRMn+H7slizWbiJ7Gr3OHI1I/6hr9s4lyzOiUSFZyCrHdlj0Inh
DV+j4r387cye0VdBBF/F/Qkh4fGk+/glaBpMJizArDZ0q60vW+lESwudXwU1d0xf
4g7ijLpJqe+J5yk2f1U64+utGCG1WisCyoRG20Ya+V48zY9MR1V12lCWjvmsHeeM
IZlb5Ug4DS/4umz9QVQnKeIl7Ijx9uoMTMuXxawDamDlLYhc9cU5J12la266kPCk
3+5sLgCcED0mwdiU9l7+o5jaGRkrl4B6BCsjO3xuLMnZNj/YobE5TlJE0+q6l3uC
1YZy7qzSP5yXdCeNgMQxtR1jMgBtSzLD6xSE4qLvSBFsngtUP/1IRo6BrhIVyP6h
pM4pt8icjxKFwDwE9i4qI58OM3WAVwMsjveMI1g1OxfWdaOyA2nK4s+2AHl+v/Wp
AXmDVzrk6Mmb5NhiQwnU/cn0BhbiwGYwjow2OD59IIf/Asd6rt3m3014NLYl4RmX
PU+wqLHCjY3/em1mWkaK
=DndA
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
