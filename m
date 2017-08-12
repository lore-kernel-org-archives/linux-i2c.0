From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: uniphier: add suspend / resume support
Date: Sat, 12 Aug 2017 15:38:54 +0200
Message-ID: <20170812133854.csmxs5d3x2xhkww2@ninjato>
References: <1501480387-15692-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t5zcwxv6bjiwjlqy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43143 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbdHLNiz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 09:38:55 -0400
Content-Disposition: inline
In-Reply-To: <1501480387-15692-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--t5zcwxv6bjiwjlqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 02:53:06PM +0900, Masahiro Yamada wrote:
> When resuming, set up registers that have been lost in the sleep state.
> Also, add clock handling in the resume / suspend hooks.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--t5zcwxv6bjiwjlqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPBOoACgkQFA3kzBSg
KbYSLQ//RjQ222G44oS4hU2oN/3wYm6f4kV4GVlQ/CS0mh0nL8Sd24D+PFcccJtV
sV6Me+BHgApGM5udLdNud9fjU+6bahPi+A5ATgb0G1bzCEK5YHFn70VF0Izw48K1
ZDPVZGjibUP0VfOhSiuBe+8QP7g0XjHxron8kPRjjLSOESfSvBJ8f41sGfMNhWWp
R93fn6Z0CSOFp6UNEaf13HILVMoi0XIdVh/xa2mUawxDNoX3jdBcw/UpLNkKuanN
a9bd7gtmqoOA0zrDXE5PPeF/waYs5Q5m1iB+qLLuVqm5OL/z6pwDlXHHjUQLrD+F
2JtnE6XcndN1UrVPp0bEcoRPXn0P0g+6NfrG7fzHZXhbyDtOdRPBzG5jXP7UyKlM
sowhfFOh7OH3XrzeWlf4V++59KwS75CdPqKHjX7lQyAstCx01VF4f9agtiDyPh+R
ptQ2+yfJm6PEBldf7n0PaItQn5b6X/oy8gGa7eYri6ScrDP3i5cXLg1BSV7w0A5o
3xXRRfl/QScuFlIaIcRmwP5I6x5Nxd6SJmkWh/5ztvl5kg0DnhMutYt3vNl2qC45
1+wICYB5IaCNtHy+jR9oqUeEe73EfabSVHX2cfEKpgPLYXGy2lpM8ZszXHYfURV6
R8qMFHQGcebj6fwBx7XTuK0vNenX0F55Y7QbAmIhP5nj5pguSRQ=
=/I+q
-----END PGP SIGNATURE-----

--t5zcwxv6bjiwjlqy--
