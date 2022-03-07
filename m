Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB4C433EF
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Mar 2022 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiCGP63 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiCGP61 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2022 10:58:27 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41165E8
        for <linux-i2c@vger.kernel.org>; Mon,  7 Mar 2022 07:57:31 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0CBCA2223A;
        Mon,  7 Mar 2022 16:57:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646668648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GSOT05dXLjMtVZBRCBZTtJfzJ22kZt/Hr0FiXRWTF/o=;
        b=IpngHDsQpR+R4es4Vh0Pao8ZPNWr68X0opKb4Vo5m/v8q0o5Y3V+pNhSIBrJqMW87RFt49
        WdK4bq0eUmI6Khf97b7AW2aIBzUktHCSCBqHGWqneo12TCSTAOjnUT99mILu6G+TAiFSZ1
        Ypxu9e3JZxQo8pZ4jtqhWYkCoYgnN1g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Mar 2022 16:57:27 +0100
From:   Michael Walle <michael@walle.cc>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     linux-i2c@vger.kernel.org
Subject: wrong assumption in i2c-at91-master.c ?
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <591de05fde401e8899726e015b837cd1@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

I saw that the at91 i2c driver has some kind of heuristic in
at91_twi_xfer(). It assumes that if there are exactly two
messages to transfer, the first is the address write of a
common i2c write address, read data transaction. I don't
think that assumption is correct.

Also there is no check if msg->len is actually smaller
than the width of the address which can be written to
AT91_TWI_IADR.

I think, what is at least missing is that, the first
one is actually a write and have at max 3 bytes (IIRC
thats the max width of AT91_TWI_IADR).

Actually, I don't find any code at all which would
handle multiple messages. Looks like it just supports
num == 2 (and assumes the first message fits into the
AT91_TWI_IADR) and num == 1.

-michael
