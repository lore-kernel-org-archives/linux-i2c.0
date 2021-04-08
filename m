Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9830C43460
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Apr 2021 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7670661107
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Apr 2021 22:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhDHWNz (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWNz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Apr 2021 18:13:55 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E346C061760;
        Thu,  8 Apr 2021 15:13:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 09DD7FF95A;
        Thu,  8 Apr 2021 22:13:38 +0000 (UTC)
Date:   Fri, 9 Apr 2021 00:13:35 +0200
From:   Max Staudt <max@enpas.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] i2c: icy: Constify the software node
Message-ID: <20210409001335.2d3b9484.max@enpas.org>
In-Reply-To: <20210408212251.GJ1900@kunai>
References: <20210329105047.51033-1-heikki.krogerus@linux.intel.com>
        <20210329105047.51033-10-heikki.krogerus@linux.intel.com>
        <20210330155856.3cf32fce.max@enpas.org>
        <20210408212251.GJ1900@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, 8 Apr 2021 23:22:51 +0200
Wolfram Sang <wsa@kernel.org> wrote:

> I read this as "Reviewed-by" ;)

Sure, why not :)


Reviewed-by: Max Staudt <max@enpas.org>
