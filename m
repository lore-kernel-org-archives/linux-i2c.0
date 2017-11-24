From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Fri, 24 Nov 2017 13:36:01 +0100
Message-ID: <20171124123601.vyw6vejwa56xmun6@ninjato>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
 <20171110145038.i4jnqsctdzkfmoe5@ninjato>
 <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
 <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lymw4xjjmw4yrzeo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37057 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdKXMgD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Nov 2017 07:36:03 -0500
Content-Disposition: inline
In-Reply-To: <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>


--lymw4xjjmw4yrzeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 04:17:26PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 10, 2017 at 4:01 PM, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> > On Fri, Nov 10, 2017 at 3:50 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> Applied to for-next, thanks!
> >
> > Thanks man.
> >
> >> This from checkpatch makes sense to me:
> >>
> >> ERROR: Please use git commit description style 'commit <12+ chars of s=
ha1> ("<title line>")' - ie: 'commit b2e63555592f ("i2c: gpio: Convert to u=
se descriptors")'
> >> #21:
> >> commit b2e63555592f81331c8da3afaa607d8cf83e8138
> >
> > I never understood that thingie, I thought the check was
> > only there in order to stop Fixes: tags from running wild.
> > But feel free to cut it if you want.
>=20
> I have this in my ~/.gitconfig:
>=20
> [core]
>         abbrev =3D 12
> [alias]
>         fixes =3D show --format=3D'Fixes: %h (\"%s\")' -s
>=20
> So 'git fixes b2e63555592f81331c8da3afaa607d8cf83e8138' produces
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
>=20
> which I then copy into a changelog as the last line, or use only the refe=
rence.

Kinda similar, since I have a white background, I use:

[alias]
lg =3D log --format=3D'%C(yellow)%h %Cgreen(\"%Creset%s%Cgreen\")'

which is easy on my eye when reading 'git lg' but already has the proper
format when copy pasting its output around.


--lymw4xjjmw4yrzeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloYEiwACgkQFA3kzBSg
KbbkEg//Qgtlz1oyiMDwwOEma28mMM7x0w8kHsBp5+NPyb1jfRnBnBHtQJ08ksLA
5pF1CvBMe+dOtMK/5ab3/NzzzSn1NNWifOZ1ebqDJp+jIpT/5MT51Ha/NFwfydOm
GbspUudpCbwVwrDjGwGToAvlT7veKm1cQrhAmKtPk5cgiV697Ok8VSyLI4q67Vky
VMQMS8ZTVgxU9Dhst8NrYMmOhX/SgnANbQ2+ZXz5yiAKsEsQUE6KxzF4j+ZKR1OG
a3SApI25RmVYp6uwsWyuebRXlakfRpmoJQMW3IvZD+lATGPtqO/+QqQE7cO2LTiP
4mMzQVyDU6zhM4NT/taLajzfVDZ/IAGmM+nz4ibpJT9FWViVejs1tXkgb1/cy1qa
nmE74Hd1wqSnWz5MusHZ+gMqvnWKdVa+ckbfldkGJS7SAzizPwKUJybb1Kn7j3oH
Sm/Twafk2pbS73pe0ZwdpbAtVVQiJsZ2womDVy0qZQdJtEjKFeRPATCiv9PnzoS9
2dm9kToBCTJ2d5f4F+YC4CeNMypyIn2XaLoMM9DQJp0JwJGCSVPVuefWcE3atvlK
esLIS8Zi6xsv98YzubpuQ6HaxkfGJINTriDhHmeclTOJFLyOOwDFL6Pm3Mf+CNfh
ptHvC64qcdZlp9M+aPKVfDtb9svz4jOdTvcQYg6eipWLjtw0j2M=
=G1UT
-----END PGP SIGNATURE-----

--lymw4xjjmw4yrzeo--
