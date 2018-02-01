From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Please pick up i2c-xlp9xx driver patches
Date: Thu, 1 Feb 2018 09:12:38 +0100
Message-ID: <20180201081234.d22au6akp5fdz63n@ninjato>
References: <CAAek22FfKtt3QzXjcR1WatkFvLuTO5QWSKqCmE7mUGzTG0tZFQ@mail.gmail.com>
 <CAAek22EEs_mHcKg80Ei=FRNH88KVjWJNHHVZ3cU204c0fW8v2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zylzc7tpp2isf5ho"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40224 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbeBAIMp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Feb 2018 03:12:45 -0500
Content-Disposition: inline
In-Reply-To: <CAAek22EEs_mHcKg80Ei=FRNH88KVjWJNHHVZ3cU204c0fW8v2w@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Pokorny <ppokorny@penguincomputing.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-i2c@vger.kernel.org


--zylzc7tpp2isf5ho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I wonder if either Corey or Jean could/should pick these up and submit

Plaese note that I took over I2C from Jean in late 2012...

> I tested the patches and they fix the ipmi_ssif detection issue I had.
> So I'm willing to add "Tested-by" to the patches if that helps.

Ehrm, why didn't you do this right away? This helps _a lot_! With these
tags, I might have considered them earlier. But without tags, they
surley needed a full development cycle to avoid regressions. Which means
merge window for v4.17. With tags, I could now consider them for v4.16.

Rule of thumb: If you need patches, show your interest.


--zylzc7tpp2isf5ho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpyy+4ACgkQFA3kzBSg
KbacXQ//ezJsz7D3oFo0uy6TB3GHX9teBkq9ehovJ7NHsLRpbHBUV/vlLqbfRtmo
zHn1wEFqfg1NBTk+LFV+HJhE6nmY9H1gDupbXugd/1n1ps4cHYpoi+F23h+6auJs
f3qe/4Osohjs5Kc0h2NMk35rQBdvgGzXT0FH8OvVTfB4xIToO9KXCLHbJXg8F9SX
dzDtO2Z5VqK3EWptA2AjQnPK8YHFNzHGkrpUAAdgBlr3xkeZ5Ws1uKK4aHXTMZxn
5AZj7GFewOPuFp9rcxI+Frn3UA7K9bxFtFRTZ4A0CruA6USy5go0N+yamRuXKytV
c4ZWAcuzLRiTAB1ex1bbvc7xTPocIic2/7SZlAmAVws7Js09eRRlWJ+y7HVPS7++
Cl/eqvm1XbqpHgojTPdPDRl4uUiwc5vpWFil2p9ELK5+WmwnsAwPlTsscykqpfYo
bhxBDJxpOjQKp91LrPzqJZHWZZcH0SgwPT+VlXpvRGPPlZQheAsaQXqC5/D2oz88
hNVH5cqNz922Li/tNi/CSL2oO1Bsci/ISq0WQWrd8U8ukjuH+zizRun4+clwo1KU
3avEI+Bgw+C7ZUZECSUl1VPuxxT2x2ToySmT6lEkMpUL0tzaztpacmOKjXNWUfAp
vsbZZ+0IMYWxZemIUGEdGkWc8J6/RRE0rx88A7gBVeRkxvXgiJU=
=oIAu
-----END PGP SIGNATURE-----

--zylzc7tpp2isf5ho--
