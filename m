From: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire interface
	protocol
Date: Thu, 16 Jul 2009 11:13:34 -0500
Message-ID: <528f13590907160913n73dcb4fcuf09f4946d7578793@mail.gmail.com>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <4A5CB908.4060404@cam.ac.uk>
	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
	 <4A5D6C0A.7030903@gmx.de>
	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>
	 <4A5DEB12.3020602@cam.ac.uk>
	 <528f13590907151032y30ae62beo486d4e1056219983@mail.gmail.com>
	 <4A5E206F.8000001@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5E206F.8000001-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jonathan,
Thanks for the relentless help. I have adapted the driver to my
platform by changing the following:
gpio_request(), gpio_get/gpio_set() to thier counterparts on my platform.

> couple of mfp defines to enable the gpios. (how you do this is platform dependent)
By this i guess, you mean configuring the gpios, and defining the I/O
characteristics for each of the signals.

>mework there are some bits and bobs related

So after doing all the porting, i was able to compile it as an
loadable kernel module. I tried insmod and here;s what i get:

~$ insmod sht15.ko
regulator: Unable to get requested regulator: vcc
sht15 sht15: Command not acknowledged
 ~$
Do i have to play with any timings related to the part. I have a SHT11
, but i was assuming that there is no significant difference.
Although something may have gone wrong when i ported.
-Alfred.
