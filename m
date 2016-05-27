From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: dev: don't start function name with 'return'
Date: Fri, 27 May 2016 22:53:52 +0200
Message-ID: <20160527205351.GA1605@katana>
References: <1464347891-4236-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49263 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818AbcE0UyA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 27 May 2016 16:54:00 -0400
Content-Disposition: inline
In-Reply-To: <1464347891-4236-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Erico Nunes <erico.nunes@datacom.ind.br>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 27, 2016 at 01:18:11PM +0200, Wolfram Sang wrote:
> I stumbled multiple times over 'return_i2c_dev', especially before the
> actual 'return res'. It makes the code hard to read, so reanme the
> function to 'put_i2c_dev' which also better matches 'get_free_i2c_dev'.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSLPfAAoJEBQN5MwUoCm2WgoQAJFM7d1sP+fTkYBtMhHeqK1D
7VogcEL4WaGKHswFd6nkEfrZujmlMs4FAcQ/meeNIXS36mc5/MuQdQk+TCVHRszG
3BuBWJWx3cpyV2RBpgMol+IDKe8jWudbsSOLp3Pt15dwjR/AFeHHmzbRuMrqnE7w
lHlrCIn5KaK0N5YKPZxUNBXlXlBbXxsQ741aTTSWwIyHYWn8n/1MqBcen7VawLPp
7q2+fb4S2mBHYbmlKCtFwrBaZKKrlPAfsNOcdz6KK6Kb7qURHSRa1LgwgVuzoUMR
g8zDomZv5Yg/P0crNoDZLric+ccAJzxg3cQX+9EcGXheQSSN80BkQHIT+dRYV9ZY
3KH5svuVh1GAYGssnhowU5UbzhqUx/VJe4b4Z5JHL5grZQzEp19XCS4IAw2M0nlL
shI9iLvGGsFRpz6StqaCLBeTwTMbjwmirjLPK8jP7AtzgDbXDUidcpKH7CLbpZHE
PZCRLn8un460VmxI6YfaADHFCKR2mrUBb/QW0TkpfLvXVZhtjH3UtoDHWOcPTqgz
9VyZJkNcktl5/bQPlYoCSUFmCcTp7YAE4nNwt9CpXZcbXSIoroyvYxrZDVSrDkBh
KII0zeK/qeTc3niIx/U+0Oq8kbRG6hhw9t3OiNbCX6s8tmGEsrrwObrYMbYSzked
3SXpgRx4Hfabmi0dzA8Z
=1YPm
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
