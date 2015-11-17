From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 3/3] i2c: xiic: Replace spinlock with mutex
Date: Tue, 17 Nov 2015 10:50:21 +0530
Message-ID: <CAKfKVtFo8FoNAQHMgg1yV+xm-8xK8uuSeUr32cS2psH-G763cA@mail.gmail.com>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>
	<1447681325-30914-3-git-send-email-lars@metafoo.de>
	<CAKfKVtGDe+SYx7wmtNtkvDCA9_Ham0Rt9Q4g=6pk3M57GKvrpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36772 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbbKQFUW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Nov 2015 00:20:22 -0500
Received: by qkda6 with SMTP id a6so52343505qkd.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2015 21:20:21 -0800 (PST)
In-Reply-To: <CAKfKVtGDe+SYx7wmtNtkvDCA9_Ham0Rt9Q4g=6pk3M57GKvrpA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org

On Tue, Nov 17, 2015 at 10:48 AM, Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
> On Mon, Nov 16, 2015 at 7:12 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> All protected sections are only called from sleep-able context, so there is
>> no need to use a spinlock.
>
> Looks good to me. Feel free to add my reviewed by.

Reviewed-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
