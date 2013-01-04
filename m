From: Sameer Parekh <sameer-WHwdnh0ia9W/3pe1ocb+swC/G2K4zDHf@public.gmane.org>
Subject: Fw: I2C to the Maxbotix I2CXL
Date: Fri, 4 Jan 2013 17:02:47 -0500
Message-ID: <2C5532F0F2CD4139B2452AB13383CD3F@falkorsystems.com>
References: <9A4760C124AD43D795B2B3AC4A364E8F@falkorsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9A4760C124AD43D795B2B3AC4A364E8F-WHwdnh0ia9W/3pe1ocb+swC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello, is this not the right forum for this question? Can someone recommend the proper forum? 

Thanks, 
-- 
Sameer Parekh
Falkor Systems, Inc.


Forwarded message:

> From: Sameer Parekh <sameer-WHwdnh0ia9W/3pe1ocb+swC/G2K4zDHf@public.gmane.org>
> To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Date: Wednesday, January 2, 2013 10:16:38 PM
> Subject: I2C to the Maxbotix I2CXL
> 
> Hello everyone.. I'm trying to get my beagle bone to communicate over I2C with the new Maxbotix I2CXL line of sonar sensors
> 
> http://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
> 
> According to the data sheet I need to write a single byte of 0x51 to the sensor to tell it to send out the sonar pulse and then wait up to 60ms (i.e. until the pulse comes back). At that point I need to read two bytes from the device, without sending a register address. This appears very similar to the i2c_smbus_read_byte() call, except that I need to read two bytes, not just one. 
> 
> It appears that all the calls that read more than one byte require that I pass in a register address. When I use i2ctools I get this:
> 
> (0x70 is the I2C address of the sensor, and 0x51 is the sonar range command)
> 
> $ i2cset -y 3 0x70 0x51
> $ i2cget -y 3 0x70 
> 0x00
> 
> 
> so it looks like I'm getting the MSB but according to the data sheet the sonar sends a second byte representing the LSB.
> 
> Does the i2c driver support this directly? Do I need to modify the driver or can I use i2c_smbus_xfer to accomplish the task? I have not been able to understand the API to i2c_smbus_xfer from reviewing the source code.
> 
> Thanks, 
> -- 
> Sameer Parekh
> Falkor Systems, Inc.
> 
