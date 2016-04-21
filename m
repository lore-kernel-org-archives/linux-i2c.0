From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 07/19] i2c: octeon: Use i2c recovery framework
Date: Thu, 21 Apr 2016 23:33:34 +0200
Message-ID: <20160421213334.GA1538@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <ab24627b5928f23967633243639b431d2113dbe1.1460387640.git.jglauber@cavium.com>
 <20160420213121.GC1546@katana>
 <20160421130835.GA2623@hardcore>
 <20160421135450.GA5566@katana>
 <20160421175110.GA2710@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51088 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbcDUVdn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 17:33:43 -0400
Content-Disposition: inline
In-Reply-To: <20160421175110.GA2710@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I would like to disable SMBUS_QUICK. It never worked for the read case.

Fine with me.

> Could we break something by disabling the quick-write case or is
> the quick-write emulated by a larger write if the feature bit is not
> set?

No emulation. It is simply not supported then. It is actually quite
dangerous to simulate it with regular write.


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXGUctAAoJEBQN5MwUoCm2CVwQAI/iN6vBTLtY8otQUUNGbex1
P40BpDvtnOAEaGdhmEzIa9XnO4iEX6YW1JX3Plda1FWulYKgqxWFxFXR0+LVSc6Y
7QcBZVyWs4Anwe57JpOIIFWEeKBU+Db5FamFMd8mJVtsE1haOlJzMv/vZz33jNHq
0XyFuQgt5xAUFojQDeG1SKgaszZbjCIf9DDxuY7apROi9gXlJVCJvAuY1mfnCXSu
/Rv/d9oziglZWleRIw/oo6YsPUzlNHmH0UTvmSeOQJwZLH6Ya9xuNDEj18ms9Y/d
Tdvhs1tmZ3IsGZP5g0sZGODhpBBpf2OD7oOcm2p/LXPuCWZ2xuhkCefjuugMODXO
8Djz9LbW8ZfFBFabk95QHg7cJpB0hSxNl0Au8QxRZvbPdE/tUTEJQdp+gh8XrNK0
eQgr9k74iIzwIydZ58euAmBrLexdA4Ehkwtv3qsEJ+wbffwCwseIRV08kl6DoamO
LP/nCr1TQWZCgA1IoIjAsPwNmDS0RCaVmuNLCAzZ41tw9QjF9CcW6pA8RngF7Blv
4V+yYYwjED+gB5YYtDOCjrYKWjpcqGVRCMFiQ+COubLglyLVQSYrxo18KChvxtJL
xoow2jhpIqq49GekgJSdEM9urQQzhCqtW9nXSyMYyAPoSM3Pc7p/2Lesb297oM4d
ddZr8Fy1ivFQ3olNuDK4
=YGPx
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
