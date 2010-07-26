From: Fernand LONE SANG <fernand.lone-sang-lqLVLfd8vIE@public.gmane.org>
Subject: i2cdetect outputs on Intel x58 chipsets wanted
Date: Mon, 26 Jul 2010 10:46:20 +0200
Message-ID: <20100726084620.GB4640@laas.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello everyone.

I am probably off-topic. Feel free to skip to the next thread ;)

I am currently trying to reach a SMBus slave component located in the
I/O Hub (IOH) on Intel x58 chipsets. According to Intel
specifications, this component enable server manageability. As my
motherboard (DX58SO E29331-503) does not seem to have this component
and as I did not manage to get in touch with an Intel technician for
help, i'm looking for some kind people, with an Intel x58 chipset, who
can send me by email their outputs from the i2cdectect tool so i can
identify the motherboard version that have this component.

For ones who can help me, you should first load the i2c-dev and
i2c-i801 kernel modules:
      
  $ sudo modprobe i2c-dev
  $ sudo modprobe i2c-i801

Then, you should install i2c-tools to get i2cdetect. e.g., for debian
based distribution:

  $ sudo apt-get install i2c-tools

Now i would like you to run "i2cdetect -l" to identify the i2c adapter
available on your computer and then run i2cdetect on the Intel i801
adapter. For example:

  $ sudo i2cdetect -l
  i2c-0	   i2c	    nouveau-0000:02:00.0-0	  I2C adapter
  i2c-1	   i2c      nouveau-0000:02:00.0-1        I2C adapter
  i2c-2	   smbus    SMBus I801 adapter at 3000    SMBus adapter

  $ sudo i2cdetect 2
  ...

At this stage, a warning message will appear stating that this
manipulation can confuse your i2c bus and it will ask you whether to
continue or not. Type 'Yes'. Then, it will output some numbers on the
screen. It is this output what i need. Additionnally, if you can send
me the output of dmidecode so i can identify the exact motherboard
model you have, it will be perfect.

  $ sudo i2cdetect 2 > i2cdetect.out
  $ sudo dmidecode > dmidecode.out

Thanks everyone for your help. I really appreciate. Sorry again for
being off-topic.

--
Fernand LONE SANG
