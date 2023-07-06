Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9207DC0015E
	for <linux-i2c@archiver.kernel.org>; Thu,  6 Jul 2023 02:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjGFCwW (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 5 Jul 2023 22:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGFCwW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 5 Jul 2023 22:52:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0514A1BCD;
        Wed,  5 Jul 2023 19:52:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QxLcN3Wpwz6J6ZW;
        Thu,  6 Jul 2023 10:50:28 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 03:52:16 +0100
Date:   Thu, 6 Jul 2023 10:52:12 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Wolfram Sang <wsa@kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 19/23] i2c: rcar: Remove #ifdef guards for PM related
 functions
Message-ID: <20230706105212.00007101@Huawei.com>
In-Reply-To: <20230705204521.90050-1-paul@crapouillou.net>
References: <20230705204314.89800-1-paul@crapouillou.net>
        <20230705204521.90050-1-paul@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed,  5 Jul 2023 22:45:17 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Use the new PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
