From: Maurus Frey <maurus.frey-rWV+klJzElMJP3htlS9zFw@public.gmane.org>
Subject: i2c bus driver for serial-to-i2c
Date: Wed, 25 Mar 2009 10:33:16 +0100
Message-ID: <49C9FA5C.5040202@avelon-cetex.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I tinkered a rs232-to-i2c interface (schema at 
http://www.umnicom.de/Elektronik/Schaltungssammlung/I2C-Bus/I2cToRs232/I2cRs232.html 
).

I'm now looking for a corresponding bus driver, to run the device with 
the i2c driver framework. So far I couldn't find any serial-to-i2c linux 
drivers which are compatible in the i2c kernel module architecture. I'm 
willing to write (or adapt a driver) for this purpose.

But before I jump into my first driver adventure, let me ask you some 
question about that:

Has anyone of you written a serial-to-i2c driver?

If nobody did it before, does that means: it's a stupid idea to bitbang 
i2c over the serial interface.

Does someone know a USB based interface which does only contain standard 
(no microprocessor as usb-tiny-i2 needs) components?

Thanks for your answers.

greez

maurus
