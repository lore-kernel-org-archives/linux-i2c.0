Return-Path: <SRS0=5Ir/=65=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC5C433DF
	for <linux-i2c@archiver.kernel.org>; Fri, 15 May 2020 09:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796422073E
	for <linux-i2c@archiver.kernel.org>; Fri, 15 May 2020 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589534879;
	bh=cBYlCaqVOLK7rjga9zz23aZJFmIUMwBA4AndNb9TP+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wybbGwLl/gmFhaz+Y01o4fdAt7R+/C3DkuvyD/NUGSYhOomwnpWmwoHUyGfoYjH0z
	 eMFLcO3dzGDcc9KLqJ++L5UmVVBaykh0t6XcAQD227JXGYx5YoXLvG7CzBHYNBNPN5
	 ZFRtP3jKDMUW/ItWS1Oe7Pm6G7GbE6sXQGNw6CB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEOJ16 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 15 May 2020 05:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgEOJ16 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 15 May 2020 05:27:58 -0400
Received: from localhost (p5486CC07.dip0.t-ipconnect.de [84.134.204.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C1D206F1;
        Fri, 15 May 2020 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589534878;
        bh=cBYlCaqVOLK7rjga9zz23aZJFmIUMwBA4AndNb9TP+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTcQkoKVYq9u89DpLfBLuI6aTNhRfRXkmyEuEoolBUk2Dirq40P24fs9q7G+Pxw4n
         XVFUnFoUzpf/j/1kr20mEZqxKXBwSv1iWGRNlmseMRxr5CJ3t9RSW8r+Go8w0zI+JL
         LUchBeB7nCCsld7f1x3860mXCn8yNsRldQxopU6s=
Date:   Fri, 15 May 2020 11:27:55 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: eeprom: at24: Fix list of page sizes for
 writing
Message-ID: <20200515092755.GC2077@ninjato>
References: <20200512122450.20205-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20200512122450.20205-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 02:24:47PM +0200, Geert Uytterhoeven wrote:
> "258" is an odd power-of-two ;-)
> Obviously this is a typo, and the intended value is "256".
>=20
> Fixes: 7f3bf4203774013b ("dt-bindings: at24: convert the binding document=
 to yaml")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Since I have a PR for Linus pending anyhow, I step ahead and apply it to
my tree. Hope this is fine for everyone. Applied to for-current, thanks!


--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6+YJsACgkQFA3kzBSg
KbaZMw/+NKXHpNfewE9b06Ded1PJF/YxaFIl7FQNhIkC+doQO6fJL80XCwHlNF6M
MLYTiAX05VJ/7ezfixG/FfXMr7u1J5oUxS9OlUs7wmavTMKFEQcC/vgvEG0pvv/R
V79ExrkiOOrJv7aeeXX/1UNsuP2ShIbIct5faQ0IvMyovXLPFtOtLcHLmZNn1uaa
yu3r+rNkz7tLuBFMG6qmhNvwnhCFAD4EFIvMhfrg3up8lJwsMQO0CxZOc+8W0T7t
R/lWqXI2ikAoxXIK75fU2/DwDtgEzQdgjKhoUcumks8zDTMxKw7XCFx1wujYhUg6
YAtZHUr91hKZ+USCxVudEBLyyTxxD3H8GIkTaAXi9Vv99zAJ4GSGlwrAfycD/Ib6
U9Xee00d/i919f4oJqb0GH93w+jaB8CO30220PpD27kixUpP0bHgFzEXY9F2vnJ5
AlHRL+VnOlp5rrEcZs/oBXd2CKKG2paJuvDJ9BrgThMSEgGPd5rIDpl41j3x6Fyv
U2I+ZRpSML5Ir/uQ/gcyWXun8dlxZKWrx3v+P3rIzMvOZaMnC1zvuk4ShRShf4l/
+XcIYft3YUeDxZwMF3DAP7g32IgY2qvyCzVjkJa7obsatWdA7CBf7eFhwIsFrts2
qOOV93LsAbM99pE5B/tVQ/fgiI57/nvRPLJ9YnQX0MME5KzXrbE=
=gs0y
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
