Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C41C48BDF
	for <linux-i2c@archiver.kernel.org>; Sun, 20 Jun 2021 20:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEF16113E
	for <linux-i2c@archiver.kernel.org>; Sun, 20 Jun 2021 20:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhFTUzW (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhFTUzW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 20 Jun 2021 16:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C755610A3;
        Sun, 20 Jun 2021 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624222389;
        bh=ZnHA0Xq3HcBQHq3Y5jNt+1+CFr97C73z6OIAzo7jye0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rm1eQQV3sqve8xpyBO9hD09k0B9nVuMDfDWgr7yXetRzs3TgRzNqUcgnvxhndD9ZW
         SwK8o5FwMF8mCECxdWuNVFfrDKN1GOfSivwT4SMTJj2MaiLLrtGk+ok0v68eVxW6EH
         Ak6iRX9GT/9TtJ2/Osqtjm+sbUi3w/JYNdXlfQMu28ne1+OUc6tQ1IdBHYxw96f3uJ
         zBGJ6Apqn5CGLYpYiJoVws5LPZpLOQxwPGKNxkiZusTuAwdHvBBu7CemaThAdqLNou
         IAMSAv/hodz8ft5jY47vlmCXKzyD4+PAtXAx4y7CPVCnveJAmILiIhWHcsTxUTtedz
         4VGEe9I0wRftw==
Date:   Sun, 20 Jun 2021 22:53:06 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH] i2c: i801: Improve status polling
Message-ID: <YM+qsq7Vg7wNfAAu@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <4147230b-e88f-52e8-1241-ad343f77628f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="51cSOQb/e0keEIz/"
Content-Disposition: inline
In-Reply-To: <4147230b-e88f-52e8-1241-ad343f77628f@gmail.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--51cSOQb/e0keEIz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 09:59:05PM +0200, Heiner Kallweit wrote:
> Polling uses the same timeout as irq mode: 400 * 500us =3D 200ms =3D HZ /=
 5.
> So let's use the adapter->timeout value also for polling. This has the
> advantage that userspace can control the timeout value for polling as
> well. In addition change the code to make it better readable.
> Last but not least remove the timeout debug messages. Calls to both
> functions are followed by a call to i801_check_post() that will print
> an error message in case of timeout.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to for-next, thanks!


--51cSOQb/e0keEIz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmDPqrIACgkQFA3kzBSg
KbYXsRAApBwTFF5vCMz1MJAlDUOFr9f1t5ISq2AsUYIZuEDlbAN5jiwqogAEqtyU
NAG6aGUyfGFNEo3ffeOQNeFRFxMezsb13HuPhuhIIvQX+B1jIN3gQmRhaLS4Y+vb
ae5aK9GOQzfjhyaUuh6V+ZIzhAQiyVlsK4+w0Kc7yKwUAGRRqYBoktEkyjS9419P
TQXeNDj7ChBihCmfN64MovfCXi9eSShNjpDE1dasDsjIAASsGgmz9EldrRPLhW2d
xD1JG2UgunmAu+RC7YKRti/ufzEu16a2FxZUtYYzZHOv339xcjgD2wE0pYdHzWNE
AJ1LLWb04m48IoPJxdyxeEGENEUtgwvUiEnualkmVMq1rUR57xzITkUm+180STkQ
BXBgV0iKexbM9bHuE3mPOkkWjJ4KcC8kOFdPoVfsbMcdNse4EY06MTdy0xFKeMET
n8oDQp6q+9vgNtWzIhpBIFl4dF/T4an2hGm9v20r9yfNbFpTT2ncPhs6jFkIa2SD
K/WrT1szNqf9bhJd4VOBJMONsifH09JE/ALTZYla1bx1GEdGay3EGuY9NTzkiT05
Q5H2lnAkiMloX2UpgYWciofhJan3SH0tt9AmQs/oD33fbThyRAiBT+fvn1rwVae8
OilyoIG0bfTRDYA93Sscy9jAd+dnUbfqVtvg6q3YJ852COXQv8Y=
=uyAs
-----END PGP SIGNATURE-----

--51cSOQb/e0keEIz/--
