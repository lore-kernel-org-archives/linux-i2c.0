From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: True Parallel Port Interface for Bit-banging?
Date: Tue, 25 Oct 2016 16:29:35 +0200
Message-ID: <20161025142935.GA2875@katana>
References: <580F4042.5070201@laposte.net>
 <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50164 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbcJYOaP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 10:30:15 -0400
Content-Disposition: inline
In-Reply-To: <580F6A1D.4000409@laposte.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Would the ExpressCard Parallel Port appear always at the same address?
> While this could work, it wouldn't be generic. I would have to do the operation
> for N apps.

I see.

> The virtualisation idea is not good then?

It is not that. I think good old DOSEMU could do that. Bit-Banging ports
can be timing critical, though, and in this department virtualization
solutions often fail.


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYD2xPAAoJEBQN5MwUoCm2Wo8QAIiU2qEOjm090pFd8kzVM/u7
FxB7vhulUzSIOB5IC0NUdIzdm0B5HIsmUGn8hUIY+QMyiGFlGimpKSkrbki3Ud10
vdEvPuPH7kXMiKpX/7fDZjBoCTLDPVS5dbygWeRbPZkTPLLPwJKUXtjXMti3XQmx
ZgVcAjT+822D/qq8e6OiH9wrarrsBIV6Gr8tiQAI3XgOlojxYk8mFBnhdSH0EUHZ
qYGUjlGwkKayz9GZLM0bTC+iJeS9U+0QBe90YqH0p2HCmELJ1lWC2OfCAVo0EleJ
EkOqMefk/kS9smT7cIH4h9XgAQEcXEuL0gg8QYG3VzjA8w2l9y51pvI6za9J1Clt
el+uItSkm6NLGo4u93EaMacaacqiEG3dqJdnMzSl1Dyx6yh7rbPky6dlSHXMd35c
pvRm64frfvPww0//9gomwOlEjcXIgD/GhQTdzveWXsrYRHF1ZfF51kO3edzTV0UO
6YhhCuS9pj1IZ2jHVHDl4InCUKw0G12C/DaabGhw61GwVN4I7cHq16KPFCFXRQxY
v5T3Aqtt8PC5Nymd2F5fnv4Bv/jSJMgR+d9c7VzDFugziyZzmMs13sOHrKa1maxV
NPmDC1Z+Vw93/n15SmXuy72PjIi1NHEgTmASxnN8DvApvQtW5Y6mWsGJH9OTdWGV
EnxC3CLMH3zS/6M74OiL
=f09G
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
