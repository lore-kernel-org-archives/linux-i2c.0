From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C_SMBUS_WORD Definition
Date: Tue, 22 Jan 2008 15:01:15 +0100
Message-ID: <20080122150115.03eed1b6@hyperion.delvare>
References: <Pine.LNX.4.64.0801181524040.14018@galley.ll.mit.edu>
	<20080119174950.1f12f3c0@hyperion.delvare>
	<Pine.LNX.4.64.0801191539500.18738@galley.ll.mit.edu>
	<20080120102335.5cc6a936@hyperion.delvare>
	<Pine.LNX.4.64.0801211310050.18738@galley.ll.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801211310050.18738-kD1P2mHmSlqz6L9v6lnKkIdd74u8MsAO@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Gary Chambers <gwc-OVIABD91gjs3uPMLIKxrzw@public.gmane.org>
Cc: I2C Mailing List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Gary,

On Mon, 21 Jan 2008 14:17:00 -0500 (EST), Gary Chambers wrote:
> > Well, reading two bytes from a device directly doesn't correspond to 
> > any SMBus transaction, so if your bus controller doesn't support I2C 
> > messaging, I fear that you're pretty much stuck.
> 
> How authoritative is the functionality matrix?  My call to it returns 
> 0xcfffc006 -- no pure I2C, but it appears that I can perform I2C block 
> writes and reads.

The functionality matrix can be trusted in general, but if you'd tell
me what i2c adapter driver this is, I could double-check. Also note
that "i2cdetect -F" can list the functionality in a much more
human-friendly format.

> > What adapter is this?  And what chip are you trying to talk to?
> 
> It's a [seemingly] simple TI DAC5571 (single-channel, 8-bit DAC) on an 
> evaluation module.

Are you sure that the TI DAC5571 DAC value can be read at all? I've
downloaded the datasheet and all it mentions is writing to the DAC5571,
not reading from it.

> Thanks for your (and the list's) patience while I gain some footing with 
> this.

You're welcome.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
