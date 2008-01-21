From: Gary Chambers <gwc-OVIABD91gjs3uPMLIKxrzw@public.gmane.org>
Subject: Re: I2C_SMBUS_WORD Definition
Date: Mon, 21 Jan 2008 14:17:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801211310050.18738@galley.ll.mit.edu>
References: <Pine.LNX.4.64.0801181524040.14018@galley.ll.mit.edu>
	<20080119174950.1f12f3c0@hyperion.delvare>
	<Pine.LNX.4.64.0801191539500.18738@galley.ll.mit.edu>
	<20080120102335.5cc6a936@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080120102335.5cc6a936-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

> Well, reading two bytes from a device directly doesn't correspond to 
> any SMBus transaction, so if your bus controller doesn't support I2C 
> messaging, I fear that you're pretty much stuck.

How authoritative is the functionality matrix?  My call to it returns 
0xcfffc006 -- no pure I2C, but it appears that I can perform I2C block 
writes and reads.

> What adapter is this?  And what chip are you trying to talk to?

It's a [seemingly] simple TI DAC5571 (single-channel, 8-bit DAC) on an 
evaluation module.

Thanks for your (and the list's) patience while I gain some footing with 
this.

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
