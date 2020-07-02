Return-Path: <SRS0=gxu9=AN=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E62C433E3
	for <linux-i2c@archiver.kernel.org>; Thu,  2 Jul 2020 17:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E43321534
	for <linux-i2c@archiver.kernel.org>; Thu,  2 Jul 2020 17:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kfthxle0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgGBRMQ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgGBRMP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Jul 2020 13:12:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608BDC08C5C1
        for <linux-i2c@vger.kernel.org>; Thu,  2 Jul 2020 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hur0N5VpFMmM468rLQSCnKTmOlrtSai0qkItfn7CRWk=; b=Kfthxle0FEk7pd724y1qHveQfR
        sdJpKjuapDo5PSA172fvIzxsRAt6Bd+2KaFFmiXG6rHn08cuGyizbIwpkf7d5cTdH8ABqZc7v9X0x
        hoOAfY5S0065hvgTmsMliIzNzxXxU6pkpS7r6kV52x1VUVsfVn0OgvuSDoujxyr2MaSHklloY7uFh
        Yo/WA4vsUvPGK/lDlzyeCoRoMo3vkSG1ghbxB84yFE07X2x0zovViBCPF02WCqXWmgZ3mMpfZ6zSa
        +ZgsBHb8E8K8O9ANHdWU0VRAiHnfHOCNxQ3/V63Vd+DrDbi7y80hYVwA3isHDASZIbm0ay6lrliHG
        9VTtNWhA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr2kt-00086U-SZ; Thu, 02 Jul 2020 17:12:12 +0000
To:     Linux MM <linux-mm@kvack.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Documentation (mm & i2c) questions (doubled words)
Message-ID: <187c35da-041e-dcf3-d14e-7046f57d0606@infradead.org>
Date:   Thu, 2 Jul 2020 10:12:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


for MM:

in Documentation/admin-guide/mm/numaperf.rst:
line 132-133:

  If that directory is not present, the system either does not not provide
  a memory-side cache, or that information is not accessible to the kernel.

Is the double negative done on purpose or is it a typo/mistake?


for I2C:

in Documentation/i2c/upgrading-clients.rst:
line 10-11:

  This guide outlines how to alter existing Linux 2.6 client drivers from
  the old to the new new binding methods.
                 ^^^^^^^

Is this like "really new" or newer than new?  or just a simple mistake?


thanks.

-- 
~Randy

