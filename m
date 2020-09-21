Return-Path: <SRS0=xDOk=C6=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3656C43464
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Sep 2020 09:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA121789
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Sep 2020 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600680878;
	bh=zJ8rCBjpvXd735KKJ6QWY4YfkIIrT78WC0pmHB/cxPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PkrK9jDrYXRxxuEaPvutGJzD83yE9ZvyBOeWyCzmuKdjaV3sbz/gUD1Dmh0kvOdxb
	 7nrdJQSk6HMlXknnx6K3Vxdjr2HcSutCPzxhsSz1U4Tnt5EriyBeObSwYHIbJmZPKp
	 5m7aODS5XpfGQEZWjUYa5OKRXom9ck25MEx3cajw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIUJei (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 21 Sep 2020 05:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIUJeh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 21 Sep 2020 05:34:37 -0400
Received: from localhost (p5486cf2a.dip0.t-ipconnect.de [84.134.207.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA0F20719;
        Mon, 21 Sep 2020 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600680877;
        bh=zJ8rCBjpvXd735KKJ6QWY4YfkIIrT78WC0pmHB/cxPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrEmwRLKeoxpsENIcYsYvKfjtHqplefO+rWoPL1dWGtW4EGks5bydeiOXsXcn1MnN
         Lq+bR4jqJcbO8NKKNvNQ+JJYZwqWGrIqJ7e+VnrYAZxRT3mW9gHfTnZs4OwdLDSHh3
         +5qt4JGdDPdfezjjTT6tRXO1MdxwoG6Y6NKj8z/E=
Date:   Mon, 21 Sep 2020 11:34:33 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] i2c: busses: replace spin_lock_irqsave by spin_lock in
 hard IRQ
Message-ID: <20200921093433.GH1840@ninjato>
References: <20200909041001.5612-1-song.bao.hua@hisilicon.com>
 <24424594-963c-c744-846f-cf79b6024b1c@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <24424594-963c-c744-846f-cf79b6024b1c@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 05:10:20PM +0530, Akash Asthana wrote:
>=20
> On 9/9/2020 9:40 AM, Barry Song wrote:
> > The code has been in a irq-disabled context since it is hard IRQ. There
> > is no necessity to do it again.
> >=20
> > Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> > Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Akash Asthana <akashast@codeaurora.org>
> > Cc: Mukesh Savaliya <msavaliy@codeaurora.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> Reviewed-by: Akash Asthana <akashast@codeaurora.org>

Thanks! Did you review the whole patch or only the qcom-geni part?
(and please don't include the full message when you only reply to a part
of it).


--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9oc6kACgkQFA3kzBSg
KbYUjw/6As1hzpnefE0ej085D43F5ZOatgsbQt+Irrjd7DBMTZK35Ml11JPcbCyT
z0k5qzUgYnq30yJ0x/Ab83seEk4zt4INCKtK93e0YqS7ywC7lof51Kur+Egm8pFm
vMFDwqvUCbeTgrTRq+oRGpWcH10IF2AzW1AMAc92JAIv83S3QjNIcoomIGg4Cfk/
ncWYhHNoX2IFUEt58/CDKg4DcozPnFNO0OIwq+M5yaQt1eCHY2qzOWd9aSOJyawG
4rgWmX93sLgkbMB9DzUECi19Vz+Pcw0fqda/LBlzZ65xhrwmqWRE+xQPPlQb5E3m
OZB5YNN5GEI7mV82IXFsVODZd4rD8+0Ffa9KFm4ClyCsrS6ZWEvwzLMolVayfUmN
KyuZkn9QtvuSuC5ZU4svg0A70nl/rW3dsHFCybdqIyO19aEJbyuau9O7ySIfk3VV
Mpxhvd0NvKIX4EZjiLIKZsj1DpJYL3OU0ITeVn9DXN7k8xSIOQ9+R4ci7Ld0gFKU
F2a4u3tbgJSIQ9C1NGnqU1DjTPCbxRbb3bZVldciEomt9EJ35PvT5TpP42GHDuXC
+8EAzSlwKGyVuN2WaMWCGv4jBY0EuaaoJzjIo946or2IrtyRM4jXdXtitvr/eX0s
2FT2uC0agbDvvDlUASQmwO77k0tPQyU9DI+tESLUhP+KwyWMO0o=
=at19
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--
