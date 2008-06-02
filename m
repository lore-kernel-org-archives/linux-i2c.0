From: "Tekkalkot, Seetaram (IE10)" <Seetaram.Tekkalkot-TF0kVB3jB5US+FvcfC7Uqw@public.gmane.org>
Subject: Re: Problem Configuring Micron sensor MT9D131 using i2c
Date: Mon, 2 Jun 2008 12:07:12 +0530
Message-ID: <1106299A6DFA0E4D8E13CFD83A7611F09E3425@IE10EV813.global.ds.honeywell.com>
References: <1106299A6DFA0E4D8E13CFD83A7611F09E2CA1@IE10EV813.global.ds.honeywell.com>
	<Pine.LNX.4.64.0805302218580.13362@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0805302218580.13362-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thanks for the valuable inputs.

The master clock signal is derived from within the sensor board using an
oscillator. I am getting 11.2 Mhz clock to the sensor. The host
interface includes Data lines (d0 to d7), pixel clock, line valid and
frame valid signals. All these are output signals.Currently these wires
are not connected to the host and are left open. I have only connected,
SDA, SCLk and power to the sensor board. When I run i2cdetect, some
devices on the host i2c-0 bus are getting detected at the address 0x50,
0x51 etc. But my Sensor board is not getting detected.
Please advice.

Thanks
seetaram


-----Original Message-----
From: Guennadi Liakhovetski [mailto:g.liakhovetski-Mmb7MZpHnFY@public.gmane.org] 
Sent: Saturday, May 31, 2008 1:54 AM
To: Tekkalkot, Seetaram (IE10)
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Subject: Re: [i2c] Problem Configuring Micron sensor MT9D131 using i2c

On Fri, 30 May 2008, Tekkalkot, Seetaram (IE10) wrote:

> I am trying to configure the Micron sensor MTD131 using Linux 2.6 i2c.
> 
> The sensor data sheet mentions 0x90 as the write i2c address and 0x91
as
> read i2c address.
> 
> It also mentions that, the last bit in the address is used to indicate
> read or write operation.
> 
> I am using 0x48 (0x90 shifted right once to get 7 bit i2c address) to
> detect the sensor using i2cdetect tool.
> 
> I am not able to detect this device!. I tried reading this device
using
> i2cget tool but it fails to read.

I understand it is connected to a camera-host interface. Some cameras, 
including Micron cameras, do not reply to i2c commands until the camera 
interface (master clock) is activated.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
