Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40AC05027
	for <linux-i2c@archiver.kernel.org>; Mon, 23 Jan 2023 22:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjAWWUW (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 23 Jan 2023 17:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjAWWUW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Jan 2023 17:20:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F97EFA1;
        Mon, 23 Jan 2023 14:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39F661119;
        Mon, 23 Jan 2023 22:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA00BC433EF;
        Mon, 23 Jan 2023 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674512420;
        bh=zWrIu45tv04d0ki+HOl5mmQFKGJddjTi87e4Qbdga0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfCTfGkVmcZPP/ynP7+uZ6N3/XyLS6tVQtmRC1r/R490979IPOI2IZEXYRl3SRZAn
         7OcBZaZcAXw3Hm/qgQfh6riKjBBqcG5nkGDkGTVhET5At500g7nlJfvfMl1wUaf2el
         D6SyHOhNgha3fvH+SzEI57OOj/UUHYrtX5vHEOAatU6+80DtJlnwaLzJeGrBrngmgt
         sfStwQCrhrQxbwoIrN6c7lBnVm/kwu0Ite0Vw1fKz27qZMftmfAqTBIOllRFv/thMx
         Yh1uoVfiG02CNq0L589D15bn+k+Q9D0Ge3lla4UiSVCghk09Cj+ieVcDj2CJY2mCJo
         wmOSu0sRenRwQ==
Date:   Mon, 23 Jan 2023 23:20:16 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: i2c-gpio: Add properties for dealing
 with write-only SDA/SCL w/o pullup
Message-ID: <Y88IIJQuukJVxRUl@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <6f4b54d9-ab6d-a4d4-5142-27c89e03c6d2@gmail.com>
 <8eb4fb92-ea53-fb4e-4cdd-daed4ad96806@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9DIXqxurtDIbDzn"
Content-Disposition: inline
In-Reply-To: <8eb4fb92-ea53-fb4e-4cdd-daed4ad96806@gmail.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--q9DIXqxurtDIbDzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2023 at 10:51:58PM +0100, Heiner Kallweit wrote:
> There are slave devices that understand I2C but have read-only SDA and
> SCL. Examples are FD650 7-segment LED controller and its derivatives.
> Typical board designs don't even have a pull-up for both pins.
> Therefore add properties for not using open-drain. For write-only SCL
> we have a property already, add one for write-only SDA.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to for-next, thanks!


--q9DIXqxurtDIbDzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPPCCAACgkQFA3kzBSg
Kbb+2g/+NyfLRhy/J54Crj+Ag7xFNdMFA2xS9k5ivrbBRE70PFwxX1BTuEsmaq6w
Q8nlrZai2Vz757bSNirgai2J+lTraBCWcb2seZA9m2Igfo0qy21UEUbR6Ac5Lu4P
hlFRJU0bVv85ELWwFyez2gK4ccsuhMOsxGR9BA+eo/geLB8jwET7hhWC2+GxUYEi
0zsSnLY6EJ3Rqo1e7QTMFx28/fwIFA1+3oqG2Vox9FVrNy9YqGzS8SeHoaSllIRa
ldRFxhgqJg/i3gLnp4AmraGvSiUPCJMYQxFNk0VDE1nbCiy+4vIXSfg+Q3e8Jrwc
yXmB1Hk9or61cZActeBZ2ukEqWCcjAT++91rk+1x5D6jn4AnOcMksZ2oMSTFfXUK
+YaeM7htSu+n/FrZ2KRlztWvB2JBBxXddgj6Oo5R7xTCvPpM2mZ6TNjHMtj5Ouc6
QHffoUXVPqdqgvJROjP0nwOfxaTfvCO/ZeiaW4/o92Xjln/3+MSJ+m2BhdwEjusc
POqcSq0yD2YINwV2iC1FhF+Jb2z515uLODUa+h9ITlwOn5hZGi9QlUmmtBWmZnbO
ZnJsbaOfDnj8dEmgbKq8dqYoODu6M5/wxXJn2XykgAUBidEZZbaQLkBq0m0up49C
1Ef5iGv5YxvP2J4V+YJR2Aic9E9La7xrxXMQAL9se4hzGbGxVz0=
=igMI
-----END PGP SIGNATURE-----

--q9DIXqxurtDIbDzn--
