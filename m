From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: qup: skip qup_i2c_suspend if the device is already
 runtime suspended
Date: Thu, 22 Sep 2016 20:09:28 +0200
Message-ID: <20160922180928.GG1861@katana>
References: <1472124219-1627-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472124219-1627-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-i2c@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 12:23:39PM +0100, Sudeep Holla wrote:
> If the i2c device is already runtime suspended, if qup_i2c_suspend is
> executed during suspend-to-idle or suspend-to-ram it will result in the
> following splat:
>=20
> WARNING: CPU: 3 PID: 1593 at drivers/clk/clk.c:476 clk_core_unprepare+0x8=
0/0x90
> Modules linked in:
>=20
> CPU: 3 PID: 1593 Comm: bash Tainted: G        W       4.8.0-rc3 #14
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> PC is at clk_core_unprepare+0x80/0x90
> LR is at clk_unprepare+0x28/0x40
> pc : [<ffff0000086eecf0>] lr : [<ffff0000086f0c58>] pstate: 60000145
> Call trace:
>  clk_core_unprepare+0x80/0x90
>  qup_i2c_disable_clocks+0x2c/0x68
>  qup_i2c_suspend+0x10/0x20
>  platform_pm_suspend+0x24/0x68
>  dpm_run_callback.isra.7+0x1c/0x70
>  __device_suspend+0xf4/0x298
>  dpm_suspend+0x10c/0x228
>  dpm_suspend_start+0x68/0x78
>  suspend_devices_and_enter+0xb8/0x460
>  pm_suspend+0x1ec/0x240
>  state_store+0x84/0xf8
>  kobj_attr_store+0x14/0x28
>  sysfs_kf_write+0x48/0x58
>  kernfs_fop_write+0x15c/0x1f8
>  __vfs_write+0x1c/0x100
>  vfs_write+0x9c/0x1b8
>  SyS_write+0x44/0xa0
>  el0_svc_naked+0x24/0x28
>=20
> This patch fixes the issue by executing qup_i2c_pm_suspend_runtime
> conditionally in qup_i2c_suspend.
>=20
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied to for-current, thanks!


--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5B5XAAoJEBQN5MwUoCm22XAP/RBI+bIkm/ALTYICOF61I+C1
TRyd+Jhove9e7ELCrAtsDNhjc5svv4LYjtMYLJbVYo/jXNuSzzmA4Rs78pyjiDg5
Jz1XDdHus1PlHmLyd52G7WgN73iuMwukbBp9lG9nXu5LkA+++VZRS6kKHN/SPrnL
PRKJnhmBlrGXKMdMXx9XMyQkg9f5d04omIPx+le3hjN9VCX9/1EGG560I9SSdk+y
OzzBOQdxLz38qsWMElePn894776izOGcbdwmFheGagGmJH3e0zjWvaIZ4Q+xQjBs
8vQwoL7SmsMNbAKfqMqc5wKHXZwfjwwIBaGTZgT30FkDFZAr2G4de3LcjYHmHQed
90m/Ol+wPqIwoqQwBwx3Fibu2qk9c/FtlDM0rSgrN2yb1gxfhbdkwJnHi1fyT449
aun33S/paDUjIDekNl1ajiE7o3DmbuA4RJM6cYMTPMhsvPlciihsKTimJ4lNaCSh
vP4s1qLPEsh03+p9E4ydRo6xRam0SRMRGv/HruDrH0ZFl0y9uPMsyCswMt/3IpUi
MgP5+ECf2dJ0tCLfhKYmS6jI1rGVQq9RYa+ge49aSEfmjQOXEjRa9HsGo3QnOhbA
7kFRir6S2PUraFi+P1bWQzarRlgGv14IdDNruE/derPM/FYA3e2xZcQ/BzHDmaZ3
hLbOuZzo6GKhCIei/XHm
=Fyv1
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
