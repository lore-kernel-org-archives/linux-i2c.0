From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH] i2c: ocores: Add missing wake_up() call upon state change to STATE_DONE
Date: Mon, 26 Jun 2017 23:30:13 +0200
Message-ID: <87efu6fndm.fsf@dell.be.48ers.dk>
References: <20170616092317.584-1-sr@denx.de>
        <87a858hz71.fsf@dell.be.48ers.dk>
        <7319c512-4301-8a33-5fc3-62486557a883@denx.de>
        <871sqkhxm4.fsf@dell.be.48ers.dk>
        <df9d294c-357f-788a-5213-b229d4c3c5c1@denx.de>
        <20170623182949.xfag5smjvq6cbamy@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34057 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdFZVaQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Jun 2017 17:30:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id f134so2555072wme.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Jun 2017 14:30:16 -0700 (PDT)
In-Reply-To: <20170623182949.xfag5smjvq6cbamy@ninjato> (Wolfram Sang's message
        of "Fri, 23 Jun 2017 20:29:49 +0200")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Stefan Roese <sr@denx.de>, linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa@the-dreams.de> writes:

 >> After updating to the latest version from OpenCores, the issue
 >> with the missing interrupt seems to be resolved. So this patch
 >> can be dropped.

 > Thanks for the heads up and thanks to Peter for looking into this issue!

Great, thanks both!

-- 
Bye, Peter Korsgaard
