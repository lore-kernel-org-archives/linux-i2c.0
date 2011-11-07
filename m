From: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: (unknown)
Date: Mon, 7 Nov 2011 11:25:42 +0000
Message-ID: <CAN=k24=x1MQaSu2b-tz6-8BvwW4WfY5e47z21Vdf+B6D93xQtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: 
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I have been tasked with writing a driver for a Microchip Quad DAC with
EEPROM memory, MCP4728 if you would like to look it up. This device
has a feature that I have not come across before, the device's I2C
address is set in software and stored in the EEPROM as opposed to
using hardware. The factory default address for the MCP4728 is 0x60
and to avoid conflict it needs to be changed. The datasheet tells me I
must switch the LDAC pin from high to low at the last bit of the
second byte in the I2C message and it must stay low until the end of
the third byte.

I am wondering if there are any other devices within the kernel source
that support this type of address setup? I am assuming that the normal
set of I2C/SMBUS functions will not be enough to program a new address
since I will need some sort of mechanism to switchthe LDAC pin?

Kind regards

Wayne
