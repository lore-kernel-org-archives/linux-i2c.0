From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Date: Tue, 29 May 2018 21:16:36 +0200
Message-ID: <20180529191636.3u3e476auyths3v6@katana>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180529171957.y2ctsptsnjw6ykag@ninjato>
 <20180529172541.nrbvlkolhmlzpavx@ninjato>
 <TY1PR01MB1770DD97E8044C4E9B989537C06D0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="txpzojjl4mtynlso"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770DD97E8044C4E9B989537C06D0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org


--txpzojjl4mtynlso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> With respect to the changelog for commit 52df445f29b7 ("i2c: rcar: revoke
> START request early"), in particular:
> "This patch improves the situation but sadly does not completely fix it.
> It is still to be researched if we can do better given this HW design."
> This is still the best we can do so far, isn't it?

Yes, I think so. Gen3 seems to have this fixed in HW.


--txpzojjl4mtynlso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsNpw8ACgkQFA3kzBSg
KbabaA/8D5z8sK7sxpAgSMTQXjoRIYDSW1qdnt81LA6Xda4bsmVDUrsYrhMgkG8u
Zve0pF335+yCy5pyK0TL/RH/M3g+bl8KAMJkXVNAIgA0/o6IJfq+GycQt3eW7oQh
rTM8JM+jx0CW24uNLcGIdmI/0S0BzJjONCX2qbXOG4/sxRgzNVwDXqf4kczlsCcX
pjZIxUsemVJs423yOnDthhIKL9S4QszT7KsLwaowxdsfeJDqOq7eo8Gqte548iWN
eoB8D9OOCOYoP7H+uRXK5qkvJSYV/9hIroSbQPOU8H7mDtQpwcpApRnsG5nPv/1+
WCSD09wDq0GnaLUtgoD69kxws+8CyTiz7r8XC8zBnQjZiI3NJUpkpOEeoBMPdPUd
/TMCuQgWeYJAYoL/X+YJWmLhVl6g6lzVD9RqBMMB0I2k/wpl6aTe72u2Sb6rB3Vi
ynxqPmSComvsd//fiGsHQcAFRvUvfbYJ/MgKbPJh2HzzhtbuMRRCJ7pl6kQ2xRpx
6GlpuUx9J7d9YXvTOPq3nSz6nXFzusnBLtFSTLqUVzSwSnU1iM6CSegKfLTa1iZ8
yskml2e8dQIqThN3HV7H8kpPXXbxmkbMDBQwAKRcfsmoTfMTii2B8G6GALGsk2Lf
IUGINth8jV8gMVtM3mEHeQ9Wqt/ABsZgxnOkyu2HjewSHvBhI00=
=o69e
-----END PGP SIGNATURE-----

--txpzojjl4mtynlso--
