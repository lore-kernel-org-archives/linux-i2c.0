Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756C0C433B4
	for <linux-i2c@archiver.kernel.org>; Thu, 15 Apr 2021 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F2B61042
	for <linux-i2c@archiver.kernel.org>; Thu, 15 Apr 2021 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhDOUht (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhDOUhs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Apr 2021 16:37:48 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F284C061574;
        Thu, 15 Apr 2021 13:37:24 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX8jn-005aeZ-QE; Thu, 15 Apr 2021 20:37:19 +0000
Date:   Thu, 15 Apr 2021 20:37:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bence =?iso-8859-1?B?Q3Pza+Fz?= <bence98@sch.bme.hu>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix 'assignment to __be16' warning
Message-ID: <YHij/89HZXdFed5V@zeniv-ca.linux.org.uk>
References: <20210412115302.95686-1-bence98@sch.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412115302.95686-1-bence98@sch.bme.hu>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, Apr 12, 2021 at 11:53:02AM +0000, Bence Csókás wrote:
> While the preamble field _is_ technically big-endian, its value is always 0x2A2A,
> which is the same in either endianness, therefore it should be u16 instead.

Just replace the assignment with htons(0x2A2A) and be done with that - it's
a constant expression and compiler will yield the same assembler.
