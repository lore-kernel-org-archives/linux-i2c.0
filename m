Return-Path: <SRS0=nZDW=BB=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF76C433E0
	for <linux-i2c@archiver.kernel.org>; Wed, 22 Jul 2020 10:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E718A2084D
	for <linux-i2c@archiver.kernel.org>; Wed, 22 Jul 2020 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595415041;
	bh=rxpYg6CDVwAJo6YYQCw0TfgpUCVQYOLz9Arf/F32tVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pvd2yt8GOSOTGUSnZ3462Jh25tY0VtAJQ70PaBFTVEnR8c1le206l+NEPhQ/gHhov
	 yZM4XeZWGsG5F9ZY9QIIfkL9NcaXh0sxb7qem7kdu4nR8ADXw7LIOTyCgGzlNDMogc
	 N93nvDS9XNBzwzuyNaGXqIlTrY7NFb3lK/xmeJos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGVKuk (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGVKuk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 22 Jul 2020 06:50:40 -0400
Received: from localhost (p54b33083.dip0.t-ipconnect.de [84.179.48.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC88D2065E;
        Wed, 22 Jul 2020 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595415039;
        bh=rxpYg6CDVwAJo6YYQCw0TfgpUCVQYOLz9Arf/F32tVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evLmM7FhbkMk/vMuJnMN54NnsHKwQ8sXep1Te2+VGrFMxebdzHO3RRQ3pSVUbhqRC
         mO1RxSLM85mNe07UiDrp8uSnOilCf3qyWhxKF17NWZkVaE36ua1nGU/NA90kB7aT+r
         cxrWz0MqJ46auf7Q1MLh1p58LD2W88/0R9nKw4bQ=
Date:   Wed, 22 Jul 2020 12:50:36 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Wolfram Sang <wolfram@the-dreams.de>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c-gpio: Use 'deprecated' keyword on
 deprecated properties
Message-ID: <20200722105036.GN1030@ninjato>
References: <20200717160407.378140-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fz0LNKsoEivY4NpG"
Content-Disposition: inline
In-Reply-To: <20200717160407.378140-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--fz0LNKsoEivY4NpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 10:04:07AM -0600, Rob Herring wrote:
> The i2c-gpio binding is the only case of 'not: true' being used for a
> deprecated property. Update it to use the json-schema 2019.09
> 'deprecated' keyword instead. Define the type too in order to keep the
> meta-schema happy.
>=20
> This will disable warnings for these properties until the dtschema tools
> are updated to handle 'deprecated', but they are only used in a few at91
> dts files.
>=20
> Cc: Wolfram Sang <wolfram@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Your tree or mine? for the latter case:

Acked-by: Wolfram Sang <wsa@kernel.org>


--fz0LNKsoEivY4NpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8YGfwACgkQFA3kzBSg
KbbBGxAAp4+E+AqY50v6RzlzOqDWKbLZ5Fx2jGsJEM9kgl9jgiiBexG3oruQJAgl
FUmAxhvDeBUC1reqq6dTavsjvMNCLZ25cx2wnmCi9nWeJH/kYiwR3zq5H9QB/p8P
1odla5eAkoeSf/8oHAkwC2XpO524paJ+jW960uvqMg+KSWJ07fg++ogOGPIqnbwl
+pzWzB9L22kNAWBpI8R6vxGsOlMDYo6e75Oa0c6Eolri/J0hOQWBLMmjVMDza7Yl
Ta4Re7N7Xmls/MsEikPSic6HvNuglCKgwudgk8mfi9/jBCkdtJCczC9AQKOoYRfO
YT8eLVrbWMip8j+CpzcARhLCs1GaoHA+EAZBg/0F6n+xZIF3q9orhNRkMnT/Gbba
skUe/TasiitStRjzXDCkRAEVVwCG1rGWKU7v8wg23C4i94SpPe2dD7pGUsuUV12o
jonxwcLo9tbDl+aFKAl2B5JbMkpfclFgsHFtwu/Iqh55mVxjSodnrMHffdCQWIu7
2xxydwsp+MLc4qCFBnGS29abcCBIvELLWUqutRgkGbgdAK0ycAOKeXIlnm8LT42n
AekJJhTw1iBIOVeCuKKJY6Z34pRMfJRHN2o+a6L/ACH1MI1U8Hgg/bTfBTbARgQN
OZKVyFdBzj2PL2vUKke4PE7PaB2feWAeAjWf/FWbbpdROXM++lU=
=nCRa
-----END PGP SIGNATURE-----

--fz0LNKsoEivY4NpG--
