Return-Path: <SRS0=OLWM=6T=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F4C47247
	for <linux-i2c@archiver.kernel.org>; Tue,  5 May 2020 13:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3FF206B9
	for <linux-i2c@archiver.kernel.org>; Tue,  5 May 2020 13:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgEENAS (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 5 May 2020 09:00:18 -0400
Received: from sauhun.de ([88.99.104.3]:60934 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEENAR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 5 May 2020 09:00:17 -0400
Received: from localhost (p54B335A1.dip0.t-ipconnect.de [84.179.53.161])
        by pokefinder.org (Postfix) with ESMTPSA id 98C9E2C0892;
        Tue,  5 May 2020 15:00:15 +0200 (CEST)
Date:   Tue, 5 May 2020 15:00:07 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 00/12] i2c-pxa cleanups
Message-ID: <20200505130007.GA2468@ninjato>
References: <20200427184658.GM25745@shell.armlinux.org.uk>
 <20200428220616.GA7698@kunai>
 <20200505120202.GE1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20200505120202.GE1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Have you forgotten to merge a branch?

Right. Sorry for the delay! Will push out later today.


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6xY1MACgkQFA3kzBSg
Kbbe8hAAlXtA89eGrtfdIHofBc4lbBLAnanPklot4as0Ny4dW/ihVgVyx7bfaLFm
y6fEmfdkZsU97a7vE08GrjXJvTvDbk8xc5GbIzkKKsO/KycZGZKqB0DYwdmlcDM0
jh0y0spLFoynY4w74Iks4AwDtBCQnBDnlBYIzfU9b4WWa5JbXiD08UzNlHhUEioc
azjIgFaANn9Q/qzcTWFNjbMkCeW4RSZ7R8Lg1O1aBR/FaTRJOnfLxwNfH8tQnw2n
pS0n44F9oSpZfMmi91yqV8zsemWNqKDw7ZmprfRshNCSXgNWk+fef0DxL4a0tt+n
+gcEiz7zHr/QAFNTR0Ecj4h9yjBRIMcwiVGra8ucllvrIGzv5Bv1FF4kl42DA3KG
KBLOy0WxfyhcrXTXEIHB+nM+U7+aQZQ7RboPjjF3iznBOcbS3HVtiZcS6QVElsYi
F6sDHDEtBh4Jc6oVtMjgGqYsaaC/ePjMaplLgMEFCZ0d4cBmTEQsO9FTJB2mHuM2
8L+N3mXDPE2XZHTBqYXf62mTXcRR7dpsgsUQcWI5RkAzcMLAgZNj4EB+UVVmzT7Y
YaqxjXI+4PoItb77IF4DSxQQcuFw4sDGciDxtPcBHpTF2R1mFazTrG6RA/Wmu54Z
l/XRnXZqGGlXu2VecGCyWrYRLtzyNZFm9h8oITSAX8C1cW4dSFw=
=Zk+2
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
