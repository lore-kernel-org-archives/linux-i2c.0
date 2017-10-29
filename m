From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
Date: Sun, 29 Oct 2017 21:34:00 +0100
Message-ID: <87y3ntlmmf.fsf@belgarion.home>
References: <20170814164303.2383-1-wsa@the-dreams.de>
        <87d15qlq6z.fsf@belgarion.home>
        <20171029175257.dfmf5642zfszoxe3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:25101 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdJ2UeK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 29 Oct 2017 16:34:10 -0400
In-Reply-To: <20171029175257.dfmf5642zfszoxe3@ninjato> (Wolfram Sang's message
        of "Sun, 29 Oct 2017 18:52:57 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Marek Vasut <marek.vasut@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

Hi Wolfram,

> Wouldn't it be even cleaner if patch 1 & 2 above would be swapped? First
> move the chunk, then rename the file?
Yeah sure.

> And is there a branch I should base this on? Currently, I am thinking of
> basing this patch on for-next and then submit it around rc1 time.
>
> Does that make sense to you?
Yeah that's good. I usually make my pull requests around -rc5, that gives enough
time to review and test on my side.

As for the base, for-next is exactly pxa/for-next as no patches are pending, so
go ahead and base your work on it please.

Cheers.

-- 
Robert
