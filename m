From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 0/6] initialize dtsi file and dts file for RK3328 SoCs
Date: Thu, 30 Mar 2017 17:05:57 +0200
Message-ID: <20170330150557.znttalrsxpnmccx6@ninjato>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t3raypotlh7kogkn"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490607650-18650-1-git-send-email-cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang@rock-chip
List-Id: linux-i2c@vger.kernel.org


--t3raypotlh7kogkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 05:40:45PM +0800, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org wrote:
> From: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>=20
> Changes in v4:
>     Remove some assigned-clocks as they should be inited in their
>     respective device nodes.
>=20
> Changes in v3:
>     Adjust some descriptions in dtsi.
>=20
> Changes in v2:
>     Remove RK_FUNC_* in dtsi as it dose not help understand things better.
>     Adjust the order of description in dt-bindings.
>=20
> v1:
> These patchs depend on pinctrl patchs as below:

Why didn't you renumber the patches? I and probably others wondered
where and what patch 2 is and why it could be missing. I recall now that
I applied it already. Other maintainers don't have that knowledge. Also,
since I applied your patch, no need for me or the i2c-list to be on CC.

Please no "quick fixes" when sending out patch series. I know it is
tempting but it usually creates confusion.


--t3raypotlh7kogkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljdHtUACgkQFA3kzBSg
KbbzJw/+NWUSFD9p+NewJsQ4meU2Lruf1wjsyLTvZDtWkdSCSq7EIlrLsOxO6g7E
4ntxCrdpSsIXszhwLumzCkVtqVPtiXKxSUei3JQFiDmS1fPol6r9ab5p1S+mVakl
rgK7NCXsYL+BwZtUdZ/VTBnu2xmOETD2IdvvuYLBnSkmARmOEXHPIYszJj0C5DnE
SJo73LkZ8uLrLhdp8gEDXEm8Iag507OPFr+PuZgKMjHoFruAmIFg4awan0AKskjs
Re0o46PV1oOybp64+CszmLD8sDJE9c7pvRjzYxLi9hPAY22Dybgnt95jYahHcn+J
lUrD/M6WuNbKDziecRkbGPWpwRojttLLCfPstCVk+WCEHW+3kAl1LMaWeh6ILw/t
p0KNc+xaYd9CUs1/0pjc8OWJEQRaudJHNQ5JeHPYcV8M1SuJoE/MSOfrrW589NBM
nN3qTY0WJWYX5HJoWqXyPR+/sfiWwkhuLopgiGZSYnk7qbl4n/UGjiv8NCYHpifm
57GIwkn48phYLVWNRMyLwwe/x7+JLrDxM6ItvL6HGkfb3MlQEMyxY0Ooky9xnCV8
7MjNdIUZdyD6g4BDz7brTV7tbVBoJuozjmO/ha+jBqSfpay4hHs8gfx+U/PafklF
dZxhEAuYqVjU4oGg/OdZwANj2izeRstKt1AalFrdrAWEoUoxVuk=
=4ZYN
-----END PGP SIGNATURE-----

--t3raypotlh7kogkn--
