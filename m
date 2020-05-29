Return-Path: <SRS0=6WmS=7L=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD6BC433DF
	for <linux-i2c@archiver.kernel.org>; Fri, 29 May 2020 10:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E3F207F5
	for <linux-i2c@archiver.kernel.org>; Fri, 29 May 2020 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgE2K6m (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 29 May 2020 06:58:42 -0400
Received: from sauhun.de ([88.99.104.3]:48962 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2K6l (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 29 May 2020 06:58:41 -0400
Received: from localhost (p54b33184.dip0.t-ipconnect.de [84.179.49.132])
        by pokefinder.org (Postfix) with ESMTPSA id 3BB402C2034;
        Fri, 29 May 2020 12:58:40 +0200 (CEST)
Date:   Fri, 29 May 2020 12:58:39 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 2/2] i2c: i801: Instantiate SPD EEPROMs automatically
Message-ID: <20200529105839.GC3417@ninjato>
References: <20200316112224.0eaeb925@endymion>
 <20200316112448.073eecf6@endymion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <20200316112448.073eecf6@endymion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 11:24:48AM +0100, Jean Delvare wrote:
> Call the function to instantiate SPD EEPROMs automatically on the
> main SMBus controller.
>=20
> Multiplexed SMBus systems are excluded for now as they are more
> complex to handle.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>=20

Applied to for-next, thanks!


--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7Q6t8ACgkQFA3kzBSg
KbZT7A/8DborQQLuHSn+c7DJTthLn25KKK8+XDZZeBJ/S9239Ry5rVyvknVYTclf
cH8uhYKbqJSnn101YFHRxk+tmQErr5dJunFIF6IrzNue6BpDfD0nlAtDI0ZlxltE
EM6H8c1+dUvqDMH44gQLXbfXzn1QCM9KN1TTzgHAnV3OHOT1B5WNL0qotBjTOOat
Zkfj+eHECsvByQi7tHQ8y3iaizLgbPo2diXKRAqjFkgK3mugDtfgBMPsIeyihH0p
NdzC2zNk+5fOy/B3rHzOG8v7N4NWjbRFDKySTAvhIwkYIxNiKrV7wNbFYJ4ONEsP
0tIHL2RYZhqMn3J2egrcKCgHsfVEQX/l9aISr+vSzLwEd/b7HcidIwydGLx5/FGF
jCt+qyEgAIqQtp2/CuBMRw3jV8b1cNRLD48TzfqWPw7SNB63BgQEqbnWb1EkczkP
c+e6KIRVhauPJF/LOFAR6KxGfE2BJReUkHBWrosEyacxJtqLMmGRmy02UP4k4tgH
2mb/OtymPJ3a0cIFYvhsxNCWybQCfh9jGA4WjWmnDhi0SYllAi+RUjKNQU+zkP2p
WBQfBnOc/7ftNK+MQ3rWxSwQ9aTUq7ffs007U6fOz36ekHr0bbKQnD3NAewu0B70
hhx1uwN7kAVeI1d6M4UslK7SUVKHLl/SuJ4PxNyyssqUEobifGo=
=rLtE
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
