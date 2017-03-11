From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c for 4.11
Date: Sat, 11 Mar 2017 16:59:20 +0100
Message-ID: <20170311155919.GA2553@tetsubishi>
References: <20170310123308.4suuobaz2q372tod@ninjato>
 <CA+55aFwjUWLFBwyS9iNKA=43tX5Ki+Xu7L_tKMKEa7buVnscBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46178 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753890AbdCKQGP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 11 Mar 2017 11:06:15 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFwjUWLFBwyS9iNKA=43tX5Ki+Xu7L_tKMKEa7buVnscBA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

> You added an extra revert, only to pull in the *exact* same patch. WTF?

The patch I reverted had a broken, typoed Signed-off. My rationale was
to have only a proper one, and not two different ones coming from
different trees. Looks like I misjudged, sorry.

> Please stop this kind of stupidity. Now I have that unnecessary revert
> with a misleading commit log in my tree, in addition to that stupid
> merge that has no explanation and just reinstates the exact same thing
> you reverted.

I see your point.

> And talking about that merge I will repeat this one more time: merges
> are commits too. You had damn well add explanations for what a merge
> merges and why it is done.

Understood. Peter joined as co-maintainer kind of recently, and I guess
it shows that I didn't have to pass on merges a lot so far. It is not
that I ignored your preferences for merges (which make total sense to
me), I just missed to check how to properly do it. Will improve!

Regards,

   Wolfram


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYxB7WAAoJEBQN5MwUoCm2/4AP/iHXJVTYxhQHPBlxQqNVffol
ODVuyldPP7tPQJUUnNFS4xeX65+f0dBXbHF0uiivqGql6TrGosc2s/YZIM2bAu8J
24lL8/Y0HmqqUJZOrT0ZRP8UgTtHwHhzYBvyt2ayTA/jtoZo9ObckobaGNYZ5lc1
/Zxju6MnGrSkaCOWBGwXJFxm8El4+qsoBV0VVA/C1e8yL3i6gop8RBeX10eDlhmh
0FUNSJrAse9v6USSRNH2vIADi+m6UPNEV0PvyhgmNaY0v2F6SJ+eBvziNCPglyeb
uNNmKntEvgujeAsR/dct8KF42snMuZX5hDznS/SMCkxWee7VFMyq5huPhlPaGFA5
w4XWIkINFAwx+QJE1+Jwq8oSfRKxL+86W4+dRVZmYGPinNizHdJFAur1wqSXiRwO
Uw+0wfhZhroCYO9OoSsbvwQe58nJ1BT7NqCGal9qStJGJjCQ9fIl/VHIoLGAEh/e
z2GMwD1GNg9aOgTH0n5ej5o1F4iUWSMsuoJFkZ0CbGJCctv/1kj/xtakS5uRzTko
XU8mPQ9LB9lxbohKcHSjLjLsSvw3bzJPmonSWSTPFR/6tj3SwEpFrbA/3m9wVzj5
ocJ6eCOuAyG81Uwh//Mw4Psr96fJqvIEdjMYJ+ODImrIIWNi8a0kH1CfBSNc+g5U
2CawwAtAUh9O9V4jqV2f
=x8Lv
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
