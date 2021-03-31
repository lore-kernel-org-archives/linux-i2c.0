Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3998FC433E2
	for <linux-i2c@archiver.kernel.org>; Wed, 31 Mar 2021 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C07619D6
	for <linux-i2c@archiver.kernel.org>; Wed, 31 Mar 2021 08:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhCaIH0 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234388AbhCaIHT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 31 Mar 2021 04:07:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6C48619C9;
        Wed, 31 Mar 2021 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617178039;
        bh=Ja9VAd0WgfwtpLLLgbMCEnzP8eHRe1DWO+chNtm8UhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y913F9xv5T6et6PSUQKWx36Qsl1hkverxnDSyewu7+f4g18pTxz8i05lNSdREGc6N
         d/lvyZbmnCYKHJAHo3idGLC1MD6fcNzuEMAIJRbbXOU76B78UXig6DwoxsbufS0sEM
         EGFB9mWdrq45HE5FfjgJmy/ST5QGRQ32La/8b6pUT2pWylmt7dbynSkFE78t8HOR/S
         whx+zoGzLy+nI1ELUXgAtywwAVvj2zMn+g0DaJnfTGwSkJX0t2NR+JXs86jVkPv/bs
         AJ0lgNqi6oj8XEQWZUa8yTPsUZ2hBstRVKRUkVFe1nfHsun1/jeayCUILZ22pveuV8
         mLfbf10OfOmQg==
Date:   Wed, 31 Mar 2021 10:07:16 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-i2c@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: Re: [PATCH] i2c: imx: drop me as maintainer of binding docs
Message-ID: <20210331080716.GJ1025@ninjato>
References: <20210329192409.7313-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Content-Disposition: inline
In-Reply-To: <20210329192409.7313-1-wsa@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 09:24:09PM +0200, Wolfram Sang wrote:
> I dunno why I got added here, but I haven't been using this driver for
> years. Remove me to make space for interested parties.
>=20
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

Applied to for-current, thanks!


--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmBkLbQACgkQFA3kzBSg
KbZFhw/+MGiyQl9KnHaInc+L8E/qsU9Cj6aHnw/jUnWMcjSu6tov9cH2p0+tnkmE
AcsKL8lWALIdm+Qy5pOD3UHS7jlgwTbJp589k4gXC4DpVhcoNuQr0XIwMYvTafek
DpOiFZtXHiEVs8V7FUlgiPWyP60812jB+hsiM9rdCe9aqUpaBI1OskCM6rngrawg
x/SHujuOgHjYFyZDbw9gmmHMb92pNpre5exSKP3JgsZ1Ab2Ta5rx3uFZzHchG4FF
xn44dgltHvU5RGzXYlFmM0OHJLT28kdkrHP6mqyRXlEnGC/wPCiVHLjtpfisv2TK
c9P4ayzS+OYdcWjM9Vy886tt70ZxbK1EsSdcZC+hwSZk6hVqYF06lnaj+C1fI54e
Sc13YWJT784hZyBc9OQ3l7i8me4u1XV48TVnCZBwB1nxK71K61JpQ5ibyG003/xT
RUFdHzKTmTx+hdtjN6dd20NJwv2k5qF4UY5mFh+rhwzXmOc14OcqtXFBP0slbTPI
96Onh012qP4Z29RyiM46BCkptaVyHooy0/zr8LX+pZ/LBrPFfzgws2ytWCI47b24
5SUmN+wPFht5czuOjmZ6hCBxV+OfGva9uH6LRrMLO3pk6ugxfp8UnzkCcXi610N6
8bmWBHFMAbsWpNRQJD52gJsjhjaAd2fGVtB1Jk0Zzz2L6kH0kpA=
=20i1
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--
