From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Sat, 16 Feb 2019 13:29:15 +0100
Message-ID: <20190216122915.hchghozcn7ntdkbm@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
 <1550316723.30065.44.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7180055415413143207=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550316723.30065.44.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Qii Wang <qii.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, srv_heupstream@mediatek.com, Rob Herring <robh@kernel.org>, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============7180055415413143207==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvl5pgprc2c6iamr"
Content-Disposition: inline


--uvl5pgprc2c6iamr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
> there are I2C and I3C controllers on MT8183 SoC. We will remove
> "mediatek,share-i3c" for I2C controller driver, so these patches are
> just to support the I2C controllers on MT8183 SoC. For the I3C
> controller we will send some new patches which are based on i3c
> framework directories(kernel/drivers/i3c), not based on
> i2c-mt65xx.c.

Sounds perfect to me. If it turns out that the I3C driver can share
things with the I2C driver, we can discuss it then. But unless we have
an I3C driver and know for sure, the above strategy seems good to me.


--uvl5pgprc2c6iamr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxoAhcACgkQFA3kzBSg
KbZX6Q//fbtn+bsK5KVjERP9EokrSE8Pn/Q8MsFHFKLxQm2ZQsc2yMzOu0YUYvnF
X531Roh9TkDU3SkJL/xnERFtamDianlugO11qGRxvJnSGCjrUDogHdw8awM6BE1e
G01y8agD7lRVmrZb3AidW9HAfgCBalucvrKovIQSkvvhvnCglVnZHBpwmQwFEZ/E
NlB20w8KdvAKNXeT8GgxsjFBfanSHAHOTJKUcnkeO4Lg10TDlnh85c1FGcuOmbcE
j0yvYzcFIUJ5Xdw1f0BVG12RDuN0pOSN/FuVDZRBb/FkOJx+CIb62jJiieCYVTMl
/jwL6gkGbyZyo2YJJ/P6twDzxXE3JtjP1gtnN9FPBVFOeaWN3qoabOM/aO1iWlZM
K2hsLVorxvdHedrDEqwNFawEFSF0Y2sdPCndwlgKRqRcdJRh4f5VzPNXTxDmPeQI
5zubdYEA1dE8NfX3xM4/05/vBNK9JDwj+U5EczvGL7PI+q8n5X/QoQqu7x6tWMq8
D9VMUWRpM6usbQ52gt/hQi08taNuaxP4BQJkDduDVZ/x09aAdKrKDStwtwhIABH1
gnLt/3qJqEo6o2LM6fpK/hvhUgjiZ5KlTJ/RylosAcAbRkho4lFwI6AyzEGRFGHe
lntFJiamVASorn7fg4GVdNNJAzVsNTIdVcSJfxij5TjtbqVjiBg=
=2hOh
-----END PGP SIGNATURE-----

--uvl5pgprc2c6iamr--


--===============7180055415413143207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7180055415413143207==--
