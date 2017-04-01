From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH 1/3] usb: pci-quirks: Add a header for SB800 I/O ports and
 mutex for locking
Date: Sat, 1 Apr 2017 17:09:46 +0200
Message-ID: <6824761e-787b-e92b-6944-281ed73b9947@pr.hu>
References: <Pine.LNX.4.44L0.1704011039140.6983-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:43543 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdDAPJ7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 1 Apr 2017 11:09:59 -0400
In-Reply-To: <Pine.LNX.4.44L0.1704011039140.6983-100000@netrider.rowland.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

2017-04-01 16:40 keltezéssel, Alan Stern írta:
> On Sat, 1 Apr 2017, Greg KH wrote:
>
>> On Sat, Apr 01, 2017 at 01:02:21PM +0200, Zoltan Boszormenyi wrote:
>>> From: B�sz�rm�nyi Zolt�n <zboszor@pr.hu>
>>>
>>> This patch adds:
>>> * a mutex in the USB PCI quirks code for synchronizing access to
>>>   the I/O ports on SB800
>>> * a new header that contains symbols for the index and data I/O ports
>>>   and wrappers for locking and unlocking the mutex.
>>> * locking around the I/O port access for SB800
>>>
>>> Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>
>>> ---
>
>>> diff --git a/include/linux/sb800.h b/include/linux/sb800.h
>>> new file mode 100644
>>> index 0000000..5650b7d
>>> --- /dev/null
>>> +++ b/include/linux/sb800.h
>>> @@ -0,0 +1,15 @@
>>> +
>>> +#ifndef SB800_H
>>> +#define SB800_H
>>> +
>>> +#include <linux/mutex.h>
>>> +
>>> +#define SB800_PIIX4_SMB_IDX		0xcd6
>>> +#define SB800_PIIX4_SMB_DATA	0xcd7
>>> +
>>> +extern struct mutex sb800_mutex;
>>> +
>>> +#define enter_sb800()	mutex_lock(&sb800_mutex)
>>> +#define leave_sb800()	mutex_unlock(&sb800_mutex)
>
> Is include/linux/ the best place for this new header file?  Aren't
> there other locations more suitable for something that's
> board-specific?

Are there? Which subdirectory is better suited?

Would it be acceptable to not use a header at all but spell out
the "extern struct mutex..." in the two other drivers?

Thanks,
Zoltán Böszörményi

>
> Alan Stern
>
>> Don't hide the mutex, just spell it out in the code itself.  No need for
>> these defines at all.
>>
>> thanks,
>>
>> greg k-h
>
>
