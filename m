Return-Path: <SRS0=IO5a=EJ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB247C388F7
	for <linux-i2c@archiver.kernel.org>; Tue,  3 Nov 2020 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8685222403
	for <linux-i2c@archiver.kernel.org>; Tue,  3 Nov 2020 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604437437;
	bh=hxlW3r3b6lq9QoYdLWyolF+GAnU+TF8hAo252FIV2hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gJ1vpaqTmPGlwj5P8eXqL7WgF0fap3zpRJhQaPn3WJ9UQkPYVhSn1Z3NuBVaa2+Oi
	 Ai4DE7ErR3M0zcuB3Ia7+6OmKVLomDZmE/iURRTmhXuPHhwx/n6MMe90LSG9UHSOqF
	 JcpRxqwmnOnzjPRxT+W4OsFc+jJhuV/cvWCebCVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgKCVD4 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387902AbgKCVDz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 3 Nov 2020 16:03:55 -0500
Received: from localhost (p5486c89f.dip0.t-ipconnect.de [84.134.200.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C9D20658;
        Tue,  3 Nov 2020 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604437435;
        bh=hxlW3r3b6lq9QoYdLWyolF+GAnU+TF8hAo252FIV2hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDgRjZU7tvtviGdhngDeWfaKnIgKFat9R1eRHYGoEDdUxQoE1XNK+BRzcDx3gEAnn
         KAETXu6+WzFnAGB74BxZ7azCpg8xFwRTb78VNdBLnXMX5CDRpb4GRaBP6P94H5m1yg
         nPuF3sTYdMwCdIZ/ArsV7pISNGC5DeBTttVJ56pA=
Date:   Tue, 3 Nov 2020 22:03:49 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Michael Wu <michael.wu@vatics.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Morgan Chang <morgan.chang@vatics.com>
Subject: Re: [PATCH 2/2] i2c: designware: slave should do WRITE_REQUESTED
 before WRITE_RECEIVED
Message-ID: <20201103210349.GE1583@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Michael Wu <michael.wu@vatics.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Morgan Chang <morgan.chang@vatics.com>
References: <20201030080420.28016-1-michael.wu@vatics.com>
 <20201030080420.28016-3-michael.wu@vatics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <20201030080420.28016-3-michael.wu@vatics.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

> Documentation/i2c/slave-interface.rst says that I2C_SLAVE_WRITE_REQUESTED,
> which is mandatory, should be sent while the data did not arrive yet. It
> means in a write-request I2C_SLAVE_WRITE_REQUESTED should be reported
> before any I2C_SLAVE_WRITE_RECEIVED.

Correct.

> dev->status can be used to record the current state, especially Designware
> I2C controller has no interrupts to identify a write-request. This patch

Just double-checking: the designware HW does not raise an interrupt when
its own address + RW bit has been received?

Kind regards,

   Wolfram


--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl+hxbUACgkQFA3kzBSg
KbYVtg/+Lz6bV+bRe1EfNnrycWSFkU4zSTG72yi/kf2leHJt/rpkFj2PHyLV7XF8
8BOUjehod8KY+1NO0tFP2Vf9obK6LLk7LkfLHfaeh1z09nx/zAAtTy9N/VBNG94s
I2WDUmUaLR6LGHZBmphdljba1gkBR4LV04WITgMtn9QM8TR1KKyuAGez7nPuN59S
Mv442+qnpZttGtKRvNayJDz0uSGuUpimyxvPFWZablJgT5YeVjr7A7KGYSND4ILw
fDjfllSShmshgbmY9bI74GVurcAtAqbpdE2sQyQ2Dz9Pd/2aHvcZ7hscQVSeJ2NJ
sEFCLHsFcW4dJGaGlc2+QiYPnVxMk9y3QbUmQhO+a2b2KYI+7IJktEPwKzm8/ap6
tYioaB6Ezy4Y5SnzAxuKESCjQeC4uS1wQPnriFRqxyK9CCbnNm8D1mJAhynmORqy
oY8yoxlPNX+5nou6s10Ox6aqZ039m3N8JY/yD3ixHVXT6+K0TEWmGChVM2/+FNtF
ZvDvg4NHox2S1vGSRBtCH9+fJICeoZsxwuwp3+0hoQ12v1G8ZkK8C76sw0RIwZIx
HTP9ShZtaYDDhHs/Svc3XfePYcNekSf+iP7/ZraEiH9wnQ/5wxN7fFyo7gZ8X2xz
68z+R4q1xqRdbIG/etjsOrBt8UlQKKXZaByEf2LVt0CHUJ4jaHs=
=ISuO
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
