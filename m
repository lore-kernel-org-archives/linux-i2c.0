Return-Path: <SRS0=9WpY=7X=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B04C433E1
	for <linux-i2c@archiver.kernel.org>; Wed, 10 Jun 2020 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468AB207C3
	for <linux-i2c@archiver.kernel.org>; Wed, 10 Jun 2020 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797219;
	bh=s1vPJ4Oq4k32bys2o6uXySw3TErrUiu1W9fi1VFwHmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bGy0kL9koLu4BKLxgNWg6qDJoNw6XfF5YK4Vazq2jfohpBS3vgZUxO5jGy545y0FI
	 +By/2CcfMVdxMzeYCiRS3UrjN2Ksgg+wMcRKdDuiso+dSAEA0Z4HT3YF975cdD39+j
	 L9q/FCrhkXNk+DsRV5m8wgKabtBSNjp+uGmVvaQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgFJNxi (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgFJNxi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 10 Jun 2020 09:53:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31183206F4;
        Wed, 10 Jun 2020 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591797217;
        bh=s1vPJ4Oq4k32bys2o6uXySw3TErrUiu1W9fi1VFwHmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qreQMkrwj+CumutUh7nwPxQ3ljG79JcA1ghbj5W2wDJ145RY55Wlaip8KId3A9cr6
         cHL9NI66U3QiEbpuD46atfCRf9LV7e7bugfnfNuUXSbPzPdRkMZ4BOY2Zwgdx6hmXx
         JrB0bpYW08T283+OkQGmaobvjgrpvxlaeL6sAnsU=
Date:   Wed, 10 Jun 2020 14:53:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org,
        msavaliy@codeaurora.org
Subject: Re: [PATCH V7 RESEND 4/7] spi: spi-geni-qcom: Add interconnect
 support
Message-ID: <20200610135335.GG5005@sirena.org.uk>
References: <1591682194-32388-1-git-send-email-akashast@codeaurora.org>
 <1591682194-32388-5-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <1591682194-32388-5-git-send-email-akashast@codeaurora.org>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 11:26:31AM +0530, Akash Asthana wrote:
> Get the interconnect paths for SPI based Serial Engine device
> and vote according to the current bus speed of the driver.

Acked-by: Mark Brown <broonie@kernel.org>

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7g5d4ACgkQJNaLcl1U
h9BKIQf/Q3VWEhsUfEymHtm5vEhv+ze1U2uQE7g2uwUQ9YZY8QFHJCWB9ASndc5g
QgChce69MVl8+qsbwJ+hkrWRwtOKe00vqt+lqkAYGWTaKscEAIN+/kcTBAc6sDjx
AnvBT9QeybB3i4xBtemJoPyPKLC3H1Ez2wZuez5FrqYcdThqiHIuewkCxAUgjg2a
ovBeeDZ8GrBKfU0c/2HzilwrkovLlc0nuDwWn0xQhKdn9AynKB6UT/JJEhXbi0q6
EpDqZNEHbv/itTQI0lyAQbcy3QelIcbfwj7rX3rHZN1hDbQ29lFSGSIg0nNQE1iX
wq9EC6v/TcmPGMnddSvy091y7FAW7g==
=bZPH
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
