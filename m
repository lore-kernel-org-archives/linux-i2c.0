Return-Path: <SRS0=Bob0=CF=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7745C433DF
	for <linux-i2c@archiver.kernel.org>; Thu, 27 Aug 2020 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00D02074A
	for <linux-i2c@archiver.kernel.org>; Thu, 27 Aug 2020 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgH0IlX (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:41:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:58062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH0IlX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 27 Aug 2020 04:41:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F26A3B5E1
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2020 08:41:53 +0000 (UTC)
Date:   Thu, 27 Aug 2020 10:41:21 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH] decode-dimms: Update the list of vendors to Jedec
 JEP106BB
Message-ID: <20200827104121.5c2cd412@endymion>
In-Reply-To: <20200804082543.1d22b28f@endymion>
References: <20200804082543.1d22b28f@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, 4 Aug 2020 08:25:43 +0200, Jean Delvare wrote:
> Update the list of memory vendors as of June 2020, including 14
> renames.
> 
> I also added a runtime sanity check on the number of vendors per
> page, as it is very easy to get it wrong.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
> As suggested by Paul Goyette.
> 
>  eeprom/decode-dimms |  111 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 95 insertions(+), 16 deletions(-)
> (...)

Applied.

-- 
Jean Delvare
SUSE L3 Support
