Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB37C7EE37
	for <linux-i2c@archiver.kernel.org>; Fri,  3 Mar 2023 20:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCCUAv (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjCCUAu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Mar 2023 15:00:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23060D63
        for <linux-i2c@vger.kernel.org>; Fri,  3 Mar 2023 12:00:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4C0618FB
        for <linux-i2c@vger.kernel.org>; Fri,  3 Mar 2023 20:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E322C433AC;
        Fri,  3 Mar 2023 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677873643;
        bh=M8deLkKq9xgNI3kbU8eAmYkLb8o0lphy+L1Bqn36+Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UB4s51G5Jhugrj5aryQtBixyozctD3Uxm+zN5lZeBYnV7eQy14+DXLnxVH/urYjdf
         3lJ01CPYV79P+i8r/IsFVe6BHGggtpY5c3045m+Kf0VugYyJ0CET/M0JIR51N/uyyI
         frAjDjGibcI8QInSs41Zd/BRkM/eTFhc2k46i82hYj4eXTWl955EAhWiZFefruj4wP
         dRpyxtLPVWJbVp0NTUNrU34TDG+VDv4S8IBb+Hy9mVAWFkKHmripyGF6kYYIygYBXf
         bJVIlIin3tx0b6IqEyDjSfgBYRmW8AvwDwSrdizxHknJ7fvhM68stvE7qbt2LMWVq+
         PoZzB2fZmDeZw==
Date:   Fri, 3 Mar 2023 21:00:38 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-i2c@vger.kernel.org
Cc:     nick.hawkins@hpe.com
Subject: Re: [PATCH] i2c: gxp: return proper error on address NACK
Message-ID: <ZAJR5pkUce4R1NlQ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        nick.hawkins@hpe.com
References: <20230220144059.77213-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZU3vIocPjUnGOeQn"
Content-Disposition: inline
In-Reply-To: <20230220144059.77213-1-wsa@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--ZU3vIocPjUnGOeQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 03:40:59PM +0100, Wolfram Sang wrote:
> According to Documentation/i2c/fault-codes.rst, NACK after sending an
> address should be -ENXIO.
>=20
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

Applied to for-current, thanks!


--ZU3vIocPjUnGOeQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmQCUeYACgkQFA3kzBSg
KbYN6g/+K8U0o9IARiyceMFNjzji4yBKgUL4QT8PXtAQxoAum6SIb7mj3Hht9HT8
G2nADK0noHuty8SMY7cVgeEYEtEtN/dpdPmeTfUZ4OGK86eNJVlXKwWVveBwsXg0
Tq3ffjZE6CN/hjc2p6jR5h1WRgXV0lP4tQVMTnUkB9l6n7pxOuWNelJ/44qmJ2Yi
uM+yg3RPdNs/nZTin50fqNkth7xKOfYXx3l5nRQhVnPPCGTrnN97TkaBC450e3PF
Qh0t4Cvq0A/vSMHYiG+Ry/+CWD05HxuUGbu940JtFoYS9vPZPMRUhQettmcpRNTJ
y0HThvcHvsW1emAI49Ua0A7T2w6mewqEHGWV31XRRC1GV4h5+OLCFRpW3e0/cKKw
uk2h93eb1x7ces4r65vrEH4SOTlpek5ZS2XbnolRbcEGPxrp3oXSIudcS1Bger3s
YrgcycON+Nq2fhJi950/qynnuUVPjtthjgz8rwqo55egXuTZ3JCj8EwYG47MBu7v
26fdhsitpUH+YnnNiZZtc08i3LQ+II8dwGXLwRertRu9GsdiB7wGptEyHtjjy7/5
CgJJJMYNWmmjuetVsVN4HjufY5KwglvQXC68lBEI/TM3woLwWz/aCfhAHtRFAUoW
LpIFlaTB1qGA38VxK3CllcQ70es/InECzxPHhBD3xxX8LUjCbrk=
=OLrW
-----END PGP SIGNATURE-----

--ZU3vIocPjUnGOeQn--
