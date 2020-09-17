Return-Path: <SRS0=DpqV=C2=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F36C433E2
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF16B2083B
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 12:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgIQM5i (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 17 Sep 2020 08:57:38 -0400
Received: from mailout11.rmx.de ([94.199.88.76]:34391 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgIQM5c (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Sep 2020 08:57:32 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 4Bsbfd4kKVz41xp;
        Thu, 17 Sep 2020 14:21:13 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BsbfP0DJ3z2TTMr;
        Thu, 17 Sep 2020 14:21:01 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.80) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 17 Sep
 2020 14:20:39 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] i2c: imx: Fix handling of arbitration loss
Date:   Thu, 17 Sep 2020 14:20:26 +0200
Message-ID: <20200917122029.11121-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.80]
X-RMX-ID: 20200917-142101-4BsbfP0DJ3z2TTMr-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On my (noisy) system, I2C arbitration losses happen quite often. In it's
current implementation, the IAL flag is partly handled, but has a
number of shortcomings:

1. The driver runs unnecessarily in a timeout when waiting for an
interrupt.

2. The driver performs 500 ms busy-waiting without any value.

3. Arbitration loss errors may be reported one transfer later than they
occured.

Best regards
Christian


