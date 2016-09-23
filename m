From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: uniphier-f: fix misdetection of incomplete STOP
 condition
Date: Fri, 23 Sep 2016 14:12:45 +0200
Message-ID: <20160923121245.GA1580@katana>
References: <1474632241-10440-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474632241-10440-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 09:04:01PM +0900, Masahiro Yamada wrote:
> Currently, the status register FI2C_SR is checked immediately after
> a STOP condition is issued in case of the deferred STOP condition.
> It takes typically 5-10 usec until the corresponding bits in the
> register are set, so the error check for "stop condition was not
> completed" is very likely to be false positive.
>=20
> Add wait code to relax the status register check.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Use readl_poll_timeout?


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5Rw8AAoJEBQN5MwUoCm2hEkP/1GFfxA7Q7B4qPz5F14UeHmw
JvgNAuE4QbPe9B7AMdZ2PMubFH8XN2vYd8wso/kYXWagC8nLsIY+c9kTFmdty+u0
tIkJQmagztmHzNLyzMxuvjr0EiB/OJ+AaRTKryey/R2tKYen3g2RVRRRJmQ//hJG
BQP0cjWMHftwdor8gqU+K+PQYFNp7Lrt5WhdpP1rCN9L50Ppw8fxLARtyuKObBSK
STzg+ygjUV5i00U69pjoy69xGkzbRX9LlIg3hPjJPf+dvB1aPAXuDeZb0CDk1NtT
Fq91l+n9C1bNhOg79qFlHv353mc1Th2tn4NTLBaCUsXpD/wl3lLXvlhfVOf64I54
txNIMPx5XfZkTFnui/Wrt8rViYX+asEORF5J8RspEG1hHiweyoC3OFSzFlGD0BHR
Ats/46qvTEm1ExHZCK3bs/4zdbyEgrAN9Am/8tKBtx3L0EZ3dbgxUhqVIYvTO/fu
l6fRTW9wrL08elsPGsRTl41JBpK0HnSbc+vjuVBnComLJT54nuCol6qrrnodE/ta
9cd+CFyc8TLM1sWtc9VQWjs5eeoEQjiIcY0KhSCmBLmpddKVLyXnwiqA1JQXWzGm
/k9AXbSMqFEmdy8xfaXnDmWa9qeCFD9gidOvcxnIpJLyORCRY8fXVYaDfl4ZKK8r
gLchUBEUaQdGiHCdb2mM
=0Iib
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
