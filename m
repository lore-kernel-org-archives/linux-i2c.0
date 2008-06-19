From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa.c recover from false start
Date: Thu, 19 Jun 2008 13:42:37 +0200
Message-ID: <20080619134237.3b7dff53@hyperion.delvare>
References: <36A8B4824CA88E478F1A25136D0597610112DD04@mail.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <36A8B4824CA88E478F1A25136D0597610112DD04-RKsfjrak5bi0VCHWTNMfawC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Chuck Kamas <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Chuck,

No HTML mails, please.

On Tue, 17 Jun 2008 15:39:16 -0700, Chuck Kamas wrote:
> I made this patch to recover from a false start on the bus.  This
> scenario happens in my system when a device is hot-inserted onto the bus
> causing a false start.  This is caused by the new device pulling SDA
> low.  The PXA then thinks someone is trying to talk on the bus and will
> not transmit.  My solution is to detect this fault and reset the pxa's
> i2c subsystem... not nice I know.  If there is a better way, let me
> know!

How do you differentiate between this case and another master starting
a real transaction on the bus?

What you have is a hardware issue. If you hotplug I2C devices, then you
must ensure that they will not pull either SCL not SDA low when you do.
Otherwise you are not only confusing the PXA master, but also quite
possibly the other slaves on the I2C bus. Maybe you have to put the
new device behind a gate, and open the gate once the device is properly
connected and initialized (and likewise close the gate before you
remove the device.)

I think you have to fix your hardware setup, not the i2c-pxa driver. 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
