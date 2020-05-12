Return-Path: <SRS0=mo/p=62=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC428C54E4A
	for <linux-i2c@archiver.kernel.org>; Tue, 12 May 2020 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F9320722
	for <linux-i2c@archiver.kernel.org>; Tue, 12 May 2020 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589279945;
	bh=zGiCu3q+qNr/BOMkiS1RsLJlvcaWh3zqFpO+WzDzAzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L4WaoJmhcRTa9z/85jZc7lWPcexU4KhPwk21k1MBvyUivn581gFB9GF0iqo6iAMZ/
	 e5fwied3FRTx4ugK457k67FQZ0XA9Ij2yuiUg4SLsp4P0dNZDMk74U1tNvFwKcSw7w
	 2CN1eMsLIK21QQwQYVckkhKeh8/4/9MmJECWmJts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgELKjF (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 12 May 2020 06:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELKjE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 May 2020 06:39:04 -0400
Received: from localhost (p54B332DE.dip0.t-ipconnect.de [84.179.50.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372C1206DD;
        Tue, 12 May 2020 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589279943;
        bh=zGiCu3q+qNr/BOMkiS1RsLJlvcaWh3zqFpO+WzDzAzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCGD39JEbIMXc5KTqZphsPgPXq8aYGZV7DPJDNGi0Z6vQt6mSxhxpi/EOqffc0A5V
         R9RSDgaiT0+mxhI6SQzyinmoWZ0SaHgBJxjJa1Cg594B/QOdEMA8pUCGRD0mMZzU6h
         ac44U0rW31UV+i7xAcy13m6Jg3nJac/s2ybrOlyM=
Date:   Tue, 12 May 2020 12:39:01 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: pxa: use master-abort for device probes
Message-ID: <20200512103900.GG1393@ninjato>
References: <20200506093615.GO1551@shell.armlinux.org.uk>
 <E1jWGTr-0000VU-QI@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <E1jWGTr-0000VU-QI@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2020 at 10:36:43AM +0100, Russell King wrote:
> Use master-abort to send the stop condition after an address cycle
> rather than resetting the controller.
>=20
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-next, thanks!


--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66fMQACgkQFA3kzBSg
Kbahmg/7BbaCvEchkSwtfdsrEUjCgoGR47tN3YQ0O3dFHXEIg5LPl7dwcqcLm41G
LHsxiogiGxaVfA21SFjHmD+F/qkDd2SIe1E4hBBpyo4bZ15kiObgu47u3hIZDY9F
2ui0YcoGVWnfoqHOF3URd1hFUp1l73NyMXBrbbP60n/6SD/zeIhPeF7h2L0pazGf
cCjA3VFml3h05cg4JBd/AjxpSuScPXESax1vcHtkefXQJNwDX0UVJWFBSPQVpRIP
Z5Fp+M0Jft67ctUshMBqzXw3D/okI3qkauaSQybJLkg47Qq4yb7FK6Hj+nWdB5fs
8XlVaN3XNGhR9xn9fVdjdrWh2yQXWtJKPGzcvpgYb307lVhG49/bV0l+1VPO6Ism
1V4OnWCc0Q+Oeab3/QC4dfZbLyc+bXRlv8LQ79bR4Dbec41/Cf49CsiwWtcbeYYu
E0I7hzY73ZIFhyDRMA7w/OH8o4rL9i/MSAlY7wzjnG8bP+9GZkrIZzfgUl4l3cBt
/laRLLREU3USJv58G7YqHjahEebreSyvePLewB2LX7Ww+iYO6rsEyksS8hjMjvPi
AUochydAjb9CS5eNNMvd1CsywDy0gp9xVRvJU4HMa1mvLZS47OEfpQ1BgbXr6b02
VQ7PYp7oOMNSfBtq2unW8D4SYnkD0yVXZpriDZOLDr3/wsq5J4g=
=E/1C
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
