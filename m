Return-Path: <SRS0=5ehF=CH=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB166C433E6
	for <linux-i2c@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3BF20BED
	for <linux-i2c@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598732258;
	bh=3gX8PbABC9XMJuWAdbhiN+L6Y0zXbO5AdREcxcGHaaM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FLCrR7obWCv3L52MNsaCiU5XSrjdX7aozXPzHaGIBjWx4B1geHe0lLfZjgS/QjuFT
	 MHl1i6roI9y2aD7AEpI/Wp6zRTflmcXb0/Pzh5YzT0VksGqz0cticxiyBPycG5OEly
	 ugz9VxmJPT802lF2xI9EZ6bohNR3h2fwBjGCFzPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgH2URc (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 29 Aug 2020 16:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbgH2UR2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 29 Aug 2020 16:17:28 -0400
Subject: Re: [PULL REQUEST] i2c for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598732247;
        bh=3gX8PbABC9XMJuWAdbhiN+L6Y0zXbO5AdREcxcGHaaM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rKZedwBMw5i9TXu9mpIJ+7boe4ojf8cSBKF6DWyQji0XGfvXfB2KCWKBA9fMdDoGp
         EE0ELo5/Bkm1lHcGbvWWsu1FDwX4c8IG8Hb5tjxD2QKLk2m3/qqbXypNDS9DGb1kjQ
         glAdw75k1h28zCyWN/Lfppa/kHt8M+skv9IsFhS8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200829155302.GA1147@ninjato>
References: <20200829155302.GA1147@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200829155302.GA1147@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 0204081128d582965e9e39ca83ee6e4f7d27142b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e77aee1326f7691763aa968eee2f57db37840b9d
Message-Id: <159873224764.9079.15649305978201724021.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Aug 2020 20:17:27 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Sat, 29 Aug 2020 17:53:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e77aee1326f7691763aa968eee2f57db37840b9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
