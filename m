From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fixed PIO NACK error instead of timeout (1000ms)
Date: Mon, 22 Sep 2014 17:56:15 +0200
Message-ID: <20140922155615.GA27087@katana>
References: <1410279571-4552-1-git-send-email-j.uzycki@elproma.com.pl>
 <1410279571-4552-2-git-send-email-j.uzycki@elproma.com.pl>
 <20140920124935.GF3850@katana>
 <201409201522.00331.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201409201522.00331.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2014 at 03:22:00PM +0200, Marek Vasut wrote:
> On Saturday, September 20, 2014 at 02:49:36 PM, Wolfram Sang wrote:
> > On Tue, Sep 09, 2014 at 06:19:31PM +0200, Janusz Uzycki wrote:
> > > i2cdetect scanned i2c bus very slow if address was not occupied by any
> > > device.
> > >=20
> > > Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
> >=20
> > I would apply this patch and produce a fitting commit message out of the
> > text you already sent, so you get an idea what is apropriate. However, I
> > can't apply the patch. How did you create it?
> >=20
>=20
> I'd say it's based on Linux 3.14 . Btw. you could have pasted the commit =
message=20
> here too ;-)

I can't apply the patch, it needs to be resent. And it is not wrong
context IMO, the numbers say 4 lines will be added while the patch only
contains 3. I could fix it manually, but I rather have a proper patch.


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIEafAAoJEBQN5MwUoCm22IoQAIKJKvJtcuuIMM4HwDcVgL/T
5gGTMuqc3Aor6qelASgmKEmIgBU5ceFrM/q/qXpRI8oQCX7BDS6naigQsZE0y4k5
O3YS77Vj2A5Fe2wBUPpKZq9DtbB4N/GoX1mFrireLro3+dJ7vX3EiL2F33YnM7g4
27gUrRajxwl24z2+u5W2P5vAanxC4VmWAn4ZM3adzy3uqu7O+qw9B3DP8cFRzyvy
7jmdKncZx7WCMe8ISuYDV4iULhg/i1/S2b5dJdblWg73aKkSaJ2E931409v+rQDt
eqiEQImoEHJRkX/b+mXaZ8aviYaX7lnEZvGT0q/53aDMr8aW6Fq7Ev6u0XjvLDwk
TrOQjN8UOCoJl/BGqe2KLbwLYDrHHLxO9MWyxVU/lNnD7n0gIXutH9Ec1Dng9Zg4
3/FM4inLGBhAH949OcEBiUBnLvU8EkzhSv1rovAuCi4UDS7Fkyzec11dodnIN8C/
Jlb7TcLNB804JgcNBH9Y7weauMiDgy2AnG4fYy0VYDqGoqt3q/5cTPqIdq+AdME/
SF91dbbfPzYtrQ54xgtSTt7wlr8KCFxs29LTvAdofcJLCfuY3Ke+OQoXNFrgogFq
dtt4mncaEu7igZtxWovTDeqswgFJb5nNukSvTuLcYP3V7yNo1JrVupW6gU5+Rorv
H8cf/5slWcNm2aSl1LhV
=NO8t
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
