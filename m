From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] i2c: mediatek: Register i2c adapter driver earlier
Date: Thu, 6 Sep 2018 20:31:44 +0200
Message-ID: <20180906183144.GD8607@kunai>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
 <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: srv_heupstream@mediatek.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 09:15:28PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> In order not to block the initializations of some i2c devices.
> Register i2c adapter driver at appropriate time.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

The reasons this patch was rejected in v2 still hold.


--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluRcpAACgkQFA3kzBSg
KbZN3BAAsqTrWJ5QI5dYweb+tLwNyMhYSAnc4IFN6kWZUrd5EXil95DmgJk4X2MP
e593rEqeyLhpnX96PTFZOuwKtz1Pd/VUvUa2u1IHM1K6NiK4lTfLRa54Fi/8/5Hs
tZHsgiZaxAXiZ6wxfLIoE/FKFipvgmpX72qfxsGPjMU21668qrGfzrLpNzZMd4n/
TEMgo3ILkMEM8JBepw6FdVgAUyt+lBd51PSd5Sruo0i+Yungl0whikIa/9Lxl21K
Mgh3oJ9E+fhCrL4soX8NSjW+foFGs52Wz1dumnhLXkkcuwOPfzZzYbGOt0bDiuIo
yDvweosF9HovW35oVT1lDP+3N6FT8o06plxVpcvPtLBhywQ9GF0lP7BFqd/I0XPE
7+0LM0dfmNF5og0Hc5My6ZhwWP+Qvd5YpcUGTIf7qlFY2zE+00H9/cHuSERqQKAn
eYQaVm6TZrGQ9+eIn/BxWiSQZfqg08Qa6TVgR/HAW2nqJ0DIn8Hdl6C7WP59ucB9
vCke0c8CXLMDI5AHgUWcsrZ6gHzlx7yNn7kkxoqdBUbUfOMS5gUStIv7ca6+NS5i
+cj3ymQCwvMXBmI44w8Fz3y2f4RCziQ9gOWvX77t0aUIrG17x1Z5EsVgJmOdN98H
T4SOfeEAi29j1Ah/GmLMenRA09M83tsYiQDdkouteYbJMhh6rtQ=
=fhL5
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
