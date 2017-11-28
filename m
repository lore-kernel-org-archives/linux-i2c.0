From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 0/2] ARM: pxa: move pxa-i2c.h to platform_data
Date: Tue, 28 Nov 2017 22:50:44 +0100
Message-ID: <87indu6pjf.fsf@belgarion.home>
References: <20171113172739.1996-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:37857 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdK1Vur (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Nov 2017 16:50:47 -0500
In-Reply-To: <20171113172739.1996-1-wsa@the-dreams.de> (Wolfram Sang's message
        of "Mon, 13 Nov 2017 18:27:37 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

> As discussed previously, we move the declarations now to devices.h and the
> platform_data to the platform_data directory. Only build tested, but buildbot
> is happy (this time really!)

Applied to pxa/for-next now the merge window is close.

Cheers.
