Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740EC4332F
	for <linux-i2c@archiver.kernel.org>; Sat,  5 Nov 2022 02:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKECyf (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Nov 2022 22:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiKECye (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Nov 2022 22:54:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF5D2DD0;
        Fri,  4 Nov 2022 19:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A051AB82EFE;
        Sat,  5 Nov 2022 02:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 469AFC433D6;
        Sat,  5 Nov 2022 02:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667616871;
        bh=UM9P+ueQcAjWnRUJ4CMitBsva3ddXGqyXrVLc77TIoU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D/yyG/fPGaVQhxDQ4Na1pc/q6IOBQHxk6yl5wXtNrdZcM93QaRm1TrXw1H49hw1ya
         ctk1SVxG5fm7/zCpx2zyNHDsBnVkaqqhDovn2wTybAcAAnLoYlf6ok7JeYmR9u8JeF
         61d776PH/4yU308ZfVDbcJ0pPiutHAmOZOZjqWSTykg9eOzddXdctrO8alxhHRyNBz
         9oGchdv+OIpy8vXTCBdQn44LCsSC1JQfEZJyWjWSNECHWpIlbVGGtOKNo7Yd+uhlr/
         zYFEGAZekZBg3imuEBgoubjQemQw1hBruLMoUHgFdiwr9tkL7NI4t9cMe39GbsZjSO
         CkrQvJyQWGOyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33031E270FB;
        Sat,  5 Nov 2022 02:54:31 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2WO1gSIY9CjCIU0@shikoro>
References: <Y2WO1gSIY9CjCIU0@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2WO1gSIY9CjCIU0@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.1-rc4
X-PR-Tracked-Commit-Id: 8e987f1f4da92d9f1dd020418bfab9fe04b1c54c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74f3f1d79a1d17a319e20eb31d3edd25c03bdd9f
Message-Id: <166761687120.13409.18313594719246277144.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Nov 2022 02:54:31 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Fri, 4 Nov 2022 23:14:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74f3f1d79a1d17a319e20eb31d3edd25c03bdd9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
