Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2223CC49EA2
	for <linux-i2c@archiver.kernel.org>; Sun, 20 Jun 2021 20:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75D060E0B
	for <linux-i2c@archiver.kernel.org>; Sun, 20 Jun 2021 20:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhFTUoI (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:44:08 -0400
Received: from www.zeus03.de ([194.117.254.33]:50776 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhFTUoI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 20 Jun 2021 16:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=oGBDtaLCRYxKLuiNto47hLrUe6iq
        IFEyq3rpq71mPPw=; b=Ya4JIrn7xQfJhGVbRb0futYX5TQvnfaaFCwYZyYroYyl
        lwXcS22qLFHHzLdmYuY8hp+Ky4EQRYYiT/IkkCQENoihgpWBwvmBUXA8Ex/YE8WB
        MwLnYHbDDI+mIC2176gT4UU3Au+2a4alcfGC1iyWx6nYM5VXKtXzM/vzkng3Xvs=
Received: (qmail 1498167 invoked from network); 20 Jun 2021 22:41:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2021 22:41:52 +0200
X-UD-Smtp-Session: l3s3148p1@U3gJljjFtqAgAwDPXzseADJuEzJK6i8P
Date:   Sun, 20 Jun 2021 22:41:48 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: renesas,riic: Document RZ/G2L
 I2C controller
Message-ID: <YM+oDO6MiTdwTopm@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20210615085400.4251-1-biju.das.jz@bp.renesas.com>
 <20210615085400.4251-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yWTRkghC0kLYN4EP"
Content-Disposition: inline
In-Reply-To: <20210615085400.4251-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--yWTRkghC0kLYN4EP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2021 at 09:53:59AM +0100, Biju Das wrote:
> Document RZ/G2L I2C controller bindings.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to for-next, thanks!


--yWTRkghC0kLYN4EP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmDPqAQACgkQFA3kzBSg
KbacnQ/9HliN5XI+gKNE0BXrLs01J0lK5nKzsRWtHuFbLfy4tjU+YXrs1VN7jTI0
Xaj+wiOCWkm4GiFc+RvUBw0/GhYX9iVMwtEhl4ZZjOIEQMUX4PNvxM7gIiTaMznq
NHZ0ThLwr0eCIW/tIRycgvRlyJDYsBKa8+37RJMI4/V46VHBrEFfrCNPugxqNBQO
KK0n5DKQuLR4vKdvLvc72KsMqrQdPqBx9VzXZM8j4/BdN0iDNiByk30YKNhnspfo
FwXXuwu2o1ez+0fUaPyjjfb5iFMn+goyDM57AmLcemnaO4+mcYIkoU3SeVzUMfBL
IO4VwNreRzNCoXqkJyMAOGJwTPqvyjhNibEW92FSRx3ealrxJ9Cp2nUQ9HYml5wx
SlCcmEchOk9F/BZMnEu8YHEypBL3Wu2Wo69jE7bz4uOJdQQcPwh/yHYdWEW2fQYI
UcWKacfjOcyU5xuhySdmnlSp5GKrhE4iuF8awL8n3n5ITMdRpUPO3UEbc+SkOyeD
qd+KG09nBB5SIjyNqCLmMuIAj9/ba5ARewfWZjwK/IER3vTiziDlQdkzhmpENwy9
GgLcTTWT82BpPj3wTCmlpX/zD+Ld+D4tB5kCBfNLmA3TTbZtUOCsmFGwpIh3nfDu
8w/PsMaErSNkqZZovOk20veFNaZlkKGiPmLMkKki9sgyiBZeBug=
=pMD+
-----END PGP SIGNATURE-----

--yWTRkghC0kLYN4EP--
