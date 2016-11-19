From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [v2] i2c: xlp9xx: ACPI support for I2C clients
Date: Sat, 19 Nov 2016 22:10:04 +0100
Message-ID: <20161119211004.GA10986@katana>
References: <1474886583-10569-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:33708 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753117AbcKSVKG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 19 Nov 2016 16:10:06 -0500
Content-Disposition: inline
In-Reply-To: <1474886583-10569-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2016 at 04:13:03PM +0530, Tanmay Jagdale wrote:
> The ACPI companion of the adapter has to be set for I2C controller
> code to read and attach the slave devices described in the ACPI table
> with the I2CSerialBus resource descriptor. Used ACPI_COMPANION_SET
> macro to set this.
>=20
> Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>

So, you did resend the patch and I missed it. Please ignore what I wrote
in the last mail. Thanks for resending properly and again sorry for
overlooking this patch.

Regards,

   Wolfram


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYML+sAAoJEBQN5MwUoCm29NYQAIYk8G1O9AiEubzHnHESlLBW
JuC0Bb/EEodMolt1TYzjeE4OURRsBk1VNMenbqavSPCszpm8dwmTSUEGPeqtPAe6
xxwR23KhIoldT4sb89XkN5PF+GV/vuUYGDrsnDwN+OdZAMXkcZgLzUHo2jhBCeg3
zvqpVKtRRbW1XwBuzizKvbyDtyLTH0inSTCB2pRoco07aZhOmh2VeaxNe+K8deGH
RFGDHXJb0+XLnM9X86ryXLkL4ox/qo2So/xO/aG1rwRh/sjXG83zYJ//NrI80wLg
dy/ChlWmbwnzE45+WkLPZQY2eo7MFWYRtCh5zzOwGiaov1Dr2I83ILsVh9UMldOL
+oij+ym0cIlmn4WLdUv2FRPBHRBvoEQ9G/+U4syfesZdozNEWSnPUIX4ZEFrtCKK
pFF1/jR1pCk1H56IHpSKziA18WSLa8uvfbj4aLq+DDxRjIvZhazOccsJfx88sTpI
eta+LfBzPbiXfkpkt7NTCZiWQovCoqMSUtqAWn/1cTv1HWxltebn5EYdddgebY38
KATlBJv0o9lM6EE1tf7jP/ueOjs+n+htjX/wkH1fnUAdjjV6rkyqVnGue64sR3W0
AbOCBd16iJRkdDN2M2frYlk/pfRwQXXm/Q273jDHGdk+QqPkmQ/SbtRvGHQenFrd
9sDaULqVRz31aCwL2Oqh
=hr1r
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
