From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block reads
Date: Mon, 14 Aug 2017 21:31:05 +0200
Message-ID: <20170814193105.cosdlbf5gypazlzn@ninjato>
References: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rucubi6p2bc74llv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50518 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbdHNTbH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 15:31:07 -0400
Content-Disposition: inline
In-Reply-To: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Douthit <stephend@adiengineering.com>
Cc: seth.heasley@intel.com, nhorman@tuxdriver.com, danp@adiengineering.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--rucubi6p2bc74llv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 05:10:58PM -0400, Stephen Douthit wrote:
> Hello all,
>=20
> We ran into an issue where the ipmi_ssif and i2c-ismt drivers don't
> agree on the format for data returned by i2c_smbus_read_block_data()
>=20
> Looking at the traffic on the wire with a beagle analyzer:
> -----
> Packet Details   (Values in hex; [S] =3D Start condition;
>                   [P] =3D Stop condition; * =3D No Ack)
> [S] <10:R> 12 1C 01 00 00 80 02 1C 02 8F BE 12 00 25 12 41 01 00 00* [P]
> -----
>=20
> Looking at the matching kernel trace:
> -----
> kssif0010-759   [001] ....  1435.891090: smbus_read: i2c-0 a=3D010 f=3D00=
00 c=3D3 BLOCK_DATA
> kssif0010-759   [001] ....  1436.202906: smbus_reply: i2c-0 a=3D010 f=3D0=
000 c=3D3 BLOCK_DATA l=3D20 [13-12-1c-01-00-00-80-02-1c-02-8f-be-12-00-25-1=
2-41-01-00-00]
> kssif0010-759   [001] ....  1436.202908: smbus_result: i2c-0 a=3D010 f=3D=
0000 c=3D3 BLOCK_DATA rd res=3D0
> -----
>=20
> So basically the byte count already precedes the data in the dma_buffer,
> then the driver sticks desc->rxbytes in front of this resulting in the
> trace above.
>=20
> The first patch tackles this.
>=20
> The second patch in the series adds a sanity check on the byte count
> supplied by the slave device.  This might be a nice to have, but is
> probably less critical.

Both patches look good to me. Seth, Neil, do you agree?


--rucubi6p2bc74llv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR+nkACgkQFA3kzBSg
KbYEIw/9EHubsFO9CyG0k7Q46YysKinxkoyVSukBvwSeq/WM3S6nfnPX2zU0d/cK
sxJ76WvKI3p8q9LwzuxI8TFKTd9kB2VbZYBxGjPbJLM/k5JGP2Of4RHx6KV4WuQO
UTLCpKJnxQTzhorULmdOxTmmhzTvrACLLN6gfXa89yWClP1m2J9CsoBtid4kp37X
6lrrt2VEEB5NeUQAiQtocvwphh23lPdmSeVKfsyxYl4HCQTp5A1HEEIBvlSUgND4
Q8ODo75vY2uZNoUgRror5tfjojKu5kznCMJlI5PHUXboBNFEh0s+O0SHsvm5TxYk
eZSHIKQmpvlr3vqt01E7aOoNFK4AB5zP4aRbU8Ww+0CA5L2MAkqivaK2f1rciy7f
JXN/x4F0pq1r+RydQ3UmaDM6taPJc/nqfs06SlHHQNtCy+BnCRx1/WObZjqKBWIm
b4IhQJGLcHGmfugfn5SIdLjAHXjMCWZphiAa2U1g/ejS48q5p1+jh3VvVmxrLsyV
GQ7Q6VNit2UlDkF/6fKMnuYeeu1R57j71OuMfdwpHk5zPGTGjuTDxCv9ksM+9Q+m
Qf2ihk2DMLJWnfm9Uy8bnKB/Sef3/1dwFK89I42KOApybtCOku8ZWDEbSMLopqeY
vBnwbJybVnzHzTV8l/cw+POixhs9ZDso5FFp9dkybSJsZ2/aEts=
=KOLd
-----END PGP SIGNATURE-----

--rucubi6p2bc74llv--
