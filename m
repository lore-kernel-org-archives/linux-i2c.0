From: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Fri, 24 Dec 2010 17:14:09 +0100
Message-ID: <4D14C6D1.3030802@uib.cat>
References: <4D0B9C35.5000802@uib.cat> <AANLkTi=LQ56S43=BL8tdo=MakP-PRzVK0ieJM07y_O_1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=LQ56S43=BL8tdo=MakP-PRzVK0ieJM07y_O_1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Giampaolo Bellini <iw2lsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thank you very much Giampolo
(and funny to see that my name is the same than yours, but in Catalan)

 From your notes:
> mknod /dev/i2c-0 c 89 0
> modprobe i2c-dev
> i2cdetect -l
>>>> i2c-0   smbus           SMBus I801 adapter at 0400              SMBus adapter
> i2cget 0 0x20

I see that you can access the chip. I will test it on monday or tuesday.
Do you know if we can access the N'th pin on the chip with 'i2cget 0 
0x20 N' (N in 0..7)?
And do you know if we can access these pins directly from a C program (I 
mean without using a system call) ?

Thanks again for your responses!
