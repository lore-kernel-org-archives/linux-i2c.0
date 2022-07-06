Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2ABC43334
	for <linux-i2c@archiver.kernel.org>; Wed,  6 Jul 2022 13:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiGFN54 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiGFN5y (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2022 09:57:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE817048
        for <linux-i2c@vger.kernel.org>; Wed,  6 Jul 2022 06:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1962B81CE5
        for <linux-i2c@vger.kernel.org>; Wed,  6 Jul 2022 13:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D67C3411C;
        Wed,  6 Jul 2022 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657115871;
        bh=jh1o7T82FQXTSSpBNwJVIBwjoXhldVkF5aGcugpqNSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaV7j0G9G1ECgzcAyRAI9S0BKIKFvctQn0o37F4Nf2BBXYlMHNv53CWHzSysLIKon
         S6lLLnIkX40Qk9koFZIXZ/DDekWgoeqRpWD4XFQxRp139EB3tXwkIk0UO5QkV2exuP
         ZoBEK1q//iZfA4W+YUYwqbVZMaV+GhcgbjPp7vwYw4dW1DufqJZ7UhsATpTZNw7nyC
         wyIrxObEJSETGHp7X5CKUX5mqeQwonSvx3okmKlRQ0ILpJoJlb7KGhMu7wUHlDIvYf
         7S7z65n6RuJfNlPexJTWx8TAk7wSlHkJfeDtDzv7pIiFidz0qsNtU8SiCoglWaRKL4
         H5xL7mT7Jc0lQ==
Date:   Wed, 6 Jul 2022 15:57:46 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-i2c@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: Add power domain to binding
Message-ID: <YsWU2p2zSzgj0pKJ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220701225303.814888-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IM9a15A+X9AWQR9b"
Content-Disposition: inline
In-Reply-To: <20220701225303.814888-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--IM9a15A+X9AWQR9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 02, 2022 at 12:53:03AM +0200, Linus Walleij wrote:
> The power domain is used in the example and in the device trees
> for this IP block. Add it.
>=20
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Added "nomadik" to $subject and applied to for-next, thanks!


--IM9a15A+X9AWQR9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmLFlNoACgkQFA3kzBSg
KbZO3w/+I5XaltNt753JxtHe/PJYjkBEG/I/dPN/xDIKrBLF3x8GIkz8n1vJP/QC
wjBGMYFC9bkFloETRuOBkChGI0yNPeGkKBDLJ6lF+m4SS1PBK0zgZ3s+8Qcql/xA
MxdYB3Jbsg+w+k0SH0GD9cT295bTOKtE18hA8/1SioVSw6tyW+jIckb0F2qmkOue
EatTCvDfWQmy88sbXxY1dRSFEhPr+/fshavztk9Shm16mH94V4sJmVW8vzRwVQKA
vx0Ps4d9UQdvcgP3853/JN7fRrL74SIoaVmEy4wSl9nkSC9ONOwr+pz6Kh82iy4b
2sKq0V74PLAB0UBFbIzImuYNZtf4G29hafOn9pbHN2RjZfy9wFtGB1D6Smu8IDTu
2aDKN5aJrzsfsGJvZj59GcvUF5yTH8jivIsA6/ycrS7pzKKUc9CCdPEvMVNKJRlx
Z3pCLsOkE5gKgiucRhxbAADSYvLAmZQgyYlaHuQrR6/nPPzOuC7nRtO2KMBEXinP
Npj2GMq7JpZd9FaboKR1x0ghI+MVGVriTaHQAe0byQDxbDKvjxb76DFzgEbXE+jx
tpA7WpgWhtCWswosq0m/bTOX312lK2XTdpqW7Jnr1p4qXKmF3bq7SYXLVzIU2nls
KaS8tfDoQCoZw/WnKYcDFugFfIZuKPgfh2CwAMnaSs0ybJXa+LQ=
=Npwo
-----END PGP SIGNATURE-----

--IM9a15A+X9AWQR9b--
