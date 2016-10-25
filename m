From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rk3x: Give the tuning value 0 during
 rk3x_i2c_v0_calc_timings
Date: Tue, 25 Oct 2016 11:12:49 +0200
Message-ID: <20161025091249.GB1597@katana>
References: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49162 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbcJYJNG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 05:13:06 -0400
Content-Disposition: inline
In-Reply-To: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, dianders@chromium.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 22, 2016 at 04:43:42PM +0800, David Wu wrote:
> We found a bug that i2c transfer sometimes failed on 3066a board with
> stabel-4.8, the con register would be updated by uninitialized tuning
> value, it made the i2c transfer failed.
>=20
> So give the tuning value to be zero during rk3x_i2c_v0_calc_timings.
>=20
> Signed-off-by: David Wu <david.wu@rock-chips.com>

Added stable and applied to for-current, thanks!


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDyIQAAoJEBQN5MwUoCm2lMUP/i82Id2/URoH8Gh4QxcR6rpk
d/IIEuYFLBjPZfD0iGYxIPH9iabKRTwi+x/c4TgFOA8YU+VybHnzu4ZPQLuIC79l
5jBc+nkwLgwD69iud+V/7EJF3891C29BPx/UarK+HPouF2CnBUhlKhUtGRxun+AG
6/m+lOPZ8CvZnxaU08P+qWM0nkVeSLpooU0vM389sd/uHJ/0FmgU4s6LWuC/yqvg
0wOpXhn4npcT37ApqssKses6MRDCAH1abv8z58zLGDURQZVU50g9D3fOki1pWdQO
7pw0UdnjE2Ix/4v/9R1MZJdox6cRmRD/x8TCNerUE3ChgecNuX0SDpH6lb8/kxT0
vJBSw5U+A53Z6vemnU91VfxFg9o/dNE7hRRgP+T0dnL+BRU6iuUaAErdnk97NDzK
qfpvCEisWeQG0lODuBX16nD1ESgxE+gmPFFyz45ZkNPqmKh2IySNk0mDa4s+wJsD
8AELlo/uxYNZvMy0fOczOpqE3jRsDxD5CPkgQcUAMrV3xA6anleVdpDZBSrPkcHU
MDSLw1aQuZHge7eWet8nFsZwYzcRvelFfX3bn6ac3/W5eNdGyaR5NA/nTREpumA9
fJZsVsNvwEEE4Mobgtv6QjlJj1MPCt6Sdxumb9T5eTPrVdjJCW7jETGr+JwK/y67
kjA5ov2GIT+tKo3S5Qbh
=3kD+
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
