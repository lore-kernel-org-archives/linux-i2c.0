From: Michele Da Rold <michele.darold-jTUIOkKm3KASWr57yraSmw@public.gmane.org>
Subject: ack/nack in write operation
Date: Thu, 14 Jul 2011 17:52:25 +0200
Message-ID: <4E1F10B9.3080507@ecsproject.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello everybody,
I'm new to i2c development some don't kill me if my questions are stupid!!

I'm using bitbanging i2c driver for an AT91 devices,
the AT91 is master and I have a slave that reply, during a write, with a 
NAK after last byte.
The i2c specification permit this solution but i2c linux driver no.
(i have see the possibility to set the I2C_M_IGNORE_NAK but ignore all 
NAK and isn't right!)

There is a solution or I have to modify the code?

Thank you
Michele
