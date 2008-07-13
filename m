From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C  Port Expanders
Date: Sun, 13 Jul 2008 02:12:36 -0700
Message-ID: <20080713091236.015E920ABDD@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <4875A893.3090402@gmail.com>
	<200807111425.00961.david-b@pacbell.net>
	<20080712091610.4ec242c3@hyperion.delvare>
	<200807120046.29389.david-b@pacbell.net>
	<f17812d70807122304o533d8af9k1384db653b264912@mail.gmail.com>
	<20080713092050.6dffd8d3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080713092050.6dffd8d3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> 3. for chips like max732x, actually, the range of 0x50 - 0x5F will be
> monitored by the I2C chips at startup to decide the connections of
> AD2/AD0 pins to GND/VCC/SCL/SDA,

There's no need to monitor addresses ... before the first data bit
is sent -- whatever value! -- it's known how those pins are wired:

 - START bit ... SCL is high, SDA falls.  Any pin that stayed
   low is wired to ground.  Any pin that changed high-to-low is
   thus connected to SDA.

 - Prepare to send first bit ... SDA still low, SCL falls.  Any
   pin that stayed high is wired to Vcc.  Any pin that changed
   high-to-low is connected to SCL.

And then the master updates SDA to match the first (address) bit,
and lets SCL be pulled high ... the i2c slave has all the data it
needs to be able to determine its address.


>		so actually, even if the chip
> is finally decided at, say 0x56, no sane hardware designers will put
> another chip whose address falls between 0x50-0x5F together with
> such a max732x chip, ugly, but true.

As Jean said:  I don't buy this point at all.  This isn't the only
chip to use that GND/VCC/SCL/SDA scheme, and all data sheets I've
seen talk about how it lets lots of distinct chips be used.  They
can't all be wrong...

I think someone was leading you astray!

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
