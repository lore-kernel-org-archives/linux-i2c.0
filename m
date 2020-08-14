Return-Path: <SRS0=X2RG=BY=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22045C433DF
	for <linux-i2c@archiver.kernel.org>; Fri, 14 Aug 2020 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDAB204EA
	for <linux-i2c@archiver.kernel.org>; Fri, 14 Aug 2020 16:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHNQvB (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:51:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54040 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgHNQvA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 14 Aug 2020 12:51:00 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1k6cuw-009PrL-MP; Fri, 14 Aug 2020 18:50:58 +0200
Date:   Fri, 14 Aug 2020 18:50:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mohammed Billoo <mab@mab-labs.com>
Cc:     peter@korsgaard.com, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: ocores: add be/le support for gaisler
Message-ID: <20200814165058.GC2239279@lunn.ch>
References: <20200814163134.29493-1-mab@mab-labs.com>
 <20200814163134.29493-2-mab@mab-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814163134.29493-2-mab@mab-labs.com>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, Aug 14, 2020 at 12:31:34PM -0400, Mohammed Billoo wrote:
> Add be/le accessors for grlib (as is done for the standard ocore
> accessors).

I thought PCI standardised the endianness of the bus? So long as you
use the right wrappers, it should not matter what the endianness of
the CPU is.

    Andrew
