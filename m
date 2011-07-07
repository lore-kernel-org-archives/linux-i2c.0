From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Thu, 07 Jul 2011 08:43:19 +0200
Message-ID: <4E155587.1070905@gmx.de>
References: <13595453.330.1309984221608.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13595453.330.1309984221608.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Tim Nelson said the following:
> ----- Original Message -----
>> >
>> > Correct, and we have support for this device. Driver is named
>> > scx200_acb. Load it and then "i2cdetect -l" should list the SMBus.
>> >
>> 
>> YES! The SMBus is now detected. I'll continue working with the i2c
>> toolset further.
>> 
> 
> I think I'm *closer* to working with this chip, but not quite there yet!
...
> root@aaa:~# i2cget -y 0 0x19 0x8h
                                  A
                                  +-------------+
                                                |
I can't state to know what you are doing, but this ('h') does not look
correct.

HTH
-- 
KR Michael
