From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Tue, 18 Jun 2013 09:33:02 +0200
Message-ID: <20130618073302.GA2962@katana>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg@mail.gmail.com>
 <51BF2FC5.40207@wwwdotorg.org>
 <CACRpkdbjy+PcpNkSg4PuuP2Z9RyrnqSW0uchHFHVZ8VYPeoDyA@mail.gmail.com>
 <CACxGe6sTq=h9jjqesjvUA4Bweh7zgE4VOLoOTgGPC_D_v+8NtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6sTq=h9jjqesjvUA4Bweh7zgE4VOLoOTgGPC_D_v+8NtA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2013 at 11:15:30PM +0100, Grant Likely wrote:
> On Mon, Jun 17, 2013 at 5:33 PM, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> > On Mon, Jun 17, 2013 at 5:48 PM, Stephen Warren <swarren@wwwdotorg.org>=
 wrote:
> >
> >> This has just shown up in next-20130617, and breaks at least the
> >> TPS65910 and TPS62360 drivers, since they assume that the id parameter
> >> passed to probe is non-NULL. However, now the parameter is NULL since
> >> these drivers have both an ID table and an OF match table.
> >
> > So you mean they come in through the DT boot path and assume
> > that parameter is non-null even though they should not make use of
> > it?
> >
> >> I'd like to suggest this patch be reverted an re-introduced immediately
> >> after the merge window. That should give enough time for everyone to g=
et
> >> a heads-up on fixing any drivers with a similar problem, rather than
> >> trying to cram all that in immediately before the merge window.
> >
> > OK that works for me, I'm not in any hurry.
>=20
> Deferring by a merge window isn't going to make it any less painful.
> Do your best to find all the users that need to be changed. Use a
> coccinelle search perhaps, but I think it should be merged anyway.

I'll try a bit of my coccinelle-foo today and then decide.


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwA0uAAoJEBQN5MwUoCm2DB8P/Az8wiEb2cwzphIDhYCXYWOO
Jbb7s1EFytCe83si1+IpcsUe3PndEV6KtB1YeSdWrOexbXr5qpr/8KCsj0Msoexy
8cE0Lox7OxHukUo/ExgShJ0adUtEoOxAuaF4i/+QnYv+QCbtjVDdsjZJ+6xH4vqy
mMQacT+UFpg5GdLi5kA/aPEOEBl6WuyXZuzwWebffa/rqNyBfOMJ0nfbtGlQEmGt
CFU1Tgd4qrZ3ezS9Y3TsriFpdfrfXnJcsawsvKSr32yq9S2WHcj4eSx1GTWAFzvh
rPZIGlHCXcMsJAvd19a57iGj1JMomMeh9flXoxLyvaKcLCvQgUlHY+tfncIbkK7y
lnSpAOq63thZA9wivxUMaYWBRhZ9L0JiYf1pAYCdVqtKpcZfBfTL3q4w+VCSE+1R
WXxZKg2JZuedJowh5j4fulWJAdWr4oqvKAeHS/RBSJWP9H9V7SyjEewKujws6czI
XoC+KPpABLnwRSA91TVGJAl777qqRw3Drl2/7j2TBLP0+T3xaO64HvDd0kqGBNUp
hqk1DhyLVo6Ky9jnASxPuxOG+SIVgg84vgcL/Q90a1Keohs8/7Oy3xvLGk4ye0We
P6kxZkgj3MAPKmJet4kr7CaJSvYcubaQ2zUgCPCQVUOYKWAhS8uf8mvHeQMvxW9K
uN0JH5OeVgja/5g7nuXw
=372C
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
