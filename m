From: Matti Kaasinen <matti.kaasinen-9Aww8k/80nUxHbG02/KK1g@public.gmane.org>
Subject: at24.c - "convenient" byte transfer through sysfs
Date: Sat, 26 Jul 2008 02:37:53 +0300
Message-ID: <488A63D1.4020906@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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

Hi all!

Could anyone explain a bit the "convenient" part of transferring bytes 
through sysfs. Both reading and writing seems requiring kobject 
reference to the client operation is directed to. I have tried finding 
ways getting the  kobject reference for required i2c client without 
getting too convinced without the my solutions. The best choice so far 
is using bus_for_each_dev -helper function scanning through all the i2c 
clients instantiated on i2c bus. That requires bus_type structure as its 
first parameter. Unfortunately i2c_bus_type is not exported at least in 
2.6.24 that I'm playing currently with. I've seen patch discussions 
related to exporting/not exporting i2c_bus_type. Do anyone know the 
current status/future plans with it or have other suggestions regarding 
this byte transfer structure through sysfs to i2c clients?

Thanks in advance,
Matti Kaasinen

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
