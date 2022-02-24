Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D4AC433F5
	for <linux-i2c@archiver.kernel.org>; Thu, 24 Feb 2022 22:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiBXWk0 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiBXWkZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Feb 2022 17:40:25 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B491F83F5;
        Thu, 24 Feb 2022 14:39:55 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E672A1C0B82; Thu, 24 Feb 2022 23:39:53 +0100 (CET)
Date:   Thu, 24 Feb 2022 23:39:53 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>,
        krzysztof.kozlowski@canonical.com, robh@kernel.org,
        semen.protsenko@linaro.org, yangyicong@hisilicon.com,
        sven@svenpeter.dev, jie.deng@intel.com, bence98@sch.bme.hu,
        lukas.bulwahn@gmail.com, linux-i2c@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.9 8/9] i2c: qup: allow COMPILE_TEST
Message-ID: <20220224223953.GB6522@duo.ucw.cz>
References: <20220223023300.242616-1-sashal@kernel.org>
 <20220223023300.242616-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20220223023300.242616-8-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-02-22 21:32:59, Sasha Levin wrote:
> From: Wolfram Sang <wsa@kernel.org>
>=20
> [ Upstream commit 5de717974005fcad2502281e9f82e139ca91f4bb ]
>=20
> Driver builds fine with COMPILE_TEST. Enable it for wider test coverage
> and easier maintenance.

I don't believe this is suitable for stable.

Best regards,
								Pavel
							=09
> +++ b/drivers/i2c/busses/Kconfig
> @@ -783,7 +783,7 @@ config I2C_PXA_SLAVE
> =20
>  config I2C_QUP
>  	tristate "Qualcomm QUP based I2C controller"
> -	depends on ARCH_QCOM
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  built-in I2C interface on the Qualcomm SoCs.
> --=20
> 2.34.1

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYhgJOQAKCRAw5/Bqldv6
8qyiAJoDMo4rVzr5TNEjeyaBcBerDZIJNQCdE8762djrMrDO0flsZrqZrBALzkU=
=+hRK
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
