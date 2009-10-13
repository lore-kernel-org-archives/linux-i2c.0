From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [RFC] i2c-designware patches
Date: Tue, 13 Oct 2009 16:27:24 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D744B@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Shinya Kuribayashi
Sent: Tuesday, October 13, 2009 3:01 AM
To: Baruch Siach
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: Re: [RFC] i2c-designware patches

Baruch Siach wrote:
> On Tue, Oct 13, 2009 at 11:44:04AM +0900, Shinya Kuribayashi wrote:
>> Here're various improvements / bug-fixing patches for DW I2C driver.
>> I'm working with v2.6.27-based kernel, but they must work fine with 
>> the latest mainline kernel.
>>
>> It's stil in RFC, and I'm working with it for some time.  Any 
>> comments or suggestions are highly appreciated.  Then I'll respin and 
>> give it a test, thanks.
>>
>> Baruch, I'd say the base driver is in good shape enogh, so I'm having 
>> a fun with modifing the driver.  Thanks for the initial work.
> 
> Thanks. It is good to see that my work is actually useful for someone. 
> I'll go over this series in the coming days. Unfortunately I don't 
> have the hardware for testing anymore, but I'll try at least to compile test these patches.

No problem, I could do real tests on real hardwares, so just give me a feedback.  Grammar corrections or rewording is also appriciated.

> By the way, what is the chip you work with?

I'd like to avoid specific comment on this.  I'm working with our big- endian MIPS SoCs which are not in mainline.

--
Shinya Kuribayashi
NEC Electronics
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
