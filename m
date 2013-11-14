From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: exynos5: Remove incorrect clk_disable_unprepare
Date: Thu, 14 Nov 2013 18:19:13 +0100
Message-ID: <20131114171913.GC11022@katana>
References: <1383730758-1771-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383730758-1771-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2013 at 03:09:18PM +0530, Sachin Kamat wrote:
> clk_disable_unprepare in remove causes an imbalance and hence gives
> the below crash on module remove. While at it also remove some
> duplicate code from probe.
>=20
> / $ rmmod i2c-exynos5
> [    6.996374] ------------[ cut here ]------------
> [    6.999523] WARNING: CPU: 2 PID: 1137 at drivers/clk/clk.c:842 clk_dis=
able+0x18/0x24()
> [    7.007403] Modules linked in: i2c_exynos5(-)
> [    7.011747] CPU: 2 PID: 1137 Comm: rmmod Not tainted 3.12.0-next-20131=
105-00083-g16f4799-dirty #21
> [    7.020696] [<c0014e0c>] (unwind_backtrace+0x0/0xf4) from [<c0011784>]=
 (show_stack+0x10/0x14)
> [    7.029190] [<c0011784>] (show_stack+0x10/0x14) from [<c037acd4>] (dum=
p_stack+0x7c/0xb0)
> [    7.037255] [<c037acd4>] (dump_stack+0x7c/0xb0) from [<c001e0ac>] (war=
n_slowpath_common+0x6c/0x88)
> [    7.046190] [<c001e0ac>] (warn_slowpath_common+0x6c/0x88) from [<c001e=
164>] (warn_slowpath_null+0x1c/0x24)
> [    7.055818] [<c001e164>] (warn_slowpath_null+0x1c/0x24) from [<c02dcde=
4>] (clk_disable+0x18/0x24)
> [    7.064670] [<c02dcde4>] (clk_disable+0x18/0x24) from [<bf0002d4>] (ex=
ynos5_i2c_remove+0x1c/0x34 [i2c_exynos5])
> [    7.074736] [<bf0002d4>] (exynos5_i2c_remove+0x1c/0x34 [i2c_exynos5]) =
=66rom [<c02274a8>] (__device_release_driver+0x58/0xb0)
> [    7.085836] [<c02274a8>] (__device_release_driver+0x58/0xb0) from [<c0=
227b88>] (driver_detach+0xac/0xb0)
> [    7.095291] [<c0227b88>] (driver_detach+0xac/0xb0) from [<c02271c0>] (=
bus_remove_driver+0x4c/0xa0)
> [    7.104227] [<c02271c0>] (bus_remove_driver+0x4c/0xa0) from [<c00725dc=
>] (SyS_delete_module+0x124/0x194)
> [    7.113682] [<c00725dc>] (SyS_delete_module+0x124/0x194) from [<c000e2=
e0>] (ret_fast_syscall+0x0/0x30)
> [    7.122957] ---[ end trace 23bb6e4e0bf52196 ]---
> [    7.127591] ------------[ cut here ]------------
> [    7.132187] WARNING: CPU: 2 PID: 1137 at drivers/clk/clk.c:751 clk_unp=
repare+0x14/0x1c()
> [    7.140259] Modules linked in: i2c_exynos5(-)
> [    7.144560] CPU: 2 PID: 1137 Comm: rmmod Tainted: G        W    3.12.0=
-next-20131105-00083-g16f4799-dirty #21
> [    7.154493] [<c0014e0c>] (unwind_backtrace+0x0/0xf4) from [<c0011784>]=
 (show_stack+0x10/0x14)
> [    7.163006] [<c0011784>] (show_stack+0x10/0x14) from [<c037acd4>] (dum=
p_stack+0x7c/0xb0)
> [    7.171052] [<c037acd4>] (dump_stack+0x7c/0xb0) from [<c001e0ac>] (war=
n_slowpath_common+0x6c/0x88)
> [    7.179984] [<c001e0ac>] (warn_slowpath_common+0x6c/0x88) from [<c001e=
164>] (warn_slowpath_null+0x1c/0x24)
> [    7.189616] [<c001e164>] (warn_slowpath_null+0x1c/0x24) from [<c02ddcc=
4>] (clk_unprepare+0x14/0x1c)
> [    7.198639] [<c02ddcc4>] (clk_unprepare+0x14/0x1c) from [<bf0002dc>] (=
exynos5_i2c_remove+0x24/0x34 [i2c_exynos5])
> [    7.208876] [<bf0002dc>] (exynos5_i2c_remove+0x24/0x34 [i2c_exynos5]) =
=66rom [<c02274a8>] (__device_release_driver+0x58/0xb0)
> [    7.219978] [<c02274a8>] (__device_release_driver+0x58/0xb0) from [<c0=
227b88>] (driver_detach+0xac/0xb0)
> [    7.229434] [<c0227b88>] (driver_detach+0xac/0xb0) from [<c02271c0>] (=
bus_remove_driver+0x4c/0xa0)
> [    7.238369] [<c02271c0>] (bus_remove_driver+0x4c/0xa0) from [<c00725dc=
>] (SyS_delete_module+0x124/0x194)
> [    7.247824] [<c00725dc>] (SyS_delete_module+0x124/0x194) from [<c000e2=
e0>] (ret_fast_syscall+0x0/0x30)
> [    7.257104] ---[ end trace 23bb6e4e0bf52197 ]---
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJShQYRAAoJEBQN5MwUoCm2ZWwQAJvMBQ+gtzh2VB8DiVJAQcIc
VlWLHoiOGAW3WciyD9lAF1NDF2aT/D6ufihYsFZ/xiHS7Ga0bCxs3q1X++i93be2
VTDK/qPldXeDSL0mHeYMnZc9Z0es+nzd803AWjxe62duDdY4Z9KrAoNM8lRMFcQ6
DLRXpbEFFTGVID/q0bQ2OycfvXTRAgII7YNdzGLRx/a33a/6wk7DKrWYcqsL07+6
ZiBHfZos516hOmUtnT7+d13Goax9VXlPeJ2yIuYlD2RhOwvY5nPMvCDJmH5O7uPF
Phqh8iVM/yq8d1IxuzoZAGawFbpXa51exWzzrhZglWvxoCgZ97EFI6VzR9QTjR1K
V+xblCiMqiWWq6Cpn0I1+je1HZao4I9dHxEqbumIi0EJuPb0KQLWa8x+wb4AN9iQ
bAtO2q57kcTIkU/JPyAUuYeW9WGpRGtsyZGPZyCmNw3hKvhOvav2suHVUGgeI9T8
2RV3oNGH+7ZgOO9HKTmPEc+yPFXLOY0yMphYMK7BqIj9aQu961WYcG3dFQCdHbXi
f0/NFxclX06fI8S0V8QUAM3CwB97nw/S6Wf8Ff8ffeoQZqfRCBjLYdFhysPzfcqO
Oa+18IoLkL2qBfXsX04zDq1Bi5ekmCSTd4jq88pUXrvbM8p31lwGLWJ4jbmuL6wb
DWAORpXS9gNnVNZVDODg
=MweB
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
