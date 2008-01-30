From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Complex I2C device
Date: Wed, 30 Jan 2008 21:32:38 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801302126150.6547@axis700.grange>
References: <20080130144657.GA9444@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080130144657.GA9444-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rodolfo,

On Wed, 30 Jan 2008, Rodolfo Giometti wrote:

> my custom board has a =ABcomplex=BB device... let me explain better: it's
> formed by a custom I2C device and an I/O extender PCA9539.
> =

> Ascii art:
> =

> =

>                 +---------+
>           --+---+         |
>             |   | PCA9539 |
>             |   +---------+
> Bus I2C ->> |      | | |
>             |      | | | <<--- GPIOs
>             |      | | |
>             |   +---------+
>             +---+         |
>                 |   CHIP  |
>                 +---------+  =

> =

> Some input GPIOs of CHIP are managed by the PCA9539. So fisically I
> have two devices but logically they are merged together into one.
> =

> I can send commands to CHIP by both I2C bus and the GPIOs, which in
> turn are controlled by the PCA9539.
> =

> Can you please suggest me the best way to manage this problem? My
> solution was to provide PCA9539's driver of some exported symbols and
> using them into the CHIP's driver. Is that right? Or, can I "call" (in
> any way) PCA9539 driver's methods from CHIP's driver?

First, you want to use gpiolib, which in -mm tree now lives under =

drivers/gpio and includes a driver for pca9539. With it the pca9539 driver =

registers a gpio controller with the system, and then your driver for the =

other part can just request respective GPIOs as if they were normal CPU =

GPIOs or whatever else. And toggle them using the standard API. I will =

(hopefully tomorrow) post an example of exactly this to the =

video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org list. In my case this other chip is a CMOS =

camera.

Thanks
Guennadi
---
Guennadi Liakhovetski

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
