From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
Date: Wed, 21 Feb 2018 10:40:09 +0100
Message-ID: <20180221094009.2zql6gbzkcklbakk@ninjato>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
 <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
 <20180221091130.4sdfnalrng4sd77i@ninjato>
 <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3170736113287939806=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--===============3170736113287939806==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zw5vzeqztqabjke2"
Content-Disposition: inline


--zw5vzeqztqabjke2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Will do. What about this (http://patchwork.ozlabs.org/patch/867169/)
> one? It's part of a bigger series, do you want me to apply it to my
> tree and provide you with an immutable branch?

Well, I would accept it for 4.16 using the "plain new id" rule. So, if
you add it on top of Peter's sorting patch, totally fine by me.

If you want it in v4.17, ok, too. I'd think an immutable branch is not
needed. There is a fallback property in the DTS. So at worst, there will
be a DTS warning during the merge window which will be fixed at rc1 time.

Unless I overlooked something.


--zw5vzeqztqabjke2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqNPnkACgkQFA3kzBSg
KbaZNw//TT2r48NErGqJ0SP/UOLBMX7g+ZFUC8WyLVmuQSrKy3opjuYvFOEd1EQA
v+84NHESJq64d/e1d6sC8xNHr5FxMIedqK0Dtmrb/m69E3swGWAMD3Jc61yi4smg
ToesDz8m4Zca9PhY89tK1PufFNeaD8bLae7RZgj2DHgH4h7gHVal+QwJFMShxECB
eoB4alIkqBcsq0B/zteEH5R8cWHdUQB5bW7tCQe5eQsf7W9tzZofY88pTddZ8tPh
udEn1YjJvuby8IfLrBM4YXbGViUmuQBuhsGEIODlloZQFT7u5InMIcO49fgPla3z
bKpQPCb/htOMA6EUE2BXXiEjPfg7KeAi6tUpm8Nrp1tAbLeggsw8ezPIWgc7WGHB
H284FsR+uX65+o3dZso5FxaQ9Tob5EifpwscII20VPQQ9+tMibN1Lo5R/77RyCzi
LDeuHECWxbQYiJZqrUbhIzUWGgl4DSYxyrqh6sKhTDFakmwrufBln3Rxb9LT7E3J
cVFiKY7tnWW0kfR6HX6I5Jge+lWGkiUO9b1NVbzfs/YK4LG4kxX3MhyoO6bn+a1Q
0rUKxoF4+0vF5i7PMhW5DqiIJu7h8ipcZ8OSxZjpT2oS/VLWvQLSO47p2uBhjGIx
ThDHyIa2sEGQyvehC2LppWvgC6yLq7Z+WYB8O70g8gNEM2xyYMc=
=RiDs
-----END PGP SIGNATURE-----

--zw5vzeqztqabjke2--


--===============3170736113287939806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3170736113287939806==--
