From: Tim Bakker <bakkert-Lqq7FYbpbC48+Wv5JVE8qw@public.gmane.org>
Subject: Re: I2C slave support on Xilinx Zybo
Date: Sat, 13 Jun 2015 06:17:53 -0400
Message-ID: <CAMQCnXGQTQdXaOL5vT0ZbV-F_0P5qJ7kSQSHrMv49fMbAy2UrA@mail.gmail.com>
References: <CAMQCnXF47Kr3x3yeqba-me+N8rQ-vDJ6ziho5107qcckDbT0mQ@mail.gmail.com>
	<20150610143801.GB21540@katana>
	<CAMQCnXHfcgWpAS4HT=8sCt7RHA29xMK9KzAU6H0rP3RR7DLMuw@mail.gmail.com>
	<20150613094905.GA1682@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150613094905.GA1682@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I think that worked, I can see the device  popup in the
/sys/bus/i2c/drivers/i2c-slave-eeprom folder, and looking at the
uevent file in the created device (1-0028) gives me:

DRIVER=i2c-slave-eeprom
MODALIAS=i2c:slave-24c02


Sorry to hackle you more but I am still getting the continuous message
(when the console log level has changed to 8):

i2c-slave-eerpom 1-0028: uevent

Should I just ignore this for now and see if I can get the slave
support to work or do you think this might be in an issue in my
implementation of the slave support in the xilinx driver.

Thanks,
Tim




On Sat, Jun 13, 2015 at 5:49 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> I don't think necessarily there is an error in the docs, it was probably my
>
> Nope, the docs are wrong. Try this:
>
> echo slave-24c02 0x28 > /sys/bus/i2c/devices/i2c-1/new_device
>
> That should be it. I am travelling at the moment, so I can't double
> check, sadly. But after that, you should have a new device at 1-0028
> bound to the i2c-slave-eeprom driver.
>
> Thanks for the code! Haven't looked in detail yet, needs some polishing
> to match kernel coding style. But as they say, first make it work, then
> make it beautiful.
>
> Good luck!



-- 
Tim Bakker, PhD
Research Assistant
Virginia Commonwealth University
601 W. Main St.
Richmond, VA 23284-3068
Rm. 216
