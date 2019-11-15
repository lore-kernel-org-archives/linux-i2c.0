From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: fix use after free in of_i2c_notify
Date: Fri, 15 Nov 2019 22:02:01 +0100
Message-ID: <20191115210201.GB8973@kunai>
References: <20191108083648.56503-1-wenyang@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191108083648.56503-1-wenyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wenyang@linux.alibaba.com>
Cc: zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 04:36:48PM +0800, Wen Yang wrote:
> We can't use "adap" after it has been freed.
>=20
> Fixes: 5bf4fa7daea6 ("i2c: break out OF support into separate file")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Applied to for-current, thanks!


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3PEkkACgkQFA3kzBSg
KbaqzBAAoQV5GxF7KrMUwnwhRzNrDaYURGV+A1ny13BABQ40jF9rK8gRwDGurOg1
NG765QeVNZBNUIsOYlJsUxfJb5MdMIDhDS1+O4TizvEodpJVu9z9j4fMfxvxKGtW
prFwnUxvFYVySpfo2zbreBgQ1zX1DO0J1TX50wxnm53IXcl4lqz/KKKNH5J3EYmc
vs68S/3iwjU50xGFecnmBlojog35sXWtXZbLu0FXrR5R0lqzMOS30jzeHi6SoIzw
giL+CQoDqbLv2ucQXFsSI4PIhTVEniSgr1lOiouNkAMEkfTH/ByhugNtQZkh8QcZ
KjfwmKXTcbzngK0QubQOQo7v2sAxIs7fPoi6HUrFeTWKaw6LRjQ/u3jAR0ag84i8
WO2oN0PYu7DEeI1fNkfeX1jeFU2nCF6poBs/xaMNd08mtFRN8WETb8/CCHcqpDbO
VxWyDqeKorF8/OQWn9YxMuRPwGhFnL0nhwRn6fgHL5eCW2+6ct+tYL+r4jUROGk2
eYRSw+iuYUodcjGdc1Y3VBoNgfREIuLR11ITp/evegrwGPm6UNy3TGCobVyY3AWR
6oXoLO8A0FkbW5Cy5FhdLr1SHmKrfKXUaP6aw96Er+FqysHQRE50zJi48+ev7gjT
e1L66WOhy7QXfn9wP0cyuoSKl5HjjrLPzhlwE2u4D0ZTm5ZSv+I=
=ug3Z
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
