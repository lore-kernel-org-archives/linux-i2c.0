From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] i2c: cadence: Move to sensible power management
Date: Wed, 28 Oct 2015 11:38:57 +0530
Message-ID: <CAM=Q2cuv+ifK=-ttiOs6jnf5zOHowfVi4oJvWJ4itjGqOkeOgQ@mail.gmail.com>
References: <1444912015-6912-1-git-send-email-shubhraj@xilinx.com>
	<20151025154035.GA23308@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34060 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbJ1GI6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Oct 2015 02:08:58 -0400
Received: by igpw7 with SMTP id w7so21669686igp.1
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2015 23:08:57 -0700 (PDT)
In-Reply-To: <20151025154035.GA23308@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Linux-I2C <linux-i2c@vger.kernel.org>, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Sun, Oct 25, 2015 at 9:10 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Oct 15, 2015 at 05:56:55PM +0530, Shubhrajyoti Datta wrote:
>> Currently the clocks are enabled at probe and disabled at remove.
>> Which keeps the clocks enabled even if no transaction is going on.
>> This patch enables the clocks at the start of transfer and disables
>> after it.
>>
>> Also adapts to runtime pm.
>> Remove xi2c->suspended and use pm runtime status instead.
>>
>> converts dev pm to const to silence a checkpatch warning.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
>
> Can you resend please with the driver maintainers in cc? Best use
> get_maintainer.pl to create the CC list. Thanks!
>
Just resent it with updated cc list.
Thanks
