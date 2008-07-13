From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Sun, 13 Jul 2008 16:37:54 +0200
Message-ID: <20080713163754.46eb4de4@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<200807111425.00961.david-b@pacbell.net>
	<20080712091610.4ec242c3@hyperion.delvare>
	<200807120046.29389.david-b@pacbell.net>
	<f17812d70807122304o533d8af9k1384db653b264912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807122304o533d8af9k1384db653b264912-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 13 Jul 2008 14:04:28 +0800, eric miao wrote:
> From 562e78eec627092610db817e28c4ff9be6af13e1 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Date: Thu, 10 Jul 2008 13:37:59 +0800
> Subject: [PATCH] gpio: max732x: add support for MAX7319, MAX7320-7327
> I2C Port Expanders
> 
> Signed-off-by: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> (...)
> 
>  drivers/gpio/Kconfig        |   22 +++
>  drivers/gpio/Makefile       |    1 +
>  drivers/gpio/max732x.c      |  380 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/max732x.h |   19 ++
>  4 files changed, 422 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpio/max732x.c
>  create mode 100644 include/linux/i2c/max732x.h
> (...)

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
