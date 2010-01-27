From: Robin Getz <rgetz-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Subject: 32-bit I2C slave...
Date: Wed, 27 Jan 2010 14:54:19 -0500
Message-ID: <201001271454.19876.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Mark D. Studebaker" <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Mark/Jean:

I have a new I2C slave which has 32-bit data/addresses that I'm trying to 
figure out if I can connect up to the i801x chipset...

A read is:

 S Addr Wr [A] Comm(31:24) [A] Comm(23:16) [A] Comm(15:8) [A] Comm(7:0) [A]
 S Addr R [A] [Data(31:24)] A [Data(23:16)] A [Data(15:8)] A [Data(7:0)] NA P

A Write is:

 S Addr Wr [A] Comm(31:24) [A] Comm(23:16) [A] Comm(15:8) [A] Comm(7:0) [A]
               Data(31:24) [A] Data(23:16) [A] Data(15:8) [A] Data(7:0) [A] P

Comm the 32-bit data which selects the register on the I2C slave.

I can use I2C to do this...

The question is - it doesn't look like the ./drivers/i2c/busses/i2c-i801.c 
supports enough I2C to do this - and I don't think I can abuse SMBus to talk 
to the part.

Would you agree with my speculation? or am I missing some I2C_FUNC_I2C 
somewhere? or some magic way to make SMBUS work?

Thanks
-Robin
