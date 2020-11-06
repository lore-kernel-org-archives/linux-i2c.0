Return-Path: <SRS0=0v3X=EM=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EE7C2D0A3
	for <linux-i2c@archiver.kernel.org>; Fri,  6 Nov 2020 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D96621556
	for <linux-i2c@archiver.kernel.org>; Fri,  6 Nov 2020 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SVxCmQ5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgKFOx7 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 6 Nov 2020 09:53:59 -0500
Received: from www.zeus03.de ([194.117.254.33]:58344 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgKFOx7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Nov 2020 09:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=OOoRDbLbmMXJ934wfWx7ByN0W5/2
        sWH7nilB2O61nb4=; b=SVxCmQ5DYqk6N3Fh6xbZv0CfvFyONbEVT4R03E61yi9d
        O00yKSLAYpqMhi8rWVeg8xQueBXRcIes2+A1wxbyIcsJlU8odxEK69fOXtXruN1q
        3vZ+AJebHBX0LwrMHDXUzPlz8fmwgvFT7TIY1z/CI7RlTI0rSZzSFc57bnnBcMo=
Received: (qmail 982761 invoked from network); 6 Nov 2020 15:53:57 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Nov 2020 15:53:57 +0100
X-UD-Smtp-Session: l3s3148p1@Gw3QYXGztqIgAwDPXxn+AAvEwmht7CYV
Date:   Fri, 6 Nov 2020 15:53:56 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Khalil Blaiech <kblaiech@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH i2c-next v2 6/6] dt-bindings: i2c: Convert DT file to
 YAML schema
Message-ID: <20201106145356.GG1059@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1604432921.git.kblaiech@nvidia.com>
 <c81a0679413dd77e68bdf7e3023d1a54e62f26ea.1604432921.git.kblaiech@nvidia.com>
 <CAL_JsqLC5nzPmNK41s3fB6nnRqjC3DXPfYn1uqdytrEKqFBpXQ@mail.gmail.com>
 <MN2PR12MB3616B19658725BC33D61FBF3ABEF0@MN2PR12MB3616.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
In-Reply-To: <MN2PR12MB3616B19658725BC33D61FBF3ABEF0@MN2PR12MB3616.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Please fix the subject as I asked in v1.
>=20
> Will do. Very sorry about that.

Waiting for the resend of just this patch. The other ones are already
applied.


--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl+lY4QACgkQFA3kzBSg
KbY/1BAAjr0siwvyOur4oU1xBNf7GFSuKrbKot1cPaeieMp4CA1dEPQ7x4U3J5cG
ovSElyLcQHfAlmjGh13/Ky7Slr0N8qxVPjKZKMABJLyo0Z5wC094vzHTD5GxbfgY
gKBJXVFrwviSa2pTYn2x3x8AHLwOzwtcSm4o4lXQ5wclg6rYGe5utu+1YCIcVk6i
89gtpdm8ZIJEYkYglrPFYmrQ48heAJxxjb/gEhuhATUQ3237CyEi0Dgv3kpfdb6c
vnorC0KVVQeCMdPi/plXzv2XJ+AfGvVbBb9DYD3rozhWNSlg9qRc33k2KOEjAOkU
jbNbeDGwhFsl/Z0x1WGHFgKojWhwuP59wz5OCIP/bSkjLayovS8quvfPxoktMS3u
o06BIV0khEaHbWJK5+EnE2egbKom5qifeNfaEAT7xPI1l7mxmpO9K0ySlHAVn7wf
Hk8LO60kPsLQrJ4ZVhREIVMT/9hq3QSriuIvrsJV8Za3JAPRsMEghNzZtpbFoqou
jLBYA3RS0q1OgWDPVasRsntYIOF5YWnLdSDiO5OpSTs78H4B6XQFz/sNAafxYbuX
GqeORzVnJo6LI8spfYGdR7gt6yqbDjYI9oCs7IUKlV+wuKBGUTP87BkbDgH53qXB
l3q+7DQxTEyp2B8Q0a1n8aofD4xxa/A3yxirsH0Iykq/iLs+GpI=
=WuK0
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
