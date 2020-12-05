Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C3EC4361B
	for <linux-i2c@archiver.kernel.org>; Sat,  5 Dec 2020 23:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39E82310E
	for <linux-i2c@archiver.kernel.org>; Sat,  5 Dec 2020 23:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgLEXeQ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 5 Dec 2020 18:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgLEXeQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 5 Dec 2020 18:34:16 -0500
Subject: Re: [PULL REQUEST] i2c for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607211216;
        bh=3XssecLcFa7MgOZUiYOINuudNR0yZjnyeJ6ScDefPXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NT1ck/DsOPuL1ox1QMSsEnjjmggs3roNy3nusGoY+u+J0vpQVmhoVK27ppqJuUGzT
         fNW3R5iJYiOfCseysVO6Va/WutIgcPLPfPbGY8E4Yt0ptammF607C6tO6MIAEBdXDn
         1F6qtKaX46V3GtlhconSF8kVSBaZzv9gdDrtU8vx1M/nAqN1NvvZ/m3yZzfHFgyagQ
         /h0dpWZxRH7S2VvObBUrdz520ZXSvh3hr5peR4LeOQY+vQTPK1ypAtR2BQELBtiW5G
         VQs/wdBVBFKRfKZt1BqJnKLcFjpdYZQ9nFBtxG/d8rzlb3/6MQiJ0AIUfcytCd4kHP
         Izgj84nuehXmA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201205221143.GA19137@kunai>
References: <20201205221143.GA19137@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201205221143.GA19137@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 2bf9545626f8d09f552ab86d0047a415fe9a07a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33256ce194110874d4bc90078b577c59f9076c59
Message-Id: <160721121599.28754.18135648875618116594.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Dec 2020 23:33:35 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sat, 5 Dec 2020 23:11:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33256ce194110874d4bc90078b577c59f9076c59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
