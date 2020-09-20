Return-Path: <SRS0=eXcv=C5=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA39C43463
	for <linux-i2c@archiver.kernel.org>; Sun, 20 Sep 2020 01:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358AD2192A
	for <linux-i2c@archiver.kernel.org>; Sun, 20 Sep 2020 01:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600566071;
	bh=3xT2aWSJEjnjVq25OEh/uUDau6fkOa2Fdg5pHaZVTkw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uzfGlmRjO7nhb6WyiQYlfOdlBSNpW8bEB9tuqWYXBghns/GINpsv2yPDoC8C2Goe8
	 cYlfVgPzwODodUwNcd3XV3LASmvHvb4yo4ZFFQTZ+30mh0WgHwce+qlZ3hs60Gkz67
	 fbvs31jzGIVfONPUfrIjSTkCrPSKPh1aA/VTuUQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgITBlK (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 19 Sep 2020 21:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgITBlK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 19 Sep 2020 21:41:10 -0400
Subject: Re: [PULL REQUEST] i2c for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600566070;
        bh=3xT2aWSJEjnjVq25OEh/uUDau6fkOa2Fdg5pHaZVTkw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XEWsvUVDX95DwU4EjOwo8ADdPYGcY/3dmhmzQ8qaPdW9RAA7FNQswHjf51kkghd/z
         TvfJScqG9sAxybtnj7zwHv6uuzce3tyJfQAP/rgmCSbAngP1cBVb8ZSIih+PgT66jx
         oO4kT3TRS0nTeMXH6MNhChfYs8kPi22X4tP4oSfI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200919160206.GA50781@kunai>
References: <20200919160206.GA50781@kunai>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200919160206.GA50781@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 6eb158ec0a45dbfd98bc6971c461b7d4d5bf61b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8d1a46f943877c08d1154a6f90f43a245a671cf
Message-Id: <160056607014.29516.9459722962297050710.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 01:41:10 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sat, 19 Sep 2020 18:02:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8d1a46f943877c08d1154a6f90f43a245a671cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
