Return-Path: <SRS0=99jd=DT=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8FC433E7
	for <linux-i2c@archiver.kernel.org>; Mon, 12 Oct 2020 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B325E2087E
	for <linux-i2c@archiver.kernel.org>; Mon, 12 Oct 2020 19:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgJLTwP (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:52:15 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:57284 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgJLTwP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Oct 2020 15:52:15 -0400
Received: from [37.201.5.97] (helo=[192.168.1.61])
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rainer@finke.cc>)
        id 1kS3rb-0005HB-0n; Mon, 12 Oct 2020 21:52:07 +0200
To:     linux-i2c@vger.kernel.org
Cc:     hdegoede@redhat.com, mika.westerberg@linux.intel.com,
        wsa@kernel.org, sashal@kernel.org
From:   Rainer Finke <rainer@finke.cc>
Subject: [Bug 209627] Touchscreen doesn't work anymore since commit
 21653a4181ff292480599dad996a2b759ccf050f (regression)
Message-ID: <ab71ef62-64c8-ff31-c5aa-43ad454d1143@finke.cc>
Date:   Mon, 12 Oct 2020 21:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Con-Id: 198604
X-Con-U: 0-mail
X-Originating-IP: 37.201.5.97
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

After upgrading from Linux 5.4.68 to Linux 5.4.69, the touchscreen of my 
Huawei Matebook 12 doesn't work anymore. The same issue happens with 
Linux >= 5.8.13.

I've compiled Linux from git to verify if it was fixed, but it doesn't 
help. But when reverting the commit 
21653a4181ff292480599dad996a2b759ccf050f the touchscreen works fine again.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.8.13&id=953fc770d069b167266d9d9ccfef0455fcfdc070 


For reference my bug reports:

https://bugzilla.kernel.org/show_bug.cgi?id=209627

https://bugs.archlinux.org/task/68178#comment193400


Hardware:

- CPU Intel Core m3-6Y30

- GPU Intel Graphics 515



Sorry, I had to resend this message, it was rejected due to some 
automatic html encoding.

Thank you

Rainer Finke
