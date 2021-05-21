Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01707C433B4
	for <linux-i2c@archiver.kernel.org>; Fri, 21 May 2021 10:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B34613B6
	for <linux-i2c@archiver.kernel.org>; Fri, 21 May 2021 10:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhEUK5Q (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 21 May 2021 06:57:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:45652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhEUK5Q (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 21 May 2021 06:57:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B203AAACA;
        Fri, 21 May 2021 10:55:52 +0000 (UTC)
Date:   Fri, 21 May 2021 12:55:51 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     michael.asher@omron.com
Cc:     linux-i2c@vger.kernel.org
Subject: Re: make file missing ?
Message-ID: <20210521125551.2d3019e7@endymion>
In-Reply-To: <OSAPR01MB3204BE31C15A2C49AA9BACF1E0479@OSAPR01MB3204.jpnprd01.prod.outlook.com>
References: <OSAPR01MB3204BE31C15A2C49AA9BACF1E0479@OSAPR01MB3204.jpnprd01.prod.outlook.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Michael,

On Wed, 21 Apr 2021 14:33:47 +0000, michael.asher@omron.com wrote:
> Build instructions say,
> "There's no configure script, so simply run "make" to build the library and tools"
> 
> However, upon downloading the *.tar, I found no make file.  I found a Module.mk.  Being a bit of a noob, I do not know how to proceed.

Which tarball, downloaded from which location?

# wget https://mirrors.edge.kernel.org/pub/software/utils/i2c-tools/i2c-tools-4.2.tar.xz
# tar -xf i2c-tools-4.2.tar.xz
# cd i2c-tools-4.2
# ls -g Makefile
-rw-r--r-- 1 users 1376 Sep 22  2020 Makefile

So the Makefile is definitely there. Module.mk files exist as well, in
different sub-directories, and they contain the actual build commands.
They are actually in Makefile format as well, but aren't
self-sufficient. The Makefile at the root of the project defines the
build settings and then glues all the individual Module.mk files
together in order to build the whole package.

Hope that helps,
-- 
Jean Delvare
SUSE L3 Support
