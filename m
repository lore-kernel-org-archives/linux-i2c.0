From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [[RFC V3] 1/1] i2c: imx: add slave support
Date: Wed, 14 Dec 2016 14:36:39 +0100
Message-ID: <20161214133639.GA1476@katana>
References: <1481695291-11444-1-git-send-email-joshua_frkuska@mentor.com>
 <1481695291-11444-2-git-send-email-joshua_frkuska@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:49102 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753514AbcLNNgr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 08:36:47 -0500
Content-Disposition: inline
In-Reply-To: <1481695291-11444-2-git-send-email-joshua_frkuska@mentor.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joshua Frkuska <joshua_frkuska@mentor.com>
Cc: linux-i2c@vger.kernel.org, syrchin@dev.rtsoft.ru, peda@axentia.se, vladimir_zapolskiy@mentor.com, Jiada_Wang@mentor.com


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2016 at 03:01:31PM +0900, Joshua Frkuska wrote:
> Add I2C slave provider using the generic slave interface.
> It also supports master transactions when the slave in the idle mode.

I am confused. In the cover letter you write "Furthermore the state
machine introduced to handle the slave states does not handle the master
mode behavior." Yet here you say it supports master transactions? Is the
sentence from the cover letter outdated?

Regards,

   Wolfram


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUUrnAAoJEBQN5MwUoCm2n/8P/31HigqA92RiPsEqjYM7DrF4
68U3gxjNjBaY1BFtfkbufoDe6/UJbzIt+B6fQsEacvOqqYfiZ3LQnR84DKK4pTYS
SSuyNI2IkCiDcGf1ZKld1QxYOWTadW4naa4MvFS5YhDUymz/UF/kFVRa1TFDUbaI
m2E8Hx9ZUd+gsSXajJjR0X7m3JRReshtNPB+ikctmdDHTRArIMr5WeTEYsEqBpEV
aGzS3y4q4313XcshPWVk4NgilBpyuPnb/zvSwJrFAMootNU+h4v1DXWekjrHwpYt
JGkdHmwxY4pKmM/1JO0GfZIg7X6q3SEP67ASMQYVp+Vbc6MhNWchYAfIvyoYBz4j
q4+oqQ5ozluZ5ukIrNRyg3DTGIeEn3WfDME/IeA4KfeZqShqPmPzIuQgOGoAtdCL
ogthlI5Q40zKKNhv71iSChaHdhaBK9zoWIFxk5Qk8uKQg3s3Nxr6TNQJTM+/GkWD
80t4f5zSq42o+oFAprc30tGpQVwSGkAk0fG0Z77iMNhVezFL6IPphDdmhuDhRR37
NXYrSi9cX9CCtKzUqOSCLg8p9m4YOK4/5Vw79z/FAka0eVhwDU8+VFHWJMNs4HvF
ZEA2gXFYBWsX3ETG9JMpgH8q76X0vG5rDYNQEZh2aOAjsDLfcWM/rezAu7tshoqv
uA/sShNz4ai4+Vk6xhr6
=KTbd
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
