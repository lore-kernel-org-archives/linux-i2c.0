Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE576C07E95
	for <linux-i2c@archiver.kernel.org>; Sun,  4 Jul 2021 20:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFABA613C2
	for <linux-i2c@archiver.kernel.org>; Sun,  4 Jul 2021 20:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGDUM0 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 4 Jul 2021 16:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhGDUMV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 4 Jul 2021 16:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B1028613E9;
        Sun,  4 Jul 2021 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429385;
        bh=rLu2kPPH9uNktVgltxCjCdmCZbEgt6v8XRQs12U+xEI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oj19I1pOdUyI+tfm2PtIL2shbdIbWj1QM775Fo+c3PuYnnRpkDE2AutAMdbmI11be
         +jsk+eO6NwtfKtX6P3lgk6r0M5Nkj0gilfhPA6tpTtc1rNpK7e1EyCJZtVF9g+J0iO
         75VlD+3TBYoFbhIVI3UH22o9WHlkUmxh9UM7h1JHwme9x4+m3C/Sl5/BRiBa2Xx9B4
         T0E3MvwT8iEn5NuK7fglwn0zNIEsaRx0KZgW/7i/SGXbE7DLKu3e1LRZkxswZZoNAe
         ngNtFHCc1KT0VvuhNlug9fm6Ox73eviQTfb/v58gHrxgqMienm/LLPDQ9bHjBKY0Yy
         DzIZDV8rHtpBA==
Subject: Re: [PULL REQUEST] i2c for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOFkTpjuZQsWXDHq@kunai>
References: <YOFkTpjuZQsWXDHq@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOFkTpjuZQsWXDHq@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-mergewindow
X-PR-Tracked-Commit-Id: 9d6336831bdc78e5207eaf147cc17228b5e984c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 855ff900b8605df2b9ea309534cd2f02dc0c4cb8
Message-Id: <162542938569.15409.17116823913967137089.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jul 2021 20:09:45 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sun, 4 Jul 2021 09:33:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-mergewindow

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/855ff900b8605df2b9ea309534cd2f02dc0c4cb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
