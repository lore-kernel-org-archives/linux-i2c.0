Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7304DEB64DA
	for <linux-i2c@archiver.kernel.org>; Sat,  8 Jul 2023 20:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGHUI2 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 8 Jul 2023 16:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGHUI1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 8 Jul 2023 16:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D141BF;
        Sat,  8 Jul 2023 13:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4B760B37;
        Sat,  8 Jul 2023 20:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97759C433CA;
        Sat,  8 Jul 2023 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688846905;
        bh=LcY1qvy9P41BUybqlDn8q578rWBLu/xQ79M9Beib7Dg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EiVs92kmqByDkZc8mg0Ujl5AKdHnJ+j39jsUgSyXHvw6u8ZvbwoVtbsI0O7GOajnz
         N6OhpQ7JM7dyf1LKGTlzBDTmhV6jx2qe9FetikYb1xIpg/nbSbE5PYs4+CLYetIH5t
         5SxwgFtoUk0cURKhE2KdBMjy4+B54Bas5dUagterpxRT2/oJK6obG6m6KCHmIT0vc0
         lh29Q/IeRbZpWpbAQG1v4VrNA370YwshzpnBBY2iyMG+qevk4megsUkCNNh78gxe2h
         IG13SIQT0xBy6uOTNLsY6/DgZvZvRIayz8anZl3JImnYkU4r5vTZsyY+SW5/KEVE3v
         Z+PZwerq5usPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8538DC4167B;
        Sat,  8 Jul 2023 20:08:25 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.5-rc1-part2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKhup2kTPKNKm2sW@ninjato>
References: <ZKhup2kTPKNKm2sW@ninjato>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKhup2kTPKNKm2sW@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.5-rc1-part2
X-PR-Tracked-Commit-Id: 6537ed3904a3b3720e5e238dd5d542448fcf94c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84dc5aa3f0d861281d353e4b7f4ea03da31e9aba
Message-Id: <168884690554.10103.2502624043872731600.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jul 2023 20:08:25 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Fri, 7 Jul 2023 21:59:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.5-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84dc5aa3f0d861281d353e4b7f4ea03da31e9aba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
