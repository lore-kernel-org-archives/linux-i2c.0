From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Sat, 24 Sep 2016 10:41:54 +0200
Message-ID: <20160924084154.GA1434@katana>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana>
 <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
 <20160923221312.GA5683@katana>
 <CAL_JsqKi9Dk5-nF9xFD-89TTUinaGjMv5s1=N2b-Xyu98b+S3w@mail.gmail.com>
 <20160923232641.GB5683@katana>
 <CAL_JsqJGQ2az=eO0PbfcTrAPxUsym=UaDOOy1Rsw0-AbzMjnXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58809 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758289AbcIXImD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Sep 2016 04:42:03 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqJGQ2az=eO0PbfcTrAPxUsym=UaDOOy1Rsw0-AbzMjnXg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I did state some reasons previously. Consistent rules for submitters
> of DT bindings and being able to trace history beyond git. Now, I
> guess you aren't changing the rules, but you probably aren't
> requesting people to split DT bindings either? You might not be aware,
> but we also generate a DT only tree with git-filter-branch[1] for
> non-kernel projects to use bindings and dts files. For that, sure they
> will only get the DT binding part of it, but what commit text do they
> get? Finally, DT maintainer acks (which from me is a review really)
> apply to the bindings only. Sometimes I review the drivers, but not
> often. So I would like the git history of my reviews to be accurate in
> terms of what I actually reviewed.

Points taken. Will keep them seperate from now on.

Thanks,

   Wolfram


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5jxRAAoJEBQN5MwUoCm2VskQAJR5zEQEi/guKpAD2jffxSSR
V1cvhn81Gb017mOsBKIZPHeC1l3/7G2Fqantqeo3Yozf94DS5ZiQENHWHIbCDAQG
64JWBoeIhn3BykvsT0zVyKLthDF4RIgRJl+Q61fWEJrV8n4cbzDuoTgPUP/dGFJj
FfDyh0lrDEbSLV9f7g8T1CXHVcjKX9HFLhPmf1J9jyQMgYap3lB7vz2EFyM0Xtsu
N96JeDkwd1d9VYLjRAMwYzO4IEzLsU6InqkkpNbN3RxhPXjV6keAMN6IbFrQQS/8
jFio4OXnC7kRjVUoOgQ6fGjdhG7Nrsz+XYiJo1DIJWj6FegATZ/VNbasOD8q995G
tnHeYpdjTgM7M5dFuyO9U7Ny+MYyJTARp6HqdtAM9VBiI5WcywVFPmG3Z1aPw0Yp
ynvnTBCpHfisW6LMm6eSkC+ncHMI0hI7HruRUS1km5++AgUC09p4zl8R1sxPpwZM
IoBHp8ejNnhy6IOjY4Yg7E3PxEEQwAOe7/TDAWKFlWlt0kina6h9J+6VAC3hJCzW
ue+aogoq7liwUJxG60n6+9rwS/XVA+QxytSvaRMlvRJw6FyQ533d+uloWYx/5Cuv
gU3eyfPxvuM10tUnFQsZUd9jhAKgzK/ekO4zRxtzkorF/zH6F8Rh2PdsA6Mrao3M
oU8CmXyXyMVuu2cacDR3
=bwI7
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
