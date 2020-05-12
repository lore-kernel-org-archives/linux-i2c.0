Return-Path: <SRS0=mo/p=62=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE430C54E8B
	for <linux-i2c@archiver.kernel.org>; Tue, 12 May 2020 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D064720736
	for <linux-i2c@archiver.kernel.org>; Tue, 12 May 2020 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgELNOy (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 12 May 2020 09:14:54 -0400
Received: from sauhun.de ([88.99.104.3]:57070 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELNOy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 May 2020 09:14:54 -0400
Received: from localhost (p54B332DE.dip0.t-ipconnect.de [84.179.50.222])
        by pokefinder.org (Postfix) with ESMTPSA id 10E3C2C1F86;
        Tue, 12 May 2020 15:14:52 +0200 (CEST)
Date:   Tue, 12 May 2020 15:14:51 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-i2c@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/4] i2c: tegra: Add support for the VI I2C on Tegra210
Message-ID: <20200512131451.GD13516@ninjato>
References: <20200506191511.2791107-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20200506191511.2791107-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thierry,

> That said, I could also put this set of patches (except the DTS change)
> into the same branch I already have for Dmitry's patches (plus the fixes
> that we had discussed) and take it into linux-next and let it brew for a
> couple of days to get more testing and then send everything to you with
> a PR, say, sometime next week? How does that sound?

Well, it is already next week when you get my answer... Yes, sure this
is fine with me. Makes dependency handling and testing easier.

Kind regards,

   Wolfram


--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66oUsACgkQFA3kzBSg
KbbfCg//fEdxF0/79wz/eBvSVNZhbTk/yqSp0RuAH1AoLR+xrEl4gpSeZ7WSGiD4
WFUkcBaMu9Tdke08opsPKnc3EGntr9voaewUo8RxcjxS28sQkP0U7nRrw396TGWM
2ZKNNQgWP6wqu+EHqbyZysNvbFnAoQVYQuJP/G8xyJhxt7GbY1PysqIbmWvuHYzr
+of0IUhBtB1qtp30GH/2nNw8gR8VEHIuQU6z7GCAhvhgjMFoq2TIfs/7IbEePaLZ
nURFT6+XDF2fY9+7NREsvLjTCWxy2mRQK9ph2adSmk10dPcFBatHI/LdH/RWRuFp
IYhNyitEz4Zc0AXqI4z3y0bVvh1Jbt0756F0W+7/zxCyEdzHM+RpAefdxqR6RQv6
xsiVeC8jCY6Cal9QkXVN74R9iBRJbbaAXyF20gecZjk6O8l1I4q75xxNoH6C7kSJ
KkwpHUNUzl8zezptrL0+SkmKSaqBKTve7/KrEGU01Fnv7is4k8b8b/zbq6/DEXPi
++HNQE22GMJZgd0LbMAPC9LGEO0GkPX9Fqlt3UZTCOUqW3cu+p6Ug3I2rSstRau1
TA/t4Go/dB19BjnDfM9LrFC2ocM/m+vaeo2xwaqJFmnAdQP3YPy1yvIr3x+X+qse
PgfzmpON+kIF7GQITuegUta9M2ceTBSyjcOyOT3WTqgOQXtSh70=
=e493
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
