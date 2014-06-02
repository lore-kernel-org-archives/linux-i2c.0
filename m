From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Add block read functionality for IPMI
Date: Mon, 2 Jun 2014 12:29:55 -0400
Message-ID: <538CA683.40108@ti.com>
References: <1398970186-12204-1-git-send-email-m-karicheri2@ti.com> <537DD6B1.9010200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <537DD6B1.9010200-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Garrett Ding <g-ding-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 5/22/2014 6:51 AM, Sekhar Nori wrote:
> On Friday 02 May 2014 12:19 AM, Murali Karicheri wrote:
>> Intelligent Plaform Management Interface (IPMI) requires I2C driver
>> to support block read, where the first byte received from slave is
>> the length of following data:-
>>   Added length check if the read type is block read (I2C_M_RECV_LEN)
>>   Send NACK/STOP bits before last byte is received
>>
>> Signed-off-by: Garrett Ding <g-ding-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> I tested this on a DA850 using i2cdetect and it did not seem to break
> anything so:
>
> Tested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>
> There are some checks that were triggered in checkpatch. You may want
> to fix them up.
>
> Thanks,
> Sekhar
>
> CHECK: Alignment should match open parenthesis
> #112: FILE: drivers/i2c/busses/i2c-davinci.c:557:
> +					w = davinci_i2c_read_reg(dev,
> +							DAVINCI_I2C_MDR_REG);
>
> CHECK: Alignment should match open parenthesis
> #115: FILE: drivers/i2c/busses/i2c-davinci.c:560:
> +					davinci_i2c_write_reg(dev,
> +							DAVINCI_I2C_MDR_REG, w);
>
> CHECK: Alignment should match open parenthesis
> #119: FILE: drivers/i2c/busses/i2c-davinci.c:564:
> +					davinci_i2c_write_reg(dev,
> +							DAVINCI_I2C_MDR_REG, w);
>
> total: 0 errors, 0 warnings, 3 checks, 67 lines checked
>
Sekhar,

Thanks for testing this. I have other comments against this patch and 
will be sending an
updated patch in few weeks.

Thanks and regards,

Murali
