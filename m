Return-Path: <SRS0=zHkP=CY=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B31C43461
	for <linux-i2c@archiver.kernel.org>; Tue, 15 Sep 2020 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033D020872
	for <linux-i2c@archiver.kernel.org>; Tue, 15 Sep 2020 22:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cAzen0ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgIOWa6 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:30:58 -0400
Received: from crapouillou.net ([89.234.176.41]:47096 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbgIOQRV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Sep 2020 12:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600186056; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeHYzr0958dGGkHCYK6Im3thQpiydn9WKwW0LwMC0os=;
        b=cAzen0ldD6VoAkvHMkSApV8s0zPnzM5U2zHfIuefdFyWrCQJOYRkhAcc830BfaNWtNH79f
        ssjL/64wOG2kFGeLSOJlJILvBjPyEtkXtLk6U3etbp80umY9gw4fK0T+VH1sBD/0oCUlyR
        w4vs9SqnMjXCQeUKZjzpAHWv3alE7XA=
Date:   Tue, 15 Sep 2020 18:07:26 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] i2c: jz4780: Remove of_match_ptr()
To:     Rob Herring <robh@kernel.org>
Cc:     od@zcrc.me, Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <EGJPGQ.QVHGTYQDQR872@crapouillou.net>
In-Reply-To: <CAL_JsqLUSZFf_3zgFrapc7vJETG9+XDTZPtD_yEBvi4GO3xPSA@mail.gmail.com>
References: <20200904131152.17390-1-paul@crapouillou.net>
        <20200904131152.17390-3-paul@crapouillou.net>
        <20200914221230.GA349829@bogus> <CS2PGQ.I4UMQBYTB15I2@crapouillou.net>
        <CAL_JsqLUSZFf_3zgFrapc7vJETG9+XDTZPtD_yEBvi4GO3xPSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org



Le mar. 15 sept. 2020 =E0 10:03, Rob Herring <robh@kernel.org> a =E9crit :
> On Tue, Sep 15, 2020 at 4:07 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi Rob,
>>=20
>>  Le lun. 14 sept. 2020 =E0 16:12, Rob Herring <robh@kernel.org> a=20
>> =E9crit :
>>  > On Fri, Sep 04, 2020 at 03:11:52PM +0200, Paul Cercueil wrote:
>>  >>  CONFIG_OF is selected by CONFIG_MACH_INGENIC, therefore we don't
>>  >> need to
>>  >>  handle the case where Device Tree is not supported.
>>  >
>>  > What about COMPILE_TEST? If not supported, why not?
>>=20
>>  What about it? It will still compile fine with COMPILE_TEST.
>=20
> CONFIG_OF could be disabled in that case, so the above reasoning=20
> doesn't hold.
>=20

CONFIG_OF can be disabled in that case, correct, but why should we=20
care? The driver will still compile fine.

-Paul


