From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c driver for Maxim max9485 audio clock
 generator chip
Date: Wed, 22 Oct 2008 08:38:47 +0200
Message-ID: <20081022083847.5216472c@hyperion.delvare>
References: <20081021030205.2494.55081.stgit@terra>
	<20081021103607.78ffb4da@hyperion.delvare>
	<9e4733910810211657s5e25e391p5ca6e6f672d115c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910810211657s5e25e391p5ca6e6f672d115c5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 21 Oct 2008 19:57:09 -0400, Jon Smirl wrote:
> On Tue, Oct 21, 2008 at 4:36 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Honestly I don't see any value in this driver. There's nothing you can
> > do with it that you couldn't already do without it.
> 
> I need a driver so that my device tree will bind and tell me the i2c
> address of the device.

This is rubbish. It's perfectly fine to let the I2C device be
instantiated from the device tree without having a driver that binds to
it. The device tree and the instantiated device, not the driver, tell
you the I2C address of the device.

> We may also build a device in the future with two of these chips.

I fail to see how it matters.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
