From: "Uma Kanta" <upatro-cl0A3XQdnGcanlnWow0HJg@public.gmane.org>
Subject: RE: Help Regarding I2C Driver...
Date: Tue, 24 Mar 2009 11:06:51 +0530
Message-ID: <A86BA2998E0E00468669D392AF0631BBB26E@impserver.implantaire.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,
	Thanks for your reply..

> >                 This is Uma Kanta, seeking some help regarding the 
> > I2C driver development on ARM Linux 2.6.19 platform.
>
> This version is ancient, you should consider updating to something 
> more recent.

Yaa, this version is very old, but as currently I have to develop for
this version  for our project so I have to try developing in this
version itself.

>
> > I referred the second part of i2C driver articles in Linux Journal 
> > by Greg Kroah. As well as the book Essential Linux Device Drivers.
> > I have to make I2C driver for a RTC (DS1340) and a camera module 
> > (Omnivision OVM7670).
> > I could be able to make a chip driver. Unfortunately I was unable to

> > insert the core driver "i2c_core" internally. So I inserted the 
> > i2c_core.ko and my own driver i2c_test.ko.
> > Now both drivers are getting inserted fine but the problem exists
is:
> > In my init I am adding my i2c driver structure by using 
> > "i2c_add_driver()", and my i2c driver structure named 
> > "i2c_test_driver", whose declaration is as
> > follows:
> >
> > struct i2c_driver i2c_test_driver = {
> >                 .driver = {
> >                                 .name   = "i2c_test",
> >                 },
> >                 .id = I2C_DRIVERID_OVCAMCHIP,            /* 
> > OmniVision CMOS image sens.            *//* defined in 
> > include/linux/i2c-id.h */
> >                 .attach_adapter               = 
> > i2c_test_attach_adapter,
> >                 .detach_client   = i2c_test_detach_client, };
>
> attach_adapter and friends are legacy callbacks, you should not use 
> them in new drivers. Did you read Documentation/i2c/writing-clients?

Can you please tell me what may be the alternative option for
"attach_adapter"
Field of i2c_driver. Also I read the documentation in
Documentation/i2c/writing-clients of Linux 2.6.19. Also I made my code
in the same way as the examples in drivers/i2c/chips/. But I am not
having th effect.

>
> > So here "list_for_each(item,&adapters)" returns FALSE for me. So my 
> > attach adapter function, "i2c_test_attach_adapter()" is not getting
called.
>
> Probing should be done by setting i2c_board_info from your board 
> support code - also described in Documentation/i2c/writing-clients.

Actually in Linux 2.6.19 I feel that there is no provisions for
i2c_board_info,  as non of the existing chip drivers such as eeprom,
RTCs don't have any i2c_board_info structure in the file
arch\arm\mach-at91rm9200\board-ek.c.
Also in this version the function, "at91_add_device_i2c()" does not
accept arguments  whereas in the advanced versions it takes two
arguments such as object of structure i2c_board_info and its size.
So what may be the alternative of i2c_board_info in case of Linux
2.6.19?
Is it possible to work with I2C in  Linux 2.6.19???
>
> > So I searched where the entry "adapters" is getting a tail added in 
> > the function "i2c_add_adapter()" So the function "i2c_add_adapter 
> > ()" will be called by any client driver(as mentioned in comment...).
> > I tried by all "*.ko" files in KERN_SRC/drivers/i2c/algos/ but no
effect.
> > So now to get the full functional I2C chip driver do I need to write

> > a client driver for it?
>
> You're digging too much through the core code. It works well for 
> others, so debugging this part is not the first thing you should 
> consider. Best thing is probably to grab an existing driver and see 
> how it does the job.
Actually I wanted to know where I was lagging. But now as previously I
mentioned I am not able to get the I2C working for my driver.
One more thing as I am doing for ARM platform,I wanted to know the
significance of the bus driver i2c-at91.
Do I need to take care of that to create my chip driver?


Thanks for the patience...

With Regards,
Uma Kanta Patro
