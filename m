Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827EEC7EE23
	for <linux-i2c@archiver.kernel.org>; Mon, 29 May 2023 01:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjE2B6Q (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 28 May 2023 21:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2B6O (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 28 May 2023 21:58:14 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26244B8;
        Sun, 28 May 2023 18:58:11 -0700 (PDT)
X-QQ-mid: Yeas5t1685325426t271t41681
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.96.128])
X-QQ-SSF: 00400000000000F0FOF000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3208364526885793045
To:     "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc:     "'Jakub Kicinski'" <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <jarkko.nikula@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>,
        <mika.westerberg@linux.intel.com>, <jsd@semihalf.com>,
        <Jose.Abreu@synopsys.com>, <andrew@lunn.ch>,
        <hkallweit1@gmail.com>, <linux-i2c@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <mengyuanlou@net-swift.com>
References: <20230524091722.522118-1-jiawenwu@trustnetic.com> <20230524091722.522118-9-jiawenwu@trustnetic.com> <20230525211403.44b5f766@kernel.org> <022201d98f9a$4b4ccc00$e1e66400$@trustnetic.com> <ZHBxJP4DXevPNpab@shell.armlinux.org.uk> <026901d98fb0$b5001d80$1f005880$@trustnetic.com> <ZHB2vXBP1B2iHXBl@shell.armlinux.org.uk> <026a01d98fb3$97e3d8b0$c7ab8a10$@trustnetic.com> <ZHB9wJSgfQctd2aX@shell.armlinux.org.uk> <ZHCNEACuJB4EkZG9@shell.armlinux.org.uk>
In-Reply-To: <ZHCNEACuJB4EkZG9@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next v9 8/9] net: txgbe: Implement phylink pcs
Date:   Mon, 29 May 2023 09:57:05 +0800
Message-ID: <02dc01d991d0$de67a5e0$9b36f1a0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIrQcdiCo7tNEhbaUMwQ6r5o07FvQI4H2aIApOsZCcBuMNaNAG5zvSTAdySFWcA4jXyEgHRLN2uAkEn4IsCeSbpd65A2JWw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Friday, May 26, 2023 6:42 PM, Russell King (Oracle) wrote:
> On Fri, May 26, 2023 at 10:37:04AM +0100, Russell King (Oracle) wrote:
> > I'm just creating a patch series for both xpcs and lynx, which this
> > morning have had patches identifying similar problems with creation
> > and destruction.
> 
> https://lore.kernel.org/all/ZHCGZ8IgAAwr8bla@shell.armlinux.org.uk/

OK, I will send the updated patches after this patch series merged.

