Return-Path: <SRS0=YC37=BN=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E9C433E0
	for <linux-i2c@archiver.kernel.org>; Mon,  3 Aug 2020 20:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0283D2086A
	for <linux-i2c@archiver.kernel.org>; Mon,  3 Aug 2020 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="1McbOKwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHCUpL (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:45:11 -0400
Received: from www.zeus03.de ([194.117.254.33]:46572 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgHCUpK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 3 Aug 2020 16:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=ZhVmGbXvuTacJmIha4DYNPEkfeRI
        rbClDb5J0Kr9Dno=; b=1McbOKwa16RT6Cm2cNrd30f0pFPY09fOoKY9LtzA5nFu
        kvqeQdRH+39XiG7wej6WA95wntneFAkZWx2I5RrCE7zkiMPS8X5D9aBdbtm3H3du
        jqQzCWHdwV9/UBRk1GAly/cgMYoNSuSnXXLcJudX04I0VGynnC4u+gPAY5WZfXY=
Received: (qmail 2497905 invoked from network); 3 Aug 2020 22:45:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Aug 2020 22:45:08 +0200
X-UD-Smtp-Session: l3s3148p1@fwzTNv+riMxQT+F6
Date:   Mon, 3 Aug 2020 22:45:07 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Daniel Stodden <daniel.stodden@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH i2c-tools] i2ctransfer: add support for I2C_M_RECV_LEN
Message-ID: <20200803204507.GB2488@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Stodden <daniel.stodden@gmail.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20200802192842.13527-1-wsa+renesas@sang-engineering.com>
 <C5EC2F45-41AD-465E-83F9-BDE3640B02AA@gmail.com>
 <20200802213828.GB13339@kunai>
 <C82A0A94-A06B-4D42-B71B-F14D48D5E029@gmail.com>
 <20200803083823.GA958@kunai>
 <34A8CC90-0EED-4DD8-89EF-E1B81B7D6DB7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <34A8CC90-0EED-4DD8-89EF-E1B81B7D6DB7@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If the driver author only looks at __i2_transfer =3D> master_xfer invocat=
ions
> as employed by i2c_smbus_xfer_emulated, and PEC isn=E2=80=99t used either=
, then that
> code path let=E2=80=99s you get away with pretty much any msgs[i].len you=
 come up with.

Which explains the patch we are discussing here. I wanted to have a
simple way to trigger I2C_M_RECV_LEN from userspace.

I am thinking of adding a check to this patch: complain if msg->len is
not what we expect and tell people they should report it.


--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8od1AACgkQFA3kzBSg
KbbhDBAAst5i5/Z3C6azHsFfqP3+d4C2Yjsm+6nPQw1XSBvpMky08uut2rsCl1xm
XyOHZZtjd4HeOUIYfpTl2BoVpbKE16tmrO0sI/WfQdxtHPmNX35HOHRDEvcgqFQS
f9RXBbhQEkBGZxClgPmWXtWfxurk3zyK3OtLGTL4KLwIT57O6OVrXhqj099dpKKQ
bS/RYtXmmy2HKGiMv9Ty/8/OtVoBqMPpaidBzBYpUGbNU14iG+63njD5wgHzJeBl
zS5aY9JQ30IjKqqaLWiqU1hZu2pOQeCUX4wYB3fiWh7JkFd94ELXFgZRHAAOT3gF
f4veSjOMeU0fROBlfOq7xpz1Fc+0sd02HnFLsoBid/CYgloT6Ml0AvvEK/Zp7zaZ
Y1Q99GYUTTstvsy9f4053K9JuRcofjs4WdZloOFEONTT9O/xQVqXWKMTtdJ0BUvj
Ky/74ZvHbxpa4z3nSKD137IaHnV6lHLTloAZBifmL/dk9AVumx9WaCirOkmG7oFY
NodashY4Yor8wWxx0Oyyz2jxGHfd7FoYeEUl+3/45lu16NqPvxX0g4JoHY+MzLLV
4PxNiebUGBt035CIsVfiAUz3LLcr+fzitLBi/LdDdwSTVy5dPr/8TKM4StnCmR5m
abQIjgUoRd/gnQBk4LimrwPWwIvB6D+vYGR53ybKuzuNoLyUno0=
=zb7C
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
