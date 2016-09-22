From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] Fix warnings for i2c-rk3x.c
Date: Thu, 22 Sep 2016 19:52:25 +0200
Message-ID: <20160922175224.GD1861@katana>
References: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50186 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940146AbcIVRwp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Sep 2016 13:52:45 -0400
Content-Disposition: inline
In-Reply-To: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, dianders@chromium.org, huangtao@rock-chips.com, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2016 at 07:29:22PM +0800, David Wu wrote:
> David Wu (2):
>   i2c: rk3x: Fix sparse warning
>   i2c: rk3x: fix variable 'min_total_ns' unused warning
>=20

Applied to for-next, thanks!


--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5BpYAAoJEBQN5MwUoCm2vMoP/AsVxS31e91s05zivRt4VShE
4qDOyW4BHw7D+D8+KJHrdnMPwt7RgUyZskjSn2H+asTfq4R7XIBwYVLfnc0j1zJe
5BOWQd+n5w6XO6ZN3Rw2eyOowvBiQ4Xdfe7IqmUHPhpe+QmsYb+U90YAb0pL24wI
f4A47EaaP3HSmzKr/u/2r5NTZmdo6OJxmrNPsQqPfERnjQ32Pw8+ibdUfR1ayhOC
fi91btgtjoCUcEFSOAZQbPiTFt/0Lq1FAMnu13PcZBJfFYjOpOtdN5nYFBJzKVVl
vVPWt9gLhxN0TgZbScLhhKv3KSR1s5+wCnbbbWpv4hQHiFCSL9CQn4aSzSwTAOvQ
aVQ1WNwvU5BcjJVk94LbD2dOQK0+Zr3ItqcxOC7ESp8WmMzFCcAMy7YZ5zop9EVU
pgR0/mrJFPYtqeKnIyuMjdDHDxjiarBsDYZIz4w66z9l6gzI+5aJ9zKEJIMf91ic
jRUrmCl4Z77LQWg+IYrdDXeECwWFBEdPf2i5rqLv4OpveNqoYi5MmoaC8vZIqQVW
r6Cw3kH5BS99V5LESyqph3z1qADOQUi8rv6ZGsWwtuNa7ydpJOrtSZzp951+fWg6
JalL1lPN5GhwN7DgZTAw9PGe078bUBVhZWh5OGNXGzEQmzagyHXpEYOX9LUA+R5z
pJIEQYjz05Ee1dB0xv0E
=Pg1D
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
