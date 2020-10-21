Return-Path: <SRS0=tB9S=D4=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094BEC56201
	for <linux-i2c@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F2821531
	for <linux-i2c@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603305317;
	bh=e2NLkuyBpcXhWTlPh5+YBnFzTxwWuo6JKJ79+VXSGyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=psnX1yV6Jhv7xQsi2k9BO28n1J10LrOpnfuaTGB/c2sQ2b7Sem31QoNQKpcdKwAb8
	 PNeTbM2EAKPUiryvinqzMR5Ft0wjVeZTlzzyNgKFe4y2VimlTbaalR1qNbMJ7adYke
	 ABdF6NXLba2gAxmHe3W24i5AP5YPAQiXEZYGT+u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504207AbgJUSfQ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504197AbgJUSfN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Oct 2020 14:35:13 -0400
Subject: Re: [PULL REQUEST] i2c for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603305312;
        bh=e2NLkuyBpcXhWTlPh5+YBnFzTxwWuo6JKJ79+VXSGyI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uLVg4I4ubMbe4qQC3PubxAGBI7QM0HemA1lRbhpbaNLGYFA4w6o4jP5aaEnbF8vnO
         XnD2KHpOq21SCpQos0e41f04Hp6zoZzRg8+saQk/PKX5fA4e4ZgzAh8rIhEQmTPWyV
         IEgW84PNlslTXUwu5LUoKOSNuyEVTTlP1bmUdurw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201021065500.GA1429@kunai>
References: <20201021065500.GA1429@kunai>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201021065500.GA1429@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.10
X-PR-Tracked-Commit-Id: 40daf09a30a0c86a038bcce606604333f32e03f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5df4b5c28b232d1fc0b48660f44668faebb0bcb
Message-Id: <160330531244.16606.10528830189726508684.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Oct 2020 18:35:12 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The pull request you sent on Wed, 21 Oct 2020 08:55:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5df4b5c28b232d1fc0b48660f44668faebb0bcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
