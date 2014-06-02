From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: fix the i2c bus hang issue when do repeat
 restart
Date: Mon, 2 Jun 2014 17:54:52 +0200
Message-ID: <20140602155451.GD2654@katana>
References: <1398839098-6907-1-git-send-email-B38611@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398839098-6907-1-git-send-email-B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: b20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 02:24:58PM +0800, Fugang Duan wrote:
> Test i2c device Maxim max44009, datasheet is located at:
> http://www.maximintegrated.com/datasheet/index.mvp/id/7175
>=20
> The max44009 support repeat operation like:
> read -> repeat restart -> read/write
>=20
> The current i2c imx host controller driver don't support this
> operation that causes i2c bus hang due to "MTX" is cleared in
> .i2c_imx_read(). If "read" is the last message there have no problem,
> so the current driver supports all SMbus operation like:
> write -> repeat restart -> read/write
>=20
> IMX i2c controller for master receiver has some limitation:
> - If it is the last byte for one operation, it must generate STOP
>   signal before read I2DR to prevent controller from generating another
>   clock cycle.
> - If it is the last byte in the read, and then do repeat restart, it must
>   set "MTX" before read I2DR to prevent controller from generating another
>   extra clock cycle.
>=20
> The patch is to fix the issue.
>=20
> Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-next, thanks!


--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjJ5LAAoJEBQN5MwUoCm2bXYP/jJ3EoLklWhrd2iTnrK8GyK0
IawhoJQEDT+jq+UT0+BSf5JI6y0WEOvPicq2cttGNul1zEmvXRl59Fgc5vMc/24W
5/fegmrGe2jgvU89YoCM23H+YWX5hB8rzZKrCYYS6CcTINr1WsAU0hr4MQieTSIH
T2kMVlbuFivl8tFgsCY5bKhd53c1H/5TIQfi184RQ9ghHl0l+pfa6u4B32uhWmfg
dkRJAH2R8s06pHL+6vzlHXyEW09aMeE2kB2khsskdOyLDp14xr8E8MdzPw65lSne
mn2snXLihAkvH+09pnXeKHzRTyLA9JHBO2ooPYDZh51BctMCg5WTM4NNNS5rHj16
/U14Frkoz/eH2ncjB8M14LVauyYmIU5jLlwfVJca+piY3V8XleUH1V2ErxROqFQ3
GWfRNYJArLl5tG2Ybk7tdejaoSxmxazSU7yBRC2Q7/FmYo18OWGKLclTIskz/uDD
9xhuOReDW+9t9UntPPzWi17cqEOZu4io5GDa6v5iP7cmr8CIxSMaLAMlPlKMLHLi
pMtBTXihiVk+IKacJvTRw7/3YLuPvKEbBvc0IKwh+/tAwkyqidmzi43Tb2IdgQLz
Kr4vO+7KtEMvPKQjaKjibSh6sJEd8nj3qqFcV/Ehc4dfczMaEduEDouAg+xvkSkk
QgHRdfy9aPmu+1GnePXE
=njjq
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
