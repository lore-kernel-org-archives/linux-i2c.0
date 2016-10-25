From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: True Parallel Port Interface for Bit-banging?
Date: Tue, 25 Oct 2016 19:17:59 +0200
Message-ID: <20161025171752.GA4274@katana>
References: <580F4042.5070201@laposte.net>
 <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net>
 <20161025142935.GA2875@katana>
 <580F72AF.9070900@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50708 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759345AbcJYRSk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 13:18:40 -0400
Content-Disposition: inline
In-Reply-To: <580F72AF.9070900@laposte.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Or is the "timing issue" you talk about more related to unpredictable
> latencies due to the way the SW virtualisation works?

Yes, it is all about latencies and meeting deadlines. This is probably
why the application is DOS after all.

> What about emulation? Do you think emulation would be more predictable?

No difference as long as there is a multi-tasking OS in the background.
Yes, the RT patchset might help...


--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYD5PGAAoJEBQN5MwUoCm2x98P/RZEO/0Xa3QKFiSeblblw8xh
fmwwJtmmwQr0CT+y4ZkTwbDbKkGh/VWw2SOqVaH1UpV/teGbkEEIWsiPZ06gWRkn
lQOaVqaqGyQxPIkU55BUOsYtDTBgZwZMuSl2d0kiHhMTf26zOXkOakbdsmZcwrnX
45Uh4gAGFOk4APs8W3yWcs+7SzHfldOIAIHOy2ZRLrROZJ2id2OXybQK+HPiRl/g
UuKNpnBztaBX0UdWhc7CWlRTBmq9+ZN6tE4O8sCsMzCCLGcePxIgdqDPbBfxSq7D
P+nLZrJnbd1uas1byIlKI8Eog4IQpik38Js8Z9LVFRMVjxqCvQlGPizYMCpDOXNy
A/hewuqEGnS8U9jeaLWPXvibcHTEpLI2TrdzetCX8z981m1+8ixvyZyKGUYNa0hf
r5Fqr6i6BmZDaw07g2bbRbyc4nK3/9Ty0EnLTs5knjEhaPx6xyezuulGyx6WpeuO
KbaqB8Pul6P7zc09osi0dGeHqI2a1KmTWTCliOcHNyTQF8zcN8P3rQJe0zrYA1Ci
MCm8mo679kk3BvYDi/HOVjiBVdwFJq1oBP4J55+vV/9rfgbdbH/RqLC3HniVLrYD
o4R0LmUWqjPYdQ1+Rnpn08MHCh8Szm6uJOUHJ/ncSCw4vb68BDK5Csd0YIvl5g5A
XqjMzYP7Vo7MFL1eF8kI
=4q6s
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
