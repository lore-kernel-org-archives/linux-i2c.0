Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A4C47082
	for <linux-i2c@archiver.kernel.org>; Sat,  5 Jun 2021 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E24613AD
	for <linux-i2c@archiver.kernel.org>; Sat,  5 Jun 2021 22:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFEWxr (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEWxq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 5 Jun 2021 18:53:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5F46561241;
        Sat,  5 Jun 2021 22:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622933518;
        bh=2+nYdxYEM/SZuBVb7f0E7/u/5dlYum6nqgc56d1RTVM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iHtdSMXD6bQgI/h12xkjEsvYaxtF5TWk87gQXJlPhkovGUl0g6vIR8DRuSJXFqhh2
         +mjZmmAavHpARRsFns3rbZcjlXzN4auElrN97gTAFoJXvlf5LRTQ/L7mKV6kwRhnrQ
         c8Gz7VdrjqJTDxd9mdoASW1o9cnPPPa9ML8Vszp3obXwmJEjcv9fiihuTfLjebHAKn
         0F3Ppzxv7Q6z9flKnc90ihPJUGB/TU6pVowRXUs/8lvWwJ2HfZqJ8HPrvjRo9FOcWO
         9j9exGk7+wiCILFkj7h77fD4WrObf1D2qc6oCPtqH/TUiL4xaQ6vTuEO+4oi2O8NUs
         d5L/usxflQ8Kw==
Subject: Re: [PULL REQUEST] i2c for v5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLvwtW3JuDU0MC8E@kunai>
References: <YLvwtW3JuDU0MC8E@kunai>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLvwtW3JuDU0MC8E@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 57648e860485de39c800a89f849fdd03c2d31d15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5b6eb1e018203913dfefcf6fa988649ad11ad6e
Message-Id: <162293351824.10457.7133650316542401322.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Jun 2021 22:51:58 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sat, 5 Jun 2021 23:46:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5b6eb1e018203913dfefcf6fa988649ad11ad6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
