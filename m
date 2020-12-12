Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2291C433FE
	for <linux-i2c@archiver.kernel.org>; Sat, 12 Dec 2020 21:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA912065D
	for <linux-i2c@archiver.kernel.org>; Sat, 12 Dec 2020 21:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407933AbgLLVD6 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 12 Dec 2020 16:03:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgLLVD6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Dec 2020 16:03:58 -0500
Subject: Re: [PULL REQUEST] i2c for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607806998;
        bh=LrD1Zfl1EeJhmin2MIKPDd6M2V7CbI7jps+oos3WPoI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g1Yn1eCX9SGWyR1gVyrWOvYAuGI/fQR2flDsG1t58pSVuZiR1NLOWIOKRGnDnlzRO
         12GOJWb9CHdqkyoY2K4aJZU4TevVgZsCMgQVznvaTqSJW6Zb/afob0GQk3xASgm5Am
         dar9HsgUBw1iGOQwogDvRz/k0TsRMmDjmnDej/ikTQNtleXkm1VIeaA5qE6rFXASTX
         ytGfV0Rq2kL86Rdgi+0GAeHWPCz7jV29qbQ2RLpe7EaTyl8KIDqsn3MYljNW1y91iz
         cFhVd3i6vsT0wMgA3WCllso87zFCFSCQiuGolR6RcJjpe6/DivQ9eC5iIcybEbVXDh
         o67J1D0f4zlig==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201212183046.GA8096@kunai>
References: <20201212183046.GA8096@kunai>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201212183046.GA8096@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: e977aaf899a6d3b3d6658da66e262b6e307ae3a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ee595d9079b94ee931287ce004d34886b7d3c24
Message-Id: <160780699796.2095.10671629074764009696.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Dec 2020 21:03:17 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sat, 12 Dec 2020 19:30:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ee595d9079b94ee931287ce004d34886b7d3c24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
