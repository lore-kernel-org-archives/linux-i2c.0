From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: ExpressCard to SMBus adapters?
Date: Fri, 15 Aug 2008 23:28:06 -0700
Message-ID: <200808152328.06495.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I'm mostly just curious here ... as many folk know, modern laptops
tend to have "ExpressCard" instead of PCMCIA/CardBus.  And what's
available on the ExpressCard connectors?

	- PCIE x1 channel
	- USB (high/full/low speed support)
	- SMBus
	- 3.3V power, average 1000 mA
	- 1.5V power, average  500 mA 

So in lieu of USB-to-I2C adapters like i2c-tiny, it seems to me
one should be able to get a fairly simple ExpressCard, maybe with
some buffering to protect the circuits, giving access to the PC's
SMBus for developer type stuff.

This is of course complicated by the SMBus support being optional.
(Anyone know how common that is?  I'd expect it should be common...) 

Some web searching turned up

	http://www.allion.com/test_tool_ExpressCard.html

listing an "ExpressCard Test fixture" which is basically a card
extender with test points.  No price listed; must be Free.  ;)

Does anyone know about other products doing this?  Or have comments
on the notion?

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
