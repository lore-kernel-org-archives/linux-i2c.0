Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B2EC433B4
	for <linux-i2c@archiver.kernel.org>; Fri, 30 Apr 2021 20:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F286145A
	for <linux-i2c@archiver.kernel.org>; Fri, 30 Apr 2021 20:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhD3ULk (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbhD3ULg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 30 Apr 2021 16:11:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 71C8261407;
        Fri, 30 Apr 2021 20:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619813447;
        bh=7eb2iaMzAthFGWm5OPGE3w05Sc+jffJXOiGL8NeZzP4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e/Xz3vX3eKHsXitSYttCQJcl8PpRG8T4JJDhiBbTn20/ASULuwl6GmeO6JSDAFqHb
         A7noAk89A+ls/TbolUWr3uoA3Uq/AGXtGTkXLeJmy8J3PP325KL01KHig6w2RMjJrh
         v4c02ylB+OPjnncd9eXusIVjPAouXeqRDoUtIpDtPk/RZYm2gRdWq0h2ecRVR6wld5
         UJs9OpLShBXUU+WY5IcwsHO/FOvh1KhSFZBvvY2NPOg6fsCoZf6szsNIr111aSMLyQ
         CbUXwJMA/EM7EvnxJvr2tubwNAxoR1pkBHS37w+2IT51sL3uh6DivYhJdXvOuPctjZ
         XnbSa2DhZNSrQ==
Subject: Re: [PULL REQUEST] i2c for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210429195058.GA3179@kunai>
References: <20210429195058.GA3179@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210429195058.GA3179@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.13
X-PR-Tracked-Commit-Id: a80f24945fcfdff31bdf04837145e56570741a67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 592fa9532d4e4a7590ca383fd537eb4d53fa585a
Message-Id: <161981344731.32283.14182986866825694750.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 20:10:47 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Thu, 29 Apr 2021 21:50:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/592fa9532d4e4a7590ca383fd537eb4d53fa585a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
