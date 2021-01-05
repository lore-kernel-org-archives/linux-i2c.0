Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBCFC43333
	for <linux-i2c@archiver.kernel.org>; Tue,  5 Jan 2021 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3292250E
	for <linux-i2c@archiver.kernel.org>; Tue,  5 Jan 2021 10:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbhAEKS4 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:18:56 -0500
Received: from sauhun.de ([88.99.104.3]:41198 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbhAEKS4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 5 Jan 2021 05:18:56 -0500
Received: from localhost (p5486cfc1.dip0.t-ipconnect.de [84.134.207.193])
        by pokefinder.org (Postfix) with ESMTPSA id 6348C2C03EF;
        Tue,  5 Jan 2021 11:18:14 +0100 (CET)
Date:   Tue, 5 Jan 2021 11:18:14 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Vadim Pasternak <vadimp@nvidia.com>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH i2c-next 1/3] i2c: mlxcpld: Update module license
Message-ID: <20210105101814.GD2000@ninjato>
References: <20201210165113.6130-1-vadimp@nvidia.com>
 <20201210165113.6130-2-vadimp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20201210165113.6130-2-vadimp@nvidia.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 06:51:11PM +0200, Vadim Pasternak wrote:
> Update license to SPDX-License.
>=20
> Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>

Applied to for-next, thanks!


--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl/0POYACgkQFA3kzBSg
KbbVnA/+OA5g7HggS1BWzwLPh2mCyiFsZPMRst0bFO1EQumV+d546XwrqnxfPq65
Ef8bgXmc517CY1RRHkXwZoe+KqHOyRAeGNzdEpumVuIY99CGusVT/q11dR+r7ZXr
Ze5KypWAoCPMK3etOdHQesk4AQDBmdNocU6idiOy8nXh6wU6aSpKe+9sLA1SmBit
DIBEndmVwqG07QFszc/qbCVm7PN70T1fRxzdXrw3CW8McWdX69yBC2WXrBduR0mN
ThUn565QvzDmIE2Poe6Jc8+Xz+aNlRDEGdG+ThMkzK5i5uYolHiFzX1FevoubrRs
qyavdnsqMEqdLdYhiZs7X+KR029eaQAKQoXede5e3s7wHHC1JuonbGX7yZKkfO8w
6Prpf7iZ0S6Ap3gutboDd7jtyTPFfmCOVzKsWMj3Vrm+YL5GFjYNtbCFR/zMjD/W
PmA/QuMxxZmBDkpjAY2Q437xwk4WCUOyv+7hfDT6IMZhPMYdza/8bFoOMi6Wt3kX
Ud0JdWQO1jduM9kb39ksB/XbGuKEAJYqsFRWwLmyNwA0f/YdRND3MvcJ+U1I1Fz/
naZodQmHPuVUMowsz574oY894Fqo00kafgpzk7lGXgTTHlYLsrZXvHIJ7HDkv2wF
Dh1Ii006X+ic3wPuSfhdhedx9eHtjmk/MidU2O82PqBCN86VqX4=
=CSiW
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
