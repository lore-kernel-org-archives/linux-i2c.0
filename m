From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Tue, 18 Jun 2013 17:55:31 +0200
Message-ID: <20130618155530.GA7718@katana>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg@mail.gmail.com>
 <51BF2FC5.40207@wwwdotorg.org>
 <CACRpkdbjy+PcpNkSg4PuuP2Z9RyrnqSW0uchHFHVZ8VYPeoDyA@mail.gmail.com>
 <CACxGe6sTq=h9jjqesjvUA4Bweh7zgE4VOLoOTgGPC_D_v+8NtA@mail.gmail.com>
 <20130618073302.GA2962@katana>
 <CACRpkdakdUVzHM4L5qOJ5Ls8NwOimy197NCUDSP=X28d2fzHPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdakdUVzHM4L5qOJ5Ls8NwOimy197NCUDSP=X28d2fzHPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 09:44:17AM +0200, Linus Walleij wrote:
> On Tue, Jun 18, 2013 at 9:33 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Mon, Jun 17, 2013 at 11:15:30PM +0100, Grant Likely wrote:
> >> On Mon, Jun 17, 2013 at 5:33 PM, Linus Walleij <linus.walleij@linaro.o=
rg> wrote:
> >> > OK that works for me, I'm not in any hurry.
> >>
> >> Deferring by a merge window isn't going to make it any less painful.
> >> Do your best to find all the users that need to be changed. Use a
> >> coccinelle search perhaps, but I think it should be merged anyway.
> >
> > I'll try a bit of my coccinelle-foo today and then decide.
>=20
> Thanks Wolfram, much appreciated.

I am going to revert that commit. I was thinking back and forth, even
playing with the idea to remove the id as a parameter to probe for i2c
drivers and let them request the id from the i2c core when needed. But
now I found more side-effects. E.g. run-time based instantiation for i2c
devices is depending on an id-table. So, for now I keep insisting that
an id-table must exist. Looks like DT-only drivers need more thinking
and this is too late for 3.11.

Regards,

   Wolfram


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwILyAAoJEBQN5MwUoCm2skAP/jwoWS2hlDYLS/pPak/fn1W+
2SlB7nDgJCYMUJQLar3GpAtCm2IkahfpmpfsBEaRd4+OjuGgJwSpBUVTPZ4eeovy
vxukNaJGImprkO310eCF73Oyxym3wcEPtw1VmauDsR3segtuaRIcVothmFU6nJ2l
oq1O/vuICIjeW0FaSNNaWGoTWgbrLuX7m0dZhJFF7fNPAA2SSKoA9u1txwgLbzWh
KV3qppclW0cDSotiLGp0XeSUWjFc7TYGHrDjrD+s/DuuExWQ1ugJBB9oTHvCxVx4
9EBsbX3CLTYIlw9dw8EIyQAOvprUd9fr2I1/rPndcEYHCskZ2E7JvPOANEXqHwaK
EVcJToImc3bViKbJqm0TlZ6m5MG1aXwRa3slRSGcL5gtJxrGUXjbyvQkPhptb0fg
yESYneeHy2K/smZ+ry6PLD5rIscS+BH2zmE8rlrzolVfwExDOEuAy3eN7t8JL0vb
H7v1uJlHqzleKOd/+vqOOVHd6MfU9uEy935dy0rVsFLY11PoQPKp5yRv8xRvVNw1
ymqGBmt9R+JjKtJe3vNrlYxNTG6t0To4QZLfo4o87AtAMoYFaDiZQoKNxNtPkxBr
0VY3S6AmsvAZVEE36cuF88yOeLCN6k2Dh+SRp8XRRlJMHkcoUPNRJYIjlkojHXXA
DGbjuKFI6RXb9Z+K3nci
=bhlu
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
