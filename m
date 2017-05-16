From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: fix "failed to add mux-adapter" message
Date: Tue, 16 May 2017 13:10:18 +0200
Message-ID: <ca76f485-c69f-169c-132d-cb6ec1afde0e@axentia.se>
References: <E1dAaIY-0005jy-Tc@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:2496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751139AbdEPLKY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 May 2017 07:10:24 -0400
In-Reply-To: <E1dAaIY-0005jy-Tc@rmk-PC.armlinux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 2017-05-16 13:05, Russell King wrote:
> i2c-mux always prints the "failed to add mux-adapter" message even when
> the mux adapter is successfully registered.  Fix this.

Yes, sorry about that. However, a similar fix [1] is already queued.

Cheers,
peda

[1] https://lkml.org/lkml/2017/5/15/62
