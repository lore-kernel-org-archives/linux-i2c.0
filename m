From: "Dimitar Penev" <dpn-ULhK8fpl5TEAvxtiuMwx3w@public.gmane.org>
Subject: Simple i2c question
Date: Sat, 12 Sep 2009 11:53:24 +0300
Message-ID: <44A06E4209214E37A884D1C506B9DF74@dpnl>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guys,

I hope my question is not too basic for this mailing list but I am really 
confused by the Linux i2c framework

Let me describe what I want to do  and what I know so it is easier to point 
me to the solution.

I have manufactured a Blackfin CPU based board running uClinux on it.
I have pca9539 chip on this board. I know that there is already a driver for 
this chip.
Originally I had kernel version 2.6.25 and during the kernel boot the 
probe/detect functions of this driver was executed.
Inside this driver I have added two global functions one for read and 
another one for write of a byte in the PCA9539.
I was using i2c_smbus_read_byte_data, i2c_smbus_write_byte_data functions to 
do this.
As 'client' argument for those smbus functions I was using the client 
provided during invocation of the driver detect function.
I exported the new functions and this way I could control my PCA9539 from 
the kernel space.

However I decide to try the new Linux kernel 2.6.28.10. I noticed that the 
i2c framework has changed
and now my probe/detect functions are not invoked. I studied the i2c 
framework a bit and I know about  the device instantiate using
i2c_register_board_info function.

Then I realize that I have to register bus 0 driver so I get my probe 
function invoked. Still not clear how to do it though.

Meanwhile I have noticed that actually the pca9539 chip driver is creating 
sysfs entries for access from the users space.
So now I think that most probably I don't need pca9539 driver at all. (I 
need i2c at the kernel space)

Now my question:
I want to have kernel space control over my pca9539. I would prefer a simple 
way for example to use
i2c_smbus_read_byte_data / i2c_smbus_write_byte_data. However I don't know 
how to define my 'i2c_client' argument in this case.

Can you please give me some pointers so I clean the picture in my mind.

Best Regards
Dimitar 
