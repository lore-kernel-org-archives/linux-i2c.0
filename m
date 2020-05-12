Return-Path: <SRS0=mo/p=62=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C999C54E8B
	for <linux-i2c@archiver.kernel.org>; Tue, 12 May 2020 10:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A5B20722
	for <linux-i2c@archiver.kernel.org>; Tue, 12 May 2020 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589279937;
	bh=tm9lSSvtNzy6h4DOrsjoulb20ygFKKklW+4xpe3rOZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AEzclqfREL/vnps+ufSh+s6jwbSHz2CK+AhForQDrVeV3qU36BPxW0oWP/dstVERi
	 3h1GsvT3yoOFOerLhfR6nzrTZ3pve6Ya41BXwELZSd1zUkyRdsf+DcZ+kcerYCGAQB
	 SFfC8baFAkBndh1Ao3rxAC5iQOI1Rv9CsH5HODnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgELKi5 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 12 May 2020 06:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELKi5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 May 2020 06:38:57 -0400
Received: from localhost (p54B332DE.dip0.t-ipconnect.de [84.179.50.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E89A206DD;
        Tue, 12 May 2020 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589279936;
        bh=tm9lSSvtNzy6h4DOrsjoulb20ygFKKklW+4xpe3rOZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbP5bZJJzhuxVl9vcWLpMij/scMS/iBx1qblCihGUilL0x7Ka2K1mAo9/ewDoIShX
         05sOFq83NgdQQPkQKZgA6bWcpOph/HYWFh+W52fuCiD2EL1Px9ufLUwyc9AkUp0DwO
         VzXSSNG3WHR24QHkrWjHpqrc8FToVVg5nrgN/rL8=
Date:   Tue, 12 May 2020 12:38:53 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: pxa: clear all master action bits in
 i2c_pxa_stop_message()
Message-ID: <20200512103853.GF1393@ninjato>
References: <20200506093615.GO1551@shell.armlinux.org.uk>
 <E1jWGTm-0000VI-N1@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <E1jWGTm-0000VI-N1@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2020 at 10:36:38AM +0100, Russell King wrote:
> If we timeout during a message transfer, the control register may
> contain bits that cause an action to be set. Read-modify-writing the
> register leaving these bits set may trigger the hardware to attempt
> one of these actions unintentionally.
>=20
> Always clear these bits when cleaning up after a message or after
> a timeout.
>=20
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-next, thanks! I was considering for-current, though, but
there have been no real bug reports, so for-next it is.


--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66fL0ACgkQFA3kzBSg
KbZ0yg//SZ9+cUX+htduQUA7NMOOpXyDPwBzqIMsx/oHgy9/826cP4MyAihZtXK8
dkDaCX2OuZDF0Buxo70P2afoiJ8nyd9UuNhCG2ltXaK6utANxFpjMJaKB4fG5Oww
D3p1uKkmMxa5z5OIC13x0WR9Uj1Ua8hKglPmxtA0+sUFg3hwmPNe/prSwifFmn8X
DyIBXVRqrJSRPiuRN35VxsOPUSE9jpn77tdYkIHYj4LN1lit8gLjW1nXnVINI96U
cSk2VZ8yRQCg96pN41GOcnKqCK0WNvGKS+nhqabQFOXDbauf8H2gW7pTNgvuSm6E
/JnWAeTPtUcZQ8JSxc2MyyuiKoqLfIiVgL8of3rDy4rCQxkcaXAFLvAQx0ezTyjs
UO7BdnhaBm62lLJDhR4UiPz4NBz9I1lVOHfnvZxbicV5JU9O/l324nLR0AE0dbR8
2I9vIsGbaMFCJeKEU/YYRGk4tnYjxMavjJO6267ZCEKSzlxxmELf0v7ydJEFiElM
HypacBebdCixU+JmLi+e6pQ0nLSAfZQJ4p/1MnZQHuphEAVDXWt3b/Axr+fjomXN
a6KmZLkv5icRMFWpB8RcjnB2YQHhNt8ODUkPBjNtzj87TgjOks1nytaYZHecx/LU
KwvTObnlGQkFVZArGB6cBHOaSO+wvm/VaEUyp1c05ofSVQ2uwgo=
=Q7qO
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
