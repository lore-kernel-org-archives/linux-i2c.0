From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: cadence: Handle > 252 byte transfers
Date: Tue, 13 Jan 2015 22:47:20 +0530
Message-ID: <CAFcVECK5PmvmHpGmtVdyc=rrv7bj97bjR5LuZQoehVhgn3Xbxw@mail.gmail.com>
References: <1418357907-4215-1-git-send-email-harinik@xilinx.com>
	<1418357907-4215-2-git-send-email-harinik@xilinx.com>
	<20150113112854.GA7660@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150113112854.GA7660@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Jan 13, 2015 at 4:58 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Fri, Dec 12, 2014 at 09:48:26AM +0530, Harini Katakam wrote:
>> The I2C controller sends a NACK to the slave when transfer size register
>> reaches zero, irrespective of the hold bit. So, in order to handle transfers
>> greater than 252 bytes, the transfer size register has to be maintained at a
>> value >= 1. This patch implements the same.
>> The interrupt status is cleared at the beginning of the isr instead of
>> the end, to avoid missing any interrupts.
>>
>> Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>
> Applied to for-next, thanks!
>
>> @@ -333,10 +359,11 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>>        * receive if it is less than transfer size and transfer size if
>>        * it is more. Enable the interrupts.
>>        */
>> -     if (id->recv_count > CDNS_I2C_TRANSFER_SIZE)
>> +     if (id->recv_count > CDNS_I2C_TRANSFER_SIZE) {
>>               cdns_i2c_writereg(CDNS_I2C_TRANSFER_SIZE,
>>                                 CDNS_I2C_XFER_SIZE_OFFSET);
>> -     else
>> +             id->curr_recv_count = CDNS_I2C_TRANSFER_SIZE;
>> +     } else
>>               cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
>
> else branch must have braces, too! I fixed that.

Thanks!

Regards,
Harini
