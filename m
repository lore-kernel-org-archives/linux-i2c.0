Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A40FE7737C
	for <linux-i2c@archiver.kernel.org>; Sat, 30 Sep 2023 17:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjI3RRO (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 30 Sep 2023 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjI3RRO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 30 Sep 2023 13:17:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F595DD;
        Sat, 30 Sep 2023 10:17:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1727C433C7;
        Sat, 30 Sep 2023 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696094231;
        bh=oWcttTf61HjKvfIkkVizsKFXCgn5+VkUjFhR/KFGnfg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uxAMBIlMEcht/ymgrjnyCx9frobEeuDnutBGitUp6xRoJlzEYVtDq4oZnSTzyKdyl
         k7v19jZVScRcoe/umpwKQCMIcn3MfeH1WAmYmtyEbEJglOa5KWfnV8cL8tgro8vY8r
         7gylKQQDHps79Tj1ciN+QrPczdqo3zpiZRgEtwJi1IRT3PsZh32awB/iCiVuy4fKbS
         WuUl+FQfXw7G4P9/4EnBJyOztAQY3lAJfudBCSL/55EPVxa19ROj5guImGxVPW94vp
         Ru/TbkoQOzY3iScmlHqZfAUtaOykFiT0GfHEX7ss1YI0uJ0vGu8B4GNnc7gQn08PWb
         Ls3gM6XyW1zww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADDCCC43158;
        Sat, 30 Sep 2023 17:17:11 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRfxMZNe8wiyX/nc@shikoro>
References: <ZRfxMZNe8wiyX/nc@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRfxMZNe8wiyX/nc@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.6-rc4
X-PR-Tracked-Commit-Id: 92e73d807b68b2214fcafca4e130b5300a9d4b3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cefc06e4de1477dbdc3cb2a91d4b1873b7797a5c
Message-Id: <169609423169.26087.12800448957784414529.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Sep 2023 17:17:11 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sat, 30 Sep 2023 11:58:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cefc06e4de1477dbdc3cb2a91d4b1873b7797a5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
