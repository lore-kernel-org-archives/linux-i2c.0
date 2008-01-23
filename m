From: Gary Chambers <gwc-OVIABD91gjs3uPMLIKxrzw@public.gmane.org>
Subject: DAC5571
Date: Wed, 23 Jan 2008 15:48:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801231538250.18738@galley.ll.mit.edu>
References: <Pine.LNX.4.64.0801181524040.14018@galley.ll.mit.edu>
	<20080119174950.1f12f3c0@hyperion.delvare>
	<Pine.LNX.4.64.0801191539500.18738@galley.ll.mit.edu>
	<20080120102335.5cc6a936@hyperion.delvare>
	<Pine.LNX.4.64.0801211310050.18738@galley.ll.mit.edu>
	<20080122150115.03eed1b6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080122150115.03eed1b6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: I2C Mailing List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean...

> Are you sure that the TI DAC5571 DAC value can be read at all? I've 
> downloaded the datasheet and all it mentions is writing to the 
> DAC5571, not reading from it.

It appears that you're correct!  I was lead down the primrose path by 
someone who assumed it was a device which provided read access to the 
analog output setting.  My cover is blown -- it's now official that 
everyone knows definitively that I know little to nothing about what I'm 
doing.  :)

I don't know how beneficial it will be, but I have nearly completed a 
driver for the DAC5571.  We're currently using Linux 2.4 in our embedded 
project, but we may soon be upgrading to a 2.6 kernel.

> The functionality matrix can be trusted in general, but if you'd tell 
> me what i2c adapter driver this is, I could double-check. Also note

We're using the tqm8260Algorithm-bit adapter.  Are you familiar with it?

-- 
Gary Chambers

// -------------------------------------
// Advanced SatComm Systems & Operations
// MIT Lincoln Laboratory / 781-981-0957
// Lexington, Massachusetts
// Nothing fancy and nothing Microsoft
// -------------------------------------

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
