Return-Path: <SRS0=Z3tm=BR=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC3C433DF
	for <linux-i2c@archiver.kernel.org>; Fri,  7 Aug 2020 09:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DA220748
	for <linux-i2c@archiver.kernel.org>; Fri,  7 Aug 2020 09:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHGJky (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:40:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHGJkx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 7 Aug 2020 05:40:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B539DAF70;
        Fri,  7 Aug 2020 09:41:09 +0000 (UTC)
Date:   Fri, 7 Aug 2020 11:40:51 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH i2c-tools] tools: allow to preset TOOLS_CFLAGS and
 TOOLS_LDFLAGS
Message-ID: <20200807114051.099ee040@endymion>
In-Reply-To: <20200805220555.9050-1-wsa@kernel.org>
References: <20200805220555.9050-1-wsa@kernel.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu,  6 Aug 2020 00:05:55 +0200, Wolfram Sang wrote:
> Sometimes I need to add some flags (like -static for the linker), so
> allow this.

Does USE_STATIC_LIB=1 not work for you?

> 
> Signed-off-by: Wolfram Sang <wsa@kernel.org>
> ---
> 
> Jean, what do you think?

Fine with me. However for consistency I think it would make sense to do
the same in eeprog/Module.mk and lib/Module.mk?

-- 
Jean Delvare
SUSE L3 Support
