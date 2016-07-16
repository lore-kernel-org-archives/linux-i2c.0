From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C
 master bridge; Feature request: introduce I2C_FUNC_STOP
Date: Sat, 16 Jul 2016 13:51:03 +0900
Message-ID: <20160716045101.GA1677@tetsubishi>
References: <578612EB.1060709@gmx.de>
 <20160714095812.GA1563@tetsubishi>
 <57878B55.1030200@gmx.de>
 <20160714131921.GE4149@tetsubishi>
 <5788C54C.20705@gmx.de>
 <20160715112559.GA1695@tetsubishi>
 <578930F4.4080707@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42055 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbcGPEvV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Jul 2016 00:51:21 -0400
Content-Disposition: inline
In-Reply-To: <578930F4.4080707@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: linux-i2c@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> What's the correct way to test for struct i2c_adapter_quirks et al?

When you upstream stuff, it is for the current version only, so no check
needed. You can do anything you want in your private version, of course.


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXib00AAoJEBQN5MwUoCm2WWYP/RDKbhPTQQia2S+qB+ytATsg
0a4+LDF8FuAhCK+Mv6d+bOOgAA5YpnIPAF0uR5djQLBiFdL9ec1KN202wDEovL3m
fD0k5BvtWXMH7/gpqP+qcY5rEv7OH83emIp6ZMnWO6lGkVM8KyiE6ogGNAB8oLHX
P3EaT29q4c6npo+AEZzGGFycoBg8MZ8w5/QUZYx9dTAhDEO93gLWd6OnPOjeAwEj
hAtbucxq3OzrXx71UXLTkL7z6c6pUTrjHANDh4RM1h9fDdm8Kz61kmglgHWQ72U7
L6nfarqAI34hEXk/qMOhs38cpJV4tSrHDpAVmlsupH3GytlG7QRedcWdginl06QA
spfovd1uOtcmt8+gty2z1tXZ6XWftSubZHbNuwistTB+x9Ur8brk8VsXP82Hbi5N
4z5XGbsHPNG9AgcrYVYBsSCqejh69mc9nzu6OmCxVdQiIAgLaXOE1h7yYJlEhcg8
mFCdVAnJCO1eo1bsxXV/ThPp7qLCEJIEYqKRn/wqWWglBHQEDlq3XCTwNu8Kuvx0
iFCWCR6Cjpq+JZ3Lv3wZpVpbnUpTKR4ZhcfutZigbg3+ezfeY2rtjrrpQW2CfkhD
dQ/83UN44u/9BOTLga+ysduVxTSVs7JnD4EKMfxI8geSe7I7nvPYOU8LssbhREDS
2AvZYJ0y5SvVx753i0Od
=koSh
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
