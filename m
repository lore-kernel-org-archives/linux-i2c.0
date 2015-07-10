From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 0/9] i2c: xiic: cleanups
Date: Fri, 10 Jul 2015 10:43:18 +0530
Message-ID: <CAKfKVtE5qfQjxJNDOBXfVLncVYXJjgfXe6Anb6M=dSFkHsTt8w@mail.gmail.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
	<20150709173501.GE4744@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150709173501.GE4744@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 9, 2015 at 11:05 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Wed, Jun 17, 2015 at 08:48:10PM +0530, Shubhrajyoti Datta wrote:
>> This is a series of cleanups for the axi iic.
>> tested on zc702 and microblaze.
>>
>> Changes from v1
>> Updated the commit message.
>>
>>
>> Shubhrajyoti Datta (9):
>>   i2c: xiic: Remove the disabling of interrupts
>>   i2c: xiic: move the xiic_process to thread context
>>   i2c: xiic: Do not reset controller before every transfer
>>   i2c: xiic: Remove the disabling of interrupts
>>   i2c: xiic: Remove busy loop while waiting for bus busy
>>   i2c: xiic: Add a debug msg in case of timeout
>>   i2c: xiic: Remove the Addressed as slave interrupt
>>   i2c: xiic: Service all interrupts in isr
>>   i2c: xiic: Do not continue in case of errors in Rx
>
> Commit messages are a lot better, thanks!
>
> Two minor comments. If you agree to them, I can simply drop patch 6 and
> fixup patch 2
I agree anyways 2 was like a debug patch.

>. Then, no need for resending.
>
thanks.
