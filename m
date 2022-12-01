Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F0C4332F
	for <linux-i2c@archiver.kernel.org>; Thu,  1 Dec 2022 23:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiLAXBv (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiLAXBV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Dec 2022 18:01:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48623CCEDE;
        Thu,  1 Dec 2022 14:59:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6ADC62184;
        Thu,  1 Dec 2022 22:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D8EC433C1;
        Thu,  1 Dec 2022 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669935595;
        bh=x2JTE+w/5nDsVxG32ywP+hubJCLigeqjoVHh3K+CepY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcbPdVtRp9fgoYdzFVGHLsTVjbULZ8oTilPoCn2EPrWSe8MtQQMmQ2ji+OMfd9V+K
         KsQeC2wXqILpTqF8SVVje5OO0P/20Wce+t6JgsHIjxMoIpZjq/j6umfgY1qKyiPk5b
         98kNjZI3YFrehMIpjfaHWNRl1nuHZOTjckpyJC/vRmgRP6QzKALRhnKsz6x1sx1YXk
         6BxgduwiFAnVkixX2spn+1Y5xULZV7HNMwv85M/C+9DIhrbURttVf4z+TiZjAjvcbA
         mFsBq6bTtj5lSZ3Osj2kdmuCAj9wFFUkfdJpKLtOWyZocNxsGrcsgRNJuTRBBXBexQ
         9FRRXpg746mXA==
Date:   Thu, 1 Dec 2022 23:59:52 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] i2c: cht-wc: Add charger-chip info for the Lenovo
 Yoga Tab 3 YT3-X90F
Message-ID: <Y4kx6O5AsGXxfKzl@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221127182257.104410-1-hdegoede@redhat.com>
 <20221127182257.104410-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ItbSl7Rlu7dud+5Y"
Content-Disposition: inline
In-Reply-To: <20221127182257.104410-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--ItbSl7Rlu7dud+5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2022 at 07:22:56PM +0100, Hans de Goede wrote:
> On x86 devices with a CHT Whiskey Cove PMIC the driver for
> the I2C bus coming from the PMIC is responsible for instantiating
> the i2c_client for the charger chip.
>=20
> Add the necessary i2c_board_info for this.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Wolfram Sang <wsa@kernel.org>


--ItbSl7Rlu7dud+5Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmOJMegACgkQFA3kzBSg
KbZBNw/+Pv8gH15uKyLBmucjqKjY9PhBWkT8V8KvX7MtSq8ukDI6TWOqznM3Mvin
5yCXAPFJl67Ckwid5n41Db5jGFInXax1oUAhZnaIf8iVBv503p357bYY7dhDdfrE
n/TZ3Hz9ir8Rxy7QqXR7GaPJGsfyqoZLKWa3hsnM3mMpARJBX/YMZnw9em9dORl2
OCB++0ln+LaXBLceHYeaJlh6Kt5wGTRq1s/pM6UC9fvgDtDNiCEVy31MjhHhZNlz
ic0ivCh/NHunYmSrDnmugDmMc/wxD7VHTTr0S7fwtQ5BqeDkyQt1IyDyWmgsItxR
yAivInRau00IQz3U0lvYe63Cub+R+w681STA75uofmCGEgtaSlc0au6FBOU1NgVr
4A2blRXEpxQFVytfQ2xbqDXaFeh3Tt9lXg019+K9lsMxyYgm0VBCSA77edjVaGtK
Ee11XSTLpGEI1rvZtRBDcEWQwrDe7RO/UbjZ8vQyh15Cm0DPN866o5olebQP3TS1
gRFg4vKaEQV/ZB3ks0hgtX4cfDdO7ce9KiqWRq3pwYUQoefnYvnVr2RX779sh8gc
mDINgeuFH/7nCgmyGOfTyQHfwsX8SIPsPZzOripdbhkNhK0VtJupoRvaqpI/it0m
Smrn9CYiwwxRufP1bXU37G/dmPuNZ7AC0ZHFxrv+iNe3lj1AoYM=
=uoy0
-----END PGP SIGNATURE-----

--ItbSl7Rlu7dud+5Y--
