From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 25 Jul 2016 11:41:17 +0200
Message-ID: <20160725094117.GB3376@katana>
References: <137031469256709@web4j.yandex.ru>
 <20160723195114.GA2104@katana>
 <27421469430128@web19h.yandex.ru>
 <20160725072151.GA1599@katana>
 <354241469432837@web19h.yandex.ru>
 <20160725082813.GA3376@katana>
 <1025301469437877@web19h.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50898 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcGYJlV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jul 2016 05:41:21 -0400
Content-Disposition: inline
In-Reply-To: <1025301469437877@web19h.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> There is no way to switch mux and request to BMC #2. Logically, this shouldn't
> happen too.

I see. I think I have the big picture now, thanks for the heads up.

However, I am not sure what recommendations I can give to you. I'd start
with adding reg_slave to the muxed adapters and then try to reconfigure
the real adapter when the mux switches (I assume you did that already).
But I don't have the bandwidth to dive into that and see what gory
details come up. Maybe Peter Rosin has something to add, though?


--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXld69AAoJEBQN5MwUoCm2blsP/iDunsrzGZUWHaUMbGeFY8ci
9arnXjCeFsReiOZuEO3wfyWFo5YS2TjzwfX8U1RkBgTujgCmhpfMN59vii4e/MoS
z0l4eg5Nosjenuo8Omrim+HQu1xYPYIo90wraTQL6dbxx53FZqIvScO06Aw7qgPi
Ok8yLLTrSRRXSd4MeP+fqHMzML/ny+DdA5P0jbxrrl2Jwf9VfjnX/AfObjh68x/v
newQD2vis0qNeaVeRWfBgLjXdqVLVnth7TnTU3myNqWhgemwG+R3ASJelr1jLNm1
c2ex7lLB7cK2O5Z0XIBZcxs4FjlfVYJx+9iaOxTLn5mPyc8pu5YQukuntAbPfWSK
ijPaHU5lrv0BZclti2R5HPTe3b6k1WCXTxIiecsxzE4vvCHM67ctr/ToR1rg14ng
LY9U7HoGyO+s9ggeCJxTvR6Nss66i3Y0lJI0ML1myQqvwpwM3lHMzZvgKKi+VWl6
3h7QvUaxPENbEzKfFZboDkoj/0f15Fl2F5en1g5qpqC4BJhflqxvLVMSImB9wOGy
TUeCiFNJ1atCQO6X+PwPpi0+nhp804k4OZ4DW15Nkmqieit+J8p2LyR2CPi+bQNO
BNiZWGV/H3CoVglSOwqbkemd9bSv8wU5Z61J3Xf59u2kUW019WrjnGFTPZsV/boC
DHaaT9e8Ckrcnjcf4hfZ
=D8vL
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
