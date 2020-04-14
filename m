Return-Path: <SRS0=NIKx=56=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15BC2BA19
	for <linux-i2c@archiver.kernel.org>; Tue, 14 Apr 2020 07:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B392072D
	for <linux-i2c@archiver.kernel.org>; Tue, 14 Apr 2020 07:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406695AbgDNHfj (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:35:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406685AbgDNHff (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 14 Apr 2020 03:35:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A6A32ADCD;
        Tue, 14 Apr 2020 07:35:33 +0000 (UTC)
Date:   Tue, 14 Apr 2020 09:35:33 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Adam Honse <calcprogrammer1@gmail.com>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: Detect secondary SMBus controller on AMD AM4
 chipsets
Message-ID: <20200414093533.23eaf644@endymion>
In-Reply-To: <20200410204843.3856-1-calcprogrammer1@gmail.com>
References: <20200410204843.3856-1-calcprogrammer1@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Ah, one thing I forgot: subject line should start with "i2c: piix4: "
so that it is clear which driver is affected.

-- 
Jean Delvare
SUSE L3 Support
