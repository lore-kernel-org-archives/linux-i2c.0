Return-Path: <SRS0=78di=DZ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15569C433DF
	for <linux-i2c@archiver.kernel.org>; Sun, 18 Oct 2020 10:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB269208FE
	for <linux-i2c@archiver.kernel.org>; Sun, 18 Oct 2020 10:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgJRKpJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 18 Oct 2020 06:45:09 -0400
Received: from mailout04.rmx.de ([94.199.90.94]:60560 "EHLO mailout04.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgJRKpJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Oct 2020 06:45:09 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout04.rmx.de (Postfix) with ESMTPS id 4CDc3Q1Bxkz3qwls;
        Sun, 18 Oct 2020 12:45:06 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4CDc393Ktrz2TSDs;
        Sun, 18 Oct 2020 12:44:53 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.10) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sun, 18 Oct
 2020 12:44:11 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Wolfram Sang <wsa@kernel.org>
CC:     Oleksij Rempel <linux@rempel-privat.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David Laight" <David.Laight@aculab.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 0/3] i2c: imx: Fix handling of arbitration loss
Date:   Sun, 18 Oct 2020 12:44:10 +0200
Message-ID: <1812241.n2eA9Fn7ml@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20201010110658.GA4669@ninjato>
References: <20201009110320.20832-1-ceggers@arri.de> <20201010110658.GA4669@ninjato>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.10]
X-RMX-ID: 20201018-124453-4CDc393Ktrz2TSDs-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Wolfram,

On Saturday, 10 October 2020, 13:06:58 CEST, Wolfram Sang wrote:
> > Changes in v5:
> Changes in v6 were missing... Because patch 1 was updated, I reverted it
> from for-current and will apply this series to for-next instead to give
> it some more time for testing.

can may patches be merged into for-current for -RC2 or RC3?

Best regards
Christian




