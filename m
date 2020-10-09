Return-Path: <SRS0=M59A=DQ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4552C433E7
	for <linux-i2c@archiver.kernel.org>; Fri,  9 Oct 2020 11:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DBF2087D
	for <linux-i2c@archiver.kernel.org>; Fri,  9 Oct 2020 11:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbgJILDW (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 9 Oct 2020 07:03:22 -0400
Received: from mailout09.rmx.de ([94.199.88.74]:37401 "EHLO mailout09.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731963AbgJILDW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 9 Oct 2020 07:03:22 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout09.rmx.de (Postfix) with ESMTPS id 4C74tZ5Rdmzbhv1;
        Fri,  9 Oct 2020 13:03:18 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4C74tJ111tz2xjx;
        Fri,  9 Oct 2020 13:03:04 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.145) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 9 Oct
 2020 13:02:23 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David Laight" <David.Laight@ACULAB.COM>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v6 0/3] i2c: imx: Fix handling of arbitration loss
Date:   Fri, 9 Oct 2020 13:02:06 +0200
Message-ID: <20201009110209.20645-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.145]
X-RMX-ID: 20201009-130312-4C74tJ111tz2xjx-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Changes in v6:
---------------
- Fixed commit (W1C vs. W0C)
- Extended patch 1/3 for atomic case
- Added acks by Oleksij Rempel

Changes in v5:
---------------
- Added missing "Tested-By" tags.

Changes in v4:
---------------
- Extend comment (W1C vs. W0C)

Changes in v3:
---------------
- dedicated function for clearing an irq

Changes in v2:
---------------
- Don't accidently clear additional status flags on Vybrid
(reported by Uwe Kleine-Koenig)



