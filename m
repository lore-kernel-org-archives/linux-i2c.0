From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rk3x: Restore clock settings at resume time
Date: Thu, 8 Sep 2016 22:50:19 +0200
Message-ID: <20160908205018.GG3166@katana>
References: <1472505756-8302-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50261 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbcIHUud (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 8 Sep 2016 16:50:33 -0400
Content-Disposition: inline
In-Reply-To: <1472505756-8302-1-git-send-email-dianders@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, david.wu@rock-chips.com, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2016 at 02:22:36PM -0700, Douglas Anderson wrote:
> Depending on a number of factors including:
> - Which exact Rockchip SoC we're working with
> - How deep we suspend
> - Which i2c port we're on
>=20
> We might lose the state of the i2c registers at suspend time.
> Specifically we've found that on rk3399 the i2c ports that are not in
> the PMU power domain lose their state with the current suspend depth
> configured by ARM Tursted Firmware.
>=20
> Note that there are very few actual i2c registers that aren't configured
> per transfer anyway so all we actually need to re-configure are the
> clock config registers.  We'll just add a call to rk3x_i2c_adapt_div()
> at resume time and be done with it.
>=20
> NOTE: On rk3399 on ports whose power was lost, I put printouts in at
> resume time.  I saw things like:
>   before: con=3D0x00010300, div=3D0x00060006
>   after:  con=3D0x00010200, div=3D0x00180025
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Fixed the code checker warnings:

    SPARSE
drivers/i2c/busses/i2c-rk3x.c:1346:14: warning: duplicate const
    SMATCH
drivers/i2c/busses/i2c-rk3x.c:1346:14: warning: duplicate const

and applied to for-current, thanks!


Note my code checkers also say this (unrelated to your patch):

    SPARSE
drivers/i2c/busses/i2c-rk3x.c:888:17: warning: cast truncates bits from con=
stant value (ffffffffff00 becomes ffffff00)

  CC      drivers/i2c/busses/i2c-rk3x.o
drivers/i2c/busses/i2c-rk3x.c: In function 'rk3x_i2c_v1_calc_timings':
drivers/i2c/busses/i2c-rk3x.c:745:41: warning: variable 'min_total_ns' set =
but not used [-Wunused-but-set-variable]

I haven't checked those, though...


--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0c8KAAoJEBQN5MwUoCm2H+AQAJilOM+BsLnb2m1hvSWWFTba
ALHQH1b1jUQ6ebGwqT8V5PHBMQVBBdsV7t3KCb0KQOvphWx2C6WeO7QTI6O8mdBc
G5F0iHLs0tex1USILDY0h0eF2VzNh/zQhZaCyytyc2Zit3W/YLgch2B+Tt8vFRUs
1/tN7RwOjcSWQDVK8T42U2+PnRQAB2KjBN+Vi+e8hlA+mSoP/MY6gtSDjutTnVGV
z5/iSm2tvoZRkK4rPMRDHk6oDClJkoT/UVSYIQuIPKREAvTDsK5QF9PqFG6ZSQPH
mmLARRa6nYTLmrXlxBJmoKHNrjAgzI71W5rQu84buKKVriDsRqxesRomYgy9dJnA
97cwOGduJOj4uiqD+6UnCF6dllPzMcCxdM5cZN43hvT9QCCAdRW7Uqd/DsVgO2E3
XoYKliHFhe3F2vgpX9kcynqJfc8L5SAs+UFkRF3SyyDH+IyGIk+9sATO3AMMhhq5
VFzVd2qc6miX0QjHWcL16Ecejl38w5UNTSTxCatnO+XnRjSJU+XeQh3m9vYuU1Kj
y0EvlQuwKNV3xn6R1KtJs/GdLiH1UkSutcD6tL4JU8rYUoUYYKAUI1xbPDHI+aMg
jICm136omCqXMtlQ8eRD2xEf5J7MeMk1bA0p242A3VrVDnodKblBluW6e5zr1elE
1+lLSAzs/tDUGIG/a36t
=TGFh
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
