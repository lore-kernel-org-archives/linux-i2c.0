From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCHv3 2/2] i2c: cadence: Implement save restore
Date: Sat, 12 Mar 2016 22:53:26 +0530
Message-ID: <CAKfKVtH2ayu=sEvkSpi0oRjacUDMqeQ4R+10=9i6Ho2xaV+VuA@mail.gmail.com>
References: <1456984240-17389-1-git-send-email-shubhraj@xilinx.com>
	<1456984240-17389-2-git-send-email-shubhraj@xilinx.com>
	<20160303204013.GC1711@katana>
	<CAKfKVtG5sC7+2Gsq60irZAYgof1guqWTg=YCN+63xJV=tfmowg@mail.gmail.com>
	<20160312150236.GA1661@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34227 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcCLRX2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 12 Mar 2016 12:23:28 -0500
Received: by mail-qg0-f52.google.com with SMTP id w104so123172573qge.1
        for <linux-i2c@vger.kernel.org>; Sat, 12 Mar 2016 09:23:27 -0800 (PST)
In-Reply-To: <20160312150236.GA1661@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org, anirudh@xilinx.com, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Sat, Mar 12, 2016 at 8:32 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> >> zynq-mp has the capability of going off.
>> >> the current kernel does not hit off however some day it will.
>> >> since the overhead of having the support is not much may be it is better to have it in the kernel.
>> >
>> > This sounds like the patch is not tested?
>> to simulate the suspend behavior I  did a reset of the module by writing to
>> slcr register.
>> And then did a transfer.
>
> I'd prefer a patch which is tested under the actual condition. So, let's
> wait until proper suspend support is added.
>

Makes sense.
thanks,
Shubhrajyoti
