From: fuhz-GANU6spQydw@public.gmane.org
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Thu, 24 Jul 2008 16:26:38 +0200
Message-ID: <1216909598.4888911eb6cea@imp.free.fr>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430807240616n4bed86c7sa5c5ce69e066d0b5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Hi,

Thank you so much for help.


> yes, if you have the proper struct i2c_driver and struct i2c_device_id in
> your driver the i2c subsystem should call the probe of your device.
>
> check drivers/i2c/chips/menelaus.c for an example.
>
> See how I2C_BOARD_INFO() in arch/arm/mach-omap2/board-h4
> and struct i2c_device_id have the same name for the device (menelaus).

I am not using the last snapshot of Linux, but the 2.6.23 release.
My source code is not completly up-to-date.

For example there is no reference of I2C_BOARD_INFO in board-h4.
I have no 'i2c_device_id menelaus_id[]' in the i2c drivers code.

Perhap's that's why I am quite confuse, I am refering to recent code exampl=
es
and I am using not-so-recent Linux version.


In the documentation, "New-style" drivers are presented very quickly.
In fact, I still don't know where must be located the valid client list:
- in the board init source code with I2C_BOARD_INFO() macro
- in the i2c driver source code


> no, i2c layer will call device probe based on the driver name being the s=
ame
> in
> i2c_board_info and i2c_device_id (if I'm not wrong that's the match,
> Jean correct
> me if I'm wrong).
>

With my Linux version, i2c_device_id list was not present in the i2c_driver
structure. So i2c_board_info is supposed to match with what ?


> That's old style i2c driver. You don't need that anymore ;-)

Cool :)
Lines removed !



Best regards,

L=E9gion.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
