From: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Subject: [patch 0/6] PCA9564-platform driver
Date: Mon, 21 Jan 2008 15:20:10 +0100
Message-ID: <20080121142010.988419876@pengutronix.de>
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
Cc: icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a series to add a platform driver for the PCA9564. For this, I needed
to extend the pca-algorithm a bit. I tried to adapt the existing ISA-driver
to the extensions, but cannot test it. The original maintainer receives
a cc. I developed it using a Blackfin based board. This driver should
be able to handle multiple instances (unlike the ISA one), but again
I could not test this feature myself.

I am looking forward to feedback! Thanks in advance.

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
