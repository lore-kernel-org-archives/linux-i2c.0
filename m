From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
Date: Thu, 28 Apr 2016 16:57:20 +0200
Message-ID: <20160428145720.GA1541@katana>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
 <20160424211044.GD4317@katana>
 <5722107C.3000600@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35104 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbcD1O5f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Apr 2016 10:57:35 -0400
Content-Disposition: inline
In-Reply-To: <5722107C.3000600@st.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@gmail.com, patrice.chotard@st.com, lee.jones@linaro.org, linux-i2c@vger.kernel.org, Frederic Pillon <frederic.pillon@st.com>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The trick is to switch to SPI mode, 9 bits words and write a 0,
> so that 9 clock pulses are generated.

Heh. As long as it works :) But as you said, it really needs a comment.


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXIiTQAAoJEBQN5MwUoCm2HoQQAJVXADLKF1YydQLh0ccWiSli
y/F+0aerB4BrcPPGwE9KpFLk6t2PcW93JrPfB7Xg9kwxmByL7MoUH/N8Q8+w4bMq
1sL4R4ri2ggCw5zip6xwtf+eUBnKDT+jfq+NZrCHzzTEDNJ1lgHD4x5IkqbmXwJn
DCUpn3g9JTxPnimEFC9oi4BK9e8Y+5QgrDUKsfFN5sEF70F2ca4VuymMYuyVHMoV
xIBYbaTR4KBF3x2EzcfqPb3IW5thHRTf3wCQmEMvkaY2CAt3MKpJLtKjv2O0ck2V
rrNm3BNFtycakKmxIFXL/mknMarMoOiTDXnwDHQnpoU9ORQ+OnIybChI0UMnkotI
0Sa+1koNpqGvrCIi37lewb3FZTkGhR11NxSmiErlRlT1lQ+F2GUFS+D3QDyPjTJZ
jJ75zHZuAVUtUHsisb2tJvAANrPcpQ7BfjsqhWGibMiOhe/WLxqYiJo0G2JZe2cn
w0XM6ybR0y+OU1354Y7LRoqmCkuAp+sKLbC5Cd1qHBmhbbwBuUSBia7sE30k9eaL
7NzVJb/aIgxHR8ZNi3S/V9r4KfwqKmYnU2BJEVILeYycxfmAmouZ4Amm/OFNSSI0
zXbOK9ezUgf2nFW5s+AI3J3mcHoKzsZ4MMf3NKu5gJ4LiowefSfX6a3OPtCJDtGu
ANec5AXRCGdqT4jStP3T
=C25l
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
