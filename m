From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Sensor with 7 bit address above 0x77
Date: Mon, 27 Jun 2016 14:13:20 +0200
Message-ID: <20160627121319.GA1648@katana>
References: <17002e23-eaf4-125c-9402-4def2bf13e51@sigma-star.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40874 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbcF0MN0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 27 Jun 2016 08:13:26 -0400
Content-Disposition: inline
In-Reply-To: <17002e23-eaf4-125c-9402-4def2bf13e51@sigma-star.at>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: linux-i2c@vger.kernel.org, Richard Weinberger <richard@sigma-star.at>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Both programs mention the limitations in their manpages but give *no explanation* on why they
> exist or where those special values came from.

That could be added to them. But the first thing to look for such
information is still the I2C specification which has a section about
reserved addresses.

> The comment above the line states that addresses 0x78-0x7b are used for 10-bit slave
> addressing. The documentation on 10-bit slave addressing (Documentation/i2c/ten-bit-addresses)
> says "...The leading 0xa (= 10) represents the 10 bit mode...". Wouldn't such an address
> on the bus be quite problematic as 0xA has a leading 1 bit (read/write select?).

Please read the above specification to understand how 10 bit addresses
are transferred over the wire. I think reading it will answer most of
your questions.

> Is there a specific reason I can override i2cdetect but not i2cdump?

Probably not. More likely, nobody needed it until now. Which is
understandable since the device you have has to be considered broken
regarding the I2C standard. But I think patches adding that could be
acceptable. Jean has the last word on this.


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcRhfAAoJEBQN5MwUoCm2s7MP/2yR2ucxAAww8wUBIh0k4Jtp
U513bWo794i8+ZTdREiKDQUaNHRuFyrWtfVSR43ZBNfqbNHnekakTZcpVyFmB92X
J28RrIsMj0jdGOVxuW5n8VOeszgNckj4G5PbvWtcycQAltl17JesxHqNMNNZcZck
4V1bNSvxbEnoeJf9C0T6WNojZf6ji3XAaa8xU4M7OTXAguOBX8aFyt0J6Ww5Z4i+
yGO5tLX2Kuakf9/ppgYBiWsT/YBaZ5UG6EBzOhIkSH9KOTVMRsRaDXlGqgiiJ6eT
Ahh/IPHjrLWT8sWNTlqx/WNkFZlKzHKKv0dmfBp4AYp5ik4YcZcLK+U+cs16lp3R
x9l8IUKGKxsHumHecLhscR2nifd4Qg+7MBN0ou7eqDoJ6UtJuw7kajhbx6ja/fP8
tcAuLuyQyBGCVFT8bxodWJNFCMM/oCFxtEjinpsBQh++OOX3HTp+pDqlkBfclLQZ
6GLY/g9vzc+0DXKeWx+crVLXGMEVCT/R+FJpTEcR98nbOUgnoUkzLg1KZsLFG+LG
ZkxqhIKYKf5kjiSfAxdz5naXAGiNdROyVmE6nqTxiRoOyTnZtwBp2wNtswzi89Db
oXZgUqSzfjotb7636tKQuW37kif9HtytIqqFc7LQsCc6MFyL5oBvLkwjFWUERyf8
q0SpE3GjkTQBT+nrDVS3
=wIvX
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
