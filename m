Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D384C4708C
	for <linux-i2c@archiver.kernel.org>; Sun, 30 May 2021 04:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62A1611AE
	for <linux-i2c@archiver.kernel.org>; Sun, 30 May 2021 04:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhE3Ebm (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 30 May 2021 00:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhE3Ebl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 30 May 2021 00:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0B8F0611AC;
        Sun, 30 May 2021 04:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622349004;
        bh=v8/SrcQ9MFrmKVWSdci+2ca/mJjtR1Q5oQx5EPLqVY4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BiUZCkj+YJCC3QaCgFSsCAsUXReMrZqPW31rvP7OhcSmNSwvhJnMq+0svEKxeui5U
         LQe+2hS0bxW7wLXVzLCzSFHYv90X3lg/CQL3UQ8SdklSAW06kjYIQW4DOhQQfHzRPP
         rKX/HiG2JMMHKV64UGmgnqflqDooZ6YSBvHuAcrT8seG7G8PYTkmusPol+53wXz1SA
         fKJJPH2gxO978YqXlTfVq8e6/kW5Jp2ZTQ5hvIyIoUP1lB0qRUfIv9pA5OFEUoDslK
         qAbi6dml70cXiA5BdiNWClwQMOhPewmoGvBtptnqaOrI4P/MCsdfyJePXS3YcRnQey
         L9tk7QAUdjoRA==
Subject: Re: [PULL REQUEST] i2c for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLKvCNTvXTpPabHq@kunai>
References: <YLKvCNTvXTpPabHq@kunai>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLKvCNTvXTpPabHq@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 8aa0ae439966364da86fc6437375e32f2890c4c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b90e90f40b4ff23c753126008bf4713a42353af6
Message-Id: <162234900389.23697.5977152232605719404.pr-tracker-bot@kernel.org>
Date:   Sun, 30 May 2021 04:30:03 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 23:15:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b90e90f40b4ff23c753126008bf4713a42353af6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
