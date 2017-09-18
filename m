From: Jan Kandziora <jjj@gmx.de>
Subject: Re: [PATCH v4 1/2] wire: export w1_touch_bit
Date: Mon, 18 Sep 2017 21:34:27 +0200
Message-ID: <642d1ff1-57ff-71ee-a516-c6028dd1d1c2@gmx.de>
References: <20170918130346.3886-1-jjj@gmx.de>
 <20170918141929.GA10178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:60444 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbdIRTed (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 18 Sep 2017 15:34:33 -0400
In-Reply-To: <20170918141929.GA10178@kroah.com>
Content-Language: de-DE
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: GregKH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, Linux-I2C <linux-i2c@vger.kernel.org>

Am 18.09.2017 um 16:19 schrieb GregKH:
> On Mon, Sep 18, 2017 at 03:03:45PM +0200, Jan Kandziora wrote:
>> The w1_ds28e17 driver from the next part of this patch needs to emit
>> single-bit read timeslots to the DS28E17. The w1 subsystem already
>> has this function but it is not exported outside drivers/w1/w1_io.c
>>
>> This subpatch exports the w1_touch_bit symbol with EXPORT_SYMBOL_GPL,
>> same as the other exported symbols in drivers/w1/w1_io.c
>>
>> May be also useful later for writing drivers for other Onewire chips
>> which do single-bit communication.
>>
>> Signed-off-by: Jan Kandziora <jjj@gmx.de>
>> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
>> ---
>> Changes in v4 against v3 in this subpatch:
>>   - adapted to linux-4.12.0
>>
>> No changes in v3 against v2,v1 in this subpatch.
> 
> You should change it as it does not apply to 4.14-rc1 :(
> 
Okay, I will review them again.


> Please rebase your patches and resend them, with Evgeniy's acks added to
> them.
> 
Now you caught me. I don't know how to do that. What's required? The
Acked-by: line? Am I allowed to simply add these lines to my patches or
is there a procedure to follow?

Kind regards

	Jan
