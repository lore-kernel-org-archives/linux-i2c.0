Return-Path: <SRS0=8KIb=DN=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F6EC41604
	for <linux-i2c@archiver.kernel.org>; Tue,  6 Oct 2020 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320B1206F7
	for <linux-i2c@archiver.kernel.org>; Tue,  6 Oct 2020 16:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJFQJO (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 6 Oct 2020 12:09:14 -0400
Received: from mailout04.rmx.de ([94.199.90.94]:53882 "EHLO mailout04.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJFQJO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 6 Oct 2020 12:09:14 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout04.rmx.de (Postfix) with ESMTPS id 4C5Mpv1KFQz3qx4r;
        Tue,  6 Oct 2020 18:09:11 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4C5MpX27YJz2xg5;
        Tue,  6 Oct 2020 18:08:52 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.45) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 6 Oct
 2020 18:08:25 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Oleksij Rempel <linux@rempel-privat.de>,
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
        <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH v4 0/3] i2c: imx: Fix handling of arbitration loss
Date:   Tue, 6 Oct 2020 18:08:11 +0200
Message-ID: <20201006160814.22047-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.45]
X-RMX-ID: 20201006-180856-4C5MpX27YJz2xg5-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Changes in v3:
---------------
- dedicated function for clearing an irq

Changes in v4:
---------------
- Extend comment (W1C vs. W0C)


