From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: entering the error case of i2c-designware with a timeout at probe
Date: Tue, 21 Mar 2017 14:01:35 +0100
Message-ID: <657693b0-ea33-0927-752a-8e58f7c062f5@redhat.com>
References: <1490100731.8154.13.camel@suse.com>
 <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757018AbdCUNDE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 09:03:04 -0400
In-Reply-To: <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Max Staudt <mstaudt@suse.de>, Oliver Neukum <ONeukum@suse.com>
Cc: linux-i2c@vger.kernel.org

Hi,

On 21-03-17 13:57, Max Staudt wrote:
> On 03/21/2017 01:52 PM, Oliver Neukum wrote:
>> Hi Hans,
>>
>> we found on our test systems with a bit of experimentation,
>> that actually running into the timeout is bound to hang the whole
>> system within only a few seconds.
>> I was wondering whether the error handling needs to be changed.
>
> In other words, whether we should rather wait for lock acquisition,
> unconditionally. No timeout, just wait. That's what our hardware
> seems to need.
>
> It feels like once the lock has been requested by the Linux driver,
> we can't cancel that request and have to actually follow through
> with accepting the lock and only giving it back after that.
> Resetting the "request" bit to 0 as it is done now doesn't work as
> it leads to the hung system sometime soon after that.

Hmm, interesting theory. I would say give it a test and if it
helps then maybe increase the timeouts to say 10 seconds or
such, so that e.g. on poweroff we at least report an error
rather then just sitting there ?

Regards,

Hans
