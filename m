Return-Path: <SRS0=HPKt=BH=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD3C433E3
	for <linux-i2c@archiver.kernel.org>; Tue, 28 Jul 2020 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193252053B
	for <linux-i2c@archiver.kernel.org>; Tue, 28 Jul 2020 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Asz17iIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgG1QkM (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:40:12 -0400
Received: from www.zeus03.de ([194.117.254.33]:33258 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbgG1QkM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Jul 2020 12:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Ga47dE2toEE61ZeysUrm6EKRMr8m
        UK66/nzPw9Fm3Vg=; b=Asz17iICJ8DKa9xu1FUOoHqCP1vHODX4ME0n28QWoYEb
        SIWJNbAj4NSA3BCRS/L+dklci/L6k2kB5G6JdhUWMbSJJAUoLpFhQEpSWYshQ/FW
        3DUOiPq7VEQ2FGxTKHUSCXEZOk6y/T1mcLCoqkvuATeGGA6sUZvvg/DMtomJjk0=
Received: (qmail 708321 invoked from network); 28 Jul 2020 18:40:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Jul 2020 18:40:10 +0200
X-UD-Smtp-Session: l3s3148p1@0AO5F4OruKggAwDPXw7pAIxt9EGuW/0q
Date:   Tue, 28 Jul 2020 18:40:10 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Alain Volmat <alain.volmat@st.com>
Subject: Re: [PATCH 2/2] i2c: slave: add sanity check when unregistering
Message-ID: <20200728164010.GH3736@ninjato>
References: <20200725195053.14334-1-wsa+renesas@sang-engineering.com>
 <20200725195053.14334-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline
In-Reply-To: <20200725195053.14334-3-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 25, 2020 at 09:50:53PM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8gVOoACgkQFA3kzBSg
KbZCOBAAsnYib3V8dKOWqn1hZszQNK1OngdYgi+XDBKoTiqzcdD2YKRnOeBGTpJr
QjnH9pDM7ydqA7i56CvSvkkkzlipXaJ8jL2ZMgiPp4tzXmnQx8szdayV21nn9ExM
XSTIj3QOP9ipkNXu7fWM7RVzCXNtaN+oJmpicLzt/yMItCIjm60CFi5pobkm7tGk
4sx0L/z+aFT6yiHoLF4p0tbtEEJv2zCh5MXEawMBHuhuvQSa638q0caDxgF6y+0J
pqxCBqjXi2pwfr04K0uwAGj5oFArHTRLJp6Q159/dPhLbpl/QG+MwX78CfZejUfU
oPX5/QNRXu+U775QLlBD5LyF5NWVw3IQAHmo2wZPu6W2tyFr4uc35p6sqiU0p4QT
MHbjDMXQIavGfcTkpPFs8rnWtRtLolKUZfiPh9SIJrHQ8Ah697JNmmx9epmOYzPM
3NOo7nAKY9IKV0rXO8oLBZq5lSPbaXS3Nh4I2mku0qrtfvDD97xREVPS1ADmH+h+
6XYxtLmPzj3YH14WccyrgGP/iYQI8JCooHyPYZxICB5D3hNdEoiW1RDtSoEbMW9E
16Z6rL35E2rhPUC3K//mpewGntL8E2TQCm8qGfaMVv9WZnojD1Yk8MFbaQOlLebj
WmVdGn5gcT9ydvVkSYhHj1mxH75Nnozsk3hBF9B1TqYALx5Bt8k=
=h1Ls
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--
