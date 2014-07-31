From: "Zvi Vered" <veredz72-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c_smbus_write_block_data: send 2 bytes (command+size) before data
Date: Thu, 31 Jul 2014 05:50:05 +0300
Message-ID: <E16B30BECA974753AA35BBFF9BCFB851@ZviVeredPC>
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

Hello,

>From an Intel's ATOM I want to send an I2C message from SMBus controller to
a TI's microcontroller configured as an I2C slave.

I used the following code:

handle = fopen ("/dev/i2c-14",O_RDWR); //open SMBUs controller

ioctl (handle, I2C_SLAVE, 0x43);  //set I2C slave destination address

i2c_smbus_write_block_data (handle, 0x00, 16, buffer); //send 16 bytes
message, command = 0x00

The message I want to send is: 0xAD, 0x2D, 0xFE, 0xCA, ..... 0x00  (16
bytes)

I'm using I2C sniffer to see what I sent and what I see is:

0x00, 0x10, 0xAD, 0x2D, 0xFE, 0xCA, .....

It seems the register (command) and length are also sent.

The MCU expect pure data without the 2 bytes: 0x00, 0x10

The above code runs under vanilla linux 3.2.48

Can you help ?

Thanks,
Z.V
