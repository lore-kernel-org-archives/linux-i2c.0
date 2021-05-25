Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528FEC4707F
	for <linux-i2c@archiver.kernel.org>; Tue, 25 May 2021 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379AF6141B
	for <linux-i2c@archiver.kernel.org>; Tue, 25 May 2021 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhEYTzY (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 25 May 2021 15:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhEYTzY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 May 2021 15:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52D94610A5;
        Tue, 25 May 2021 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621972434;
        bh=HgxpqZZ8l2SbOe5FloTwZYVSDDUodjonSzDlKnO5XEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxoeKBw8EurWVzk9nhr0aoyB+atJDfZtkSDT1xX1UOPPJ3WeY9b1S6xvourjtJ4FE
         l7DoXS4glpTCGx5QLnG32rj8lgpEIuURUGQl+u/d/i5hYnx55AaMfQGcsOjcnLehvd
         lTMabTU/ekrt2F9bx192FrAXb18NZGBlaDkp/c1QgS71SYsi9HWz6cU8xed/fno4i+
         1s/MD9pAGqWiWE2QudIEtI/ez8i3JV8CeiGqihdAgBBQoBtxsJ3q/eemOeQDe+dvNe
         oM7PolVW/IVM20AYE7a0uHuFVNIOxaEtWxXChfADod1/aIhiMePwrHR9lP7k+8Ckkp
         EaSg5uYMxyDkA==
Date:   Tue, 25 May 2021 21:53:50 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pierre-yves.mordret@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v4 1/2] i2c: add binding to mark a bus as supporting
 SMBus-Alert
Message-ID: <YK1VzirZB/U59isX@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, pierre-yves.mordret@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@foss.st.com
References: <1620220479-2647-1-git-send-email-alain.volmat@foss.st.com>
 <1620220479-2647-2-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AKRPigYTIbga29mT"
Content-Disposition: inline
In-Reply-To: <1620220479-2647-2-git-send-email-alain.volmat@foss.st.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--AKRPigYTIbga29mT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2021 at 03:14:38PM +0200, Alain Volmat wrote:
> Since SMBus-Alert is an optional feature of SMBUS which
> requires an additional pin, the smbus binding cannot be
> used to indicate its support.
>=20
> Add an additional smbus-alert binding specific for it and
> update the description text of smbus to avoid mentioning
> SMBus-Alert
>=20
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Applied to for-next, thanks!


--AKRPigYTIbga29mT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmCtVcoACgkQFA3kzBSg
KbZRHw//XOHGt+Fis/ZvIW57WMjfZfRFfvk/dG8KknIIXILWUTnAiy9kzCKSsEES
l/x7+Csx7fR05vjsNkkh/S+dMq360Ox5dNnLUoHo75Ng28tDEcJ+cRNTTpMGP2dO
8zDdhmiuyFvASEGqtPLxkSSX7FVVylJwyxCHbwHnbHXK2NXArot5j3tcburX/B5a
PFlXsYRnPiKv0InSKSk4Lvf4iAZcOFGuSbIKnWP6Jvpd/BKEhKWHj7/znI5L3qVa
3v86g3NE/VKCud86MT41FAyRvba8uExBKfizYq1qoZ2yVPAqLxQzoSLJcCnOPbmQ
Bc/GolJFJRGaiIi0mCHdTXpEI/S+1iNZnMaUFvfqCEtjZcvVy01RR4rR02EJT8PT
P3PLfX2pXq/vcWTm0ZEtPq1lCWETV93SG6fjv5MZ6tCILwT18NvSfXoE8nreB9d/
/AoLsP7VEN3b5hHfQmps25GXWkkcO80/Ye10WBiC49bLjmZyTUo3yUxgpPC3m+0A
Xno3YNiyV3JgwNnx/jChW+hZjjcl4m93csgMrV/bKrH6N8OE7HU8cRrNUCu15pUI
RS+uX0kx+Jly0Fhku/QKsYgwdjm5icGAS0OEKyheDER6AJKZMwjNmuzWwSkIWQrx
f7iV4qL6wPD8OwApY/GYZlgQictaQr8NbEUk5x1rtosDSd0bWFY=
=UjR6
-----END PGP SIGNATURE-----

--AKRPigYTIbga29mT--
