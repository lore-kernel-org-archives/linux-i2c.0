From: Andrew Worsley <amworsley@gmail.com>
Subject: Re: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
Date: Sat, 7 Oct 2017 16:32:29 +1100
Message-ID: <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
References: <20170916030252.10680-1-amworsley@gmail.com> <20171005120125.nnhomwg2e2twbaqm@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:45271 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdJGFcb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 7 Oct 2017 01:32:31 -0400
Received: by mail-ua0-f176.google.com with SMTP id l40so12182565uah.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Oct 2017 22:32:30 -0700 (PDT)
In-Reply-To: <20171005120125.nnhomwg2e2twbaqm@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org

> Thank you for the bug report. I don't know the hardware in detail, but I
> am a bit confused...
>
>> ---
>>   This bug reliably caused a stack corruption when the hardware provided=
 more data than
>> asked for in the i2c request. The hardware (a tpm) very occasionally app=
ends a burst of
>> 0xff to the end of the data requested and the i2c interrupt handler mind=
lessly copies all
>> the data right past the end of the buffer and in my case across the stac=
k. :-(
>
> ... because you as the master should have control over how many bytes
> you want to have. If you are done, send NAK+STOP and the message is
> over. Is it really the device (which one is it BTW?)? Or is the FIFO
> handling of the master driver buggy?
>
> Michal, S=C3=B6ren?

Just a quick comment - as I don't have time at the moment to look
deeply into the driver at the moment.

I was just looking at Ch 20 of the TRM on the i2c under Read Transfer
and it says step 4 write the number of requested bytes to the Transfer
Size Register.

But in the code it talks about a work around for large receive operation.

Looking at the change log: commit  9fae82e1acda

Explains for transfers > 252 bytes that

     "the transfer size register has to be maintained at a value >=3D 1

So my guess is the code is trying to keep this transfer size non-zero
and so just keeps pulling more bytes our of the slave i2c device. I
find it is hard to follow the complex code though.

My buggy condition was a transfer of 128 bytes so it is not hit this
condition except in that the slave supplies way more bytes than was in
the original i2c_transfer request.

Andrew
