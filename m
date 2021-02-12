Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37262C433E0
	for <linux-i2c@archiver.kernel.org>; Fri, 12 Feb 2021 10:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B7264D9E
	for <linux-i2c@archiver.kernel.org>; Fri, 12 Feb 2021 10:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBLKQo (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 12 Feb 2021 05:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230362AbhBLKQm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 12 Feb 2021 05:16:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F9CE64E57;
        Fri, 12 Feb 2021 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613124962;
        bh=VFUsungzZqooziKm9KBKtUmrjVmAmKtrpEiMVbY0kQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEF4kCQin2Brrzoz2QDUTScLq3WAuguEp+3tLn2z76Ozg7sqcPfMgRQxH4OJXjYEk
         PJKdwdBgQ8uLwG5eW75qp07CMAuTIZtC5fsnEObU14w8QUi3/6aSwPAiNzVedHEqly
         zeBjzWn0QEqP1MSvL5AKm5k9wLe3T9Q1hHIq4gG/+NpbLC2sux7o/8tTNEWcUBIJkj
         Sc+KS/7hPemmrVYPlqk4EouZgveDMR+C3oDBOkdj0Jmo3oVMEnlAxdqccF7M/m6+59
         ptL3cg+jPCJR4zcDeeLdhyec32rRmI6qIVxnroP13c3yAjv2YHgEo3JNqDm37XBul4
         NCccg+tmFLmAw==
Date:   Fri, 12 Feb 2021 11:15:54 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-i2c@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: Re: [PATCH] i2c: remove redundant error print in stm32f7_i2c_probe
Message-ID: <20210212101554.GB8038@ninjato>
References: <20210112085311.7308-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20210112085311.7308-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 12:53:11AM -0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
>=20
> Coccinelle reports a redundant error print in stm32f7_i2c_probe.
> As 'platform_get_irq' already prints the error message, error
> print here is redundant and can be removed.
>=20
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

Applied to for-next, thanks!

@maintainers: it would be helpful/faster if I could get an ack from you
beforehand.


--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmAmVVoACgkQFA3kzBSg
KbYKAw/+PDeUcjlo2xoGrNaTwJoDDUrsWYVwsC+nASaoztdWl9k0lj9jyAJGEd2R
U+iuCErfC/dHQodaeuWzMZU3Agh55DwCDj3//DIlJ6ctt81gAYRqQTBF2DPudX8t
MTsKl/Um6uHVuX3MK97yxtjPS/G41TlCB9ezeVfMyNfdNjmsHgXFySI8VxFdfaS2
QxqSKj1WmNnalBE3ruNAKuNRKEpHyCGz2SOvhldlG789qSIdn92Pod5E6oAbxaEt
O7w5aSeGYANShNGZCZwT7uGYyL5Sw6eKTHuPNJX659KrboDr5d8zOXIhzVBxJMNQ
PqIRmx8aLUVLnXZ0WoZ4G++ehLTTJI6UCMlpJ1CUGfiPKRMZfmd95eZuqeiNg/RN
1z+7bgCJo5PFQmH7hu7qP2xtG2Pm9nyGWx1Xg+JhRiXeX4Cos9x3bGiMYT9Q1Kdb
ujRK53S6KFW1ePYpjMcWze5KENNf2WKgmUusauAToXb1GsHhKQWuQg/JAyANorvQ
vCYIfoLITDQmJr8OATyp+oK1PncvxcPetBgwHOfIOOfKxPDEcafVskvKlfO9MPXg
lZJAnGB5wUdkvdGQrI4GUb4ubywt2CnxB5GoR/mKNDKYZgSl7aq2RDmQgnC0ASQ0
ZHIyh9Jvo2D8cyWFRPIM7FKC4gyz/IIeUuo1Caj9C2/32qMyydw=
=O1pu
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
