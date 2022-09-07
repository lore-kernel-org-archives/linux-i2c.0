Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A016C54EE9
	for <linux-i2c@archiver.kernel.org>; Wed,  7 Sep 2022 21:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIGVcb (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIGVca (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Sep 2022 17:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97135B14C5;
        Wed,  7 Sep 2022 14:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2913861AA8;
        Wed,  7 Sep 2022 21:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B7DC433C1;
        Wed,  7 Sep 2022 21:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662586348;
        bh=Rhr7xHsw25LyiGmkeQY88x14G06o4QHn6L68RHOebYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YE9lqBBVp6T4HmInA8CP6qhWl8FZwaNBTkPKQIO/i0zCbDOKWab/sWSUCMzhzWFf3
         h1V/H5AqX12GMG+LSNJtg/5TmAVROHsMei3IMsrfCwkX5uNQ99393jGZZ2U0sRjXfq
         dyZCI7JmI1Ty71Y+21ROGEd94a7F6MaLJT6ggDu8AIobm1zjwdgkP1JGP6lcQnDjUN
         jnft5mCeYxnPetaWQyCLUpx+Ob7rF/FYlxVRm+XdizN0FcIT6yGGe6jTqCNgCmBwNi
         xiqoyMB/pzCxCARGgtb0N+8TuynHK1sDr6z+HIiquwaFDsCab5mC3Ma77g66Zw/pPX
         GrJMpkwrh+bkw==
Date:   Wed, 7 Sep 2022 23:32:21 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Weilong Chen <chenweilong@huawei.com>, yangyicong@hisilicon.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuwei5@huawei.com
Subject: Re: [PATCH next v2 2/2] dt-bindings: i2c: add entry for
 hisilicon,hisi-i2c
Message-ID: <YxkN5Q8iCpRaQq4w@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Yicong Yang <yangyicong@huawei.com>,
        Weilong Chen <chenweilong@huawei.com>, yangyicong@hisilicon.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuwei5@huawei.com
References: <20220825092412.307052-1-chenweilong@huawei.com>
 <20220825092412.307052-2-chenweilong@huawei.com>
 <ffa076ea-2675-05ab-00bb-30b77ef13cba@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AZ4e6E/thKGIvDOQ"
Content-Disposition: inline
In-Reply-To: <ffa076ea-2675-05ab-00bb-30b77ef13cba@huawei.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--AZ4e6E/thKGIvDOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think it misses some properties here?
>=20
> - i2c-sda-hold-time-ns
> - sda_fall_ns
> - scl_rise_ns
> ...
>=20
> Do we need to mention them here?

I think so. But for a definitive answer, the devicetree-list should be
on CC for proper review.


--AZ4e6E/thKGIvDOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMZDeEACgkQFA3kzBSg
KbZAQBAAl7HbWG3CWOxTkA3mSOawpEV6Ttmg9jb6BbnunNggxaOu/D2mwnhO95Ca
GoaK3m9YdK5RSfyu4Z/sv3ZS6XnjXFHg/7sBlwfkDM7SZSfnH5jVNof3fNwIw1N1
GnWb1pFBfn7l+ramg/a+/EaanpiZ4MW6i+S8wNfBm1NpsNTNTcVr4lSL2SchLLUm
XvtW2MjD2jTKqkRBjCXiMYtFaq5f2wkwqkoRqoOW5SKNqH7SU5QqPgGD1+GZ37nm
fmQgUrUjmkatWANF8Vub70hPEkI9y3zBrTDAt1+ANUqlc+NGOAQut3s0cdJahJ0W
X1n4mrD8+sw4UlDpg/Likun34PizN7svNQijqy33r4OX8mIb3U8gTSFXiDqLKhG4
Er2RhFg6s7NnJnmDD2skuT2LUh6u2euLOv9e2kJ1ZMJ40qmaX7kV3elgFgXOdDID
gNbVEBJHgIV25e6hcPrNW+imGVPi64ADazMV1Oe6aAe1RdujGnqCY0M+ku6tTUwK
clFiJdsaSr05X9y9KiPDznNPtxsl3fCqq3RcRnUAcgHZAOHwgQmGLXqq3AZBrtMI
gw+mSMSmTtT19bLB6ZvE2fOhVP/DSoQ1tvYWoq4E99swGm/rQk1jRZbpNc6axwTe
rKdBM7GzJMB6ZbPAaBtFxReBl6F/2DwyJRS8W4eAPAQtue6Se1M=
=g/Qq
-----END PGP SIGNATURE-----

--AZ4e6E/thKGIvDOQ--
