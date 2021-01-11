Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D6BC433E6
	for <linux-i2c@archiver.kernel.org>; Mon, 11 Jan 2021 09:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74AEC224F9
	for <linux-i2c@archiver.kernel.org>; Mon, 11 Jan 2021 09:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbhAKJ1D (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 11 Jan 2021 04:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbhAKJ1D (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 11 Jan 2021 04:27:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63ECF224F9;
        Mon, 11 Jan 2021 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610357182;
        bh=3b4PJBOuTYQGc9w9iCrEybfn6cP80nyQRBWRqUVFi/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uD40Kv/c2eWlfY7bVePNmO/nRiWoys2NZ8o5ecTpDk16FWjvXgUeVL1Le80GoodS5
         F30pQG45wwZ+bSsXETqrWq1DTcIzFtyUUqJ5ep2XINtvUMaaSp6Ofgk65OZEKjn1tv
         RGMX4MxDQBxi5WaDw5BCcUN3YRP/1/+wB8DMmSe1OL+Aq4nfP92c3z4R114/PNcY1+
         TinWZcDXTJ/QE4l1KRYkowLvmcJL2rBf+ShDih7rzlteqNYmRl/DkjnlB4eKwe5ftB
         7+g05J0kG2vo9AzeiWbSi5biKqjD3ABXt5jrYCCuvdTa8yq4lpYPNqSjd7oxCa0pQv
         wolF6KpyFTOng==
Date:   Mon, 11 Jan 2021 10:26:18 +0100
From:   Robert Richter <rric@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jan Glauber <jan.glauber@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] i2c: octeon: check correct size of maximum RECV_LEN
 packet
Message-ID: <X/wZupAp0Gr/uDNv@rric.localdomain>
References: <20210109124314.27466-1-wsa+renesas@sang-engineering.com>
 <20210109124314.27466-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109124314.27466-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 09.01.21 13:43:08, Wolfram Sang wrote:
> I2C_SMBUS_BLOCK_MAX defines already the maximum number as defined in the
> SMBus 2.0 specs. No reason to add one to it.
> 
> Fixes: 886f6f8337dd ("i2c: octeon: Support I2C_M_RECV_LEN")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Robert Richter <rric@kernel.org>
