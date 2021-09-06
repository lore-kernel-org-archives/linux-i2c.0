Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FADC433EF
	for <linux-i2c@archiver.kernel.org>; Mon,  6 Sep 2021 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2EA61004
	for <linux-i2c@archiver.kernel.org>; Mon,  6 Sep 2021 06:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhIFGlm (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239244AbhIFGll (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 6 Sep 2021 02:41:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0858460F45;
        Mon,  6 Sep 2021 06:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630910437;
        bh=/k4XCGEwuUQdAuLEeJ+zbInWBfr68zIyh+zZnBxjAn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=llguqzU/IeTGVGoMMMluXHkFcYIOHa8zHUgyTabLYT+23QzJY2fm7ulmxvKFmuNI/
         cPMncjoNLcrTmlhsmGD+oEcN2XewNsTUWetqcy50NDd2R1e3jUkHV0mpEG7aqLIdMW
         j2OeBlvcPARRjIm/u/Hy1EjFOH8nYtA/g3tdM4+koR9r7vDDVkj/RzPXyGQQwANk/9
         Ye5YkJIywq18BdEHglqrnwXw5xz7gG5vwcShGe4IJHaPpu4VrwbCx2E13km5QcQbJv
         +ZhNxqEKlKuljHWNphT2mpdY/97Ca3sFu5fBEiuN5zVvIlrCtntvgO65oBJ6N3iwPX
         3Lkjj23gp18JA==
Date:   Mon, 6 Sep 2021 08:40:31 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, jasowang@redhat.com,
        andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
        shuo.a.liu@intel.com, conghui.chen@intel.com, stefanha@redhat.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <YTW33xK8QkYcOoFw@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, jasowang@redhat.com,
        andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
        shuo.a.liu@intel.com, conghui.chen@intel.com, stefanha@redhat.com,
        gregkh@linuxfoundation.org
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210904160059-mutt-send-email-mst@kernel.org>
 <20210906044307.se4dcld2wlblieyv@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5CQvKhLjITxIbgje"
Content-Disposition: inline
In-Reply-To: <20210906044307.se4dcld2wlblieyv@vireshk-i7>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--5CQvKhLjITxIbgje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The current version simply fails to transmit the messages in case the
> length of a buffer is 0. I have patch ready to make it work with the
> proposed spec changes, just waiting for them to be accepted.

For the record, it fails gracefully. The driver has the proper quirk
flag set, so the I2C core knows it doesn't zupport 0 length messages.


--5CQvKhLjITxIbgje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmE1t9sACgkQFA3kzBSg
KbbKNw/6Ay5LQIFbUaWW8YkfD4w53f3QnjeVB+Jc3RTX314r/S3byFcjDdV4kv7t
Cd+V+IphWMGjWQ+Nfe/CSc43/7XH7CV9EpEN4PH+Dk3UBlbxs2ZM/609nzSry18O
O1g+qkE/R+lJcbviChyJgYx8hCevq5UeMY2HaP46qYsar/EWhACuojBgbb40EPFp
yiIpgU1SKE9YqExcfWKvB5O87iIvp9nD4Qt6sAeQL8Ba6OCjWOR6D9gRqYsH5Gn2
apHuXxeIw5Z7u299RM/SlxCAY3vQOKh74KnusD8PMHl8AZTDVB6ZjvTHDEys5SYT
R8ZaM2hkX4I60O3aBbQERDjPg1P3v1w85fjiXAgXnIi9YXM2UJrF393E3VIOYUkL
Uf6pqoVIR1aIPVhCFYYh2KsG0RoQmSmT7iV9qQg0nDEWzTZwEhYBEW6ayaMIV2/Z
m+/zExeuPT/8t/2SLHN6tGPrYmuCDb4tRZtxQB+O9r8boFkDa1iyHHaGebHZh4ON
pB2xuuC9s4sdkZ+DNW5h8DtTWCCogjYaayRMGmz+YysGB1vk6+Let+ajuBszfIyU
wTYlS6XmI+VDnEJnuuMhFFIWrYq9CIHZ4EyVMnJVUxeGW4mJTypz3Mi6ePqqlaXj
68KOV/C458iaOSPEk4gamkcV42gMjyS8O645JAEV+xmvY+/yi60=
=bFFy
-----END PGP SIGNATURE-----

--5CQvKhLjITxIbgje--
