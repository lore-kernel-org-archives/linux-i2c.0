Return-Path: <SRS0=xDOk=C6=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A3C43464
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Sep 2020 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7AB21D43
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Sep 2020 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600682404;
	bh=tszwnkan7HtaxsYHIJwBIoDsX/64Y/MaGudvBBkEtMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fka3wimlVenOby8RO4bcI0ewOeUJ2nFq5rJAl0K8J91BpWq0v0oEJgSFQKQ+VoHFZ
	 vFME7o+Gyya2bX2V7f8pYDBmryejMKluoJLrP7Hxj5GJiH2fuVChU+Ird9jXkvA36f
	 CsaucuKIGiWBww807kEcjDViXJEKS8CbJ8oueIzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIUKAE (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUKAD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 21 Sep 2020 06:00:03 -0400
Received: from localhost (p5486cf2a.dip0.t-ipconnect.de [84.134.207.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1092193E;
        Mon, 21 Sep 2020 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600682403;
        bh=tszwnkan7HtaxsYHIJwBIoDsX/64Y/MaGudvBBkEtMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1UhSq/YB4uRQPE4ZKh54BWf6PRSH6mHp85p8hc2S40qP7nTjtJknNiB4cELIJ3w/
         O50y+M0qvWUoxPW2qa4H7boOSF2jOzb2QZtlCI+mY7bWV3LNST/qdEtu+Gkl0kGRe9
         +GtqOf2jEyWlzGOQFkt5jOOfGMpdOHi55hByshHc=
Date:   Mon, 21 Sep 2020 12:00:00 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1] i2c: ismt: Add support for Intel Emmitsburg PCH
Message-ID: <20200921100000.GP1840@ninjato>
References: <20200615161001.12817-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzUQzca511KWT6Hk"
Content-Disposition: inline
In-Reply-To: <20200615161001.12817-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--vzUQzca511KWT6Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 07:10:01PM +0300, Andy Shevchenko wrote:
> Add PCI ID for the Intel Emmitsburg PCH iSMT SMBus controller.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--vzUQzca511KWT6Hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9oeaAACgkQFA3kzBSg
Kba3ag//XtPLq4CKtrn611SrkD6rLB+LXNzgH2eyMhUNl7h6NN+noi77sagRg7Qi
zRHhAHpf2dE0NKgzbTDIjwyNxXYdWzajEoPT1cvOL+HujI2zQdIbypxKa6/A1E47
quTJbPuUZulsBzokylc+i1wCNfHx9QEw03KB8kcoswFibmg/OXLigx0zx3ti3TN4
wjt8YDr+1PnHx6bzjxdzWVn/+lnviRgWuk8qRg7tYpKgKhF2kNXpyz5itjO5uGes
4NV0PpFEA4gqP0PgbNDR0bx3aiSpFrfKgv3qLYbM6P2ZSLRa4Y3QRqoUDQFLaglK
LrH4Y+ZJCRrI8hwgKJYLpohq3xGtvWlUkK8es2BVO3pbwTGgSDBVe4mPWerUXVWC
jz88aFE6VJTl7L//3eYf6Hlic7T2n6t2yIzv3toKUcrQGPPb11B0RposZuv9Zg0q
f0PgxX8bqkFSodqd6Z+f6uqjP/FTg5h+D5xNnHRX70emWfwcbFAPM1eeI65VE4zp
zG35/tEm7k/m075f1DFD6hq+k/6PwYzBssPuXChDfe9hxK8TpkUiMtg89eaJJy/K
0xvE97xfxWjm+qRs8Kp5xCcVGk8djKBLy6TBhuBPEEmMYsBGQ+Lq/CVOC1+QN+7l
/9LKWWPkWIZeY8uoqJXaNq/o0f8ms1IoW+gbHgM+WOy4/hMfJ3Y=
=PBEZ
-----END PGP SIGNATURE-----

--vzUQzca511KWT6Hk--
