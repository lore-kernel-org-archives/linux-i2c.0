From: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: i2c-mxs: Problems with PIO mode on iMX28
Date: Thu, 27 Jun 2013 19:39:45 +0200
Message-ID: <19340213.PSZe5UysTs@linux-1fbo.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

on my board there is a temperature sensor TCN75A (compatible to LM75) 
connected to the iMX283.
In the user space the temperature is periodically polled by reading the file 
/sys/bus/i2c/devices/0-0048/temp1_input.
When triggering this file the LM75 driver consecutively reads 3 registers from 
the sensor and outputs the current temperature read from register 0.

With linux 3.9.7 I sometimes get a communication timeout when reading the 
sensor.

Since several patches have been added to the driver, I tried linux 3.10-rc7. 
With this version no timeout will be reported, but sometimes the value 
returned seems to be wrong. Normally I get a value of round about 30000. But 
sometimes it takes some seconds to read the temperature and the returned value 
is 75000. This value is not the current temperature but the temperature 
hysteresis that is the content of register 2 of the sensor. 

After some investigation I found that the i2c-mxs driver sometimes times out 
while waiting for the MXS_I2C_DEBUG0_DMAREQ bit when writing data (the 
I2C_M_RD flag is not set).
Unfortunately this error is never reported to the I2C core and thus to the 
LM75 driver. So the LM75 driver assumes that it has received the correct 
values.

This problem seems to be only in the PIO mode. After changing the driver so 
that the DMA is always used it works as expected.

Best regards,
Torsten Fleischer
