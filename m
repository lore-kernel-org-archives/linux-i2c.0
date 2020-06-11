Return-Path: <SRS0=Y4BA=7Y=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF11C433DF
	for <linux-i2c@archiver.kernel.org>; Thu, 11 Jun 2020 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F0D2078D
	for <linux-i2c@archiver.kernel.org>; Thu, 11 Jun 2020 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591871593;
	bh=6ciKth2+v9htSh3Y0hbvsRR8Fh9bbzfJcuAe8GB+lwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BgkhNQCZ2f6hzvdvcqZhFrIJLFD1p/VXPlQja3VllqOvPx8dSN1YN0bOgelRMUccV
	 BVLKKjfh/Idb6lqMAATrqpG0k++0ice9jM/6GxeYhZ5muFKRCvj8+E+w02gqSAfUwr
	 KGSPSIYomkHHK4BliHXqKF4jLNvjEZ0etu+iVqz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFKKdN (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgFKKdM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 11 Jun 2020 06:33:12 -0400
Received: from localhost (p54b33245.dip0.t-ipconnect.de [84.179.50.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D933F20760;
        Thu, 11 Jun 2020 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591871592;
        bh=6ciKth2+v9htSh3Y0hbvsRR8Fh9bbzfJcuAe8GB+lwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+kV68T1kQ3xIQNYutnIOiMYhnyCN0wfgHBdUuSm0/uZFKSZeQXjGPZL1f2vKymbB
         3rUhQQKw3l3JFyq8N3rtOGCiGekZGWyfVxZdcZpx68y9NIASPDW0lfZcuM+4RpSHrZ
         thycZT5B9oSuBNmD0C5EDvFYrm+K2bOHAqZnLhEc=
Date:   Thu, 11 Jun 2020 12:33:09 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: Drop stray comma in MODULE_AUTHOR statements
Message-ID: <20200611103309.GC1132@ninjato>
References: <20200611120347.4514e126@endymion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20200611120347.4514e126@endymion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 12:03:47PM +0200, Jean Delvare wrote:
> It is not the common usage to have a comma between the name and the
> email address, so remove it.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>

Applied to for-5.8, thanks!


--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7iCGUACgkQFA3kzBSg
KbZtCQ//YFGzfhtv+M/+jxgLhCsXwMlo/ugd8d2NdnhSuzvKHRoyifDRDnYSDEmA
1QxCTUbd3pNpi9RH9ww1obB1ijrb5zSSNnfIC+t5tdSqv+A18eCv6XExgFYB19Y4
SMiXNuBTaemPwritwLdkt+OX+kTjLt7ipoBvCaYgIsLrnmEd3nV7+bz43zpA1AuG
rvFz55Mmz8zdSJYaPsX7hk/lTP+FKuArDGpsNbmVReISL7N8bj1+JSS1H1tSs+bG
+Xd5X5QeWjYb9oD0PfEaKItFq2QuuLJ2gD7Zm+2deaIcafBVJxKexSvN35iSyAua
TaiVXosiSQqwrLebJruhduFZwNe55aF40umJ4vJQymgYsm+HxavCJZAqU4xXAzm0
QO1qWvno0IksbNIM/ToHbVylAg5JqhdVXvnbXcuHUYa/V5m6tzHApJP+U8956fme
aaAfHQZEwrHm8Quo7KsPtGmI39dC/zSCoslB1dg6VDmflhwDWBfaK8dcfyiqJ+cW
kdRogiSzRLjHLCTJBq8NY7yJxUWfM15C19A810doi3ZoRm3mlu1P5RsFhuBXEh3G
v2ASPxTR9ZncS/6dppTbptYgNaYBYgkE63AlW+gnYx14hcy2vl/0T/gYGXRyvVMS
MA5BsIOEH2J8UNv+R07Kcziv3LH3rjw8C0EhQtLNMS3Lv+lL7b0=
=7ZkA
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
