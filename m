From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Thu, 24 Jul 2008 21:23:31 +0300
Message-ID: <31e679430807241123r32fbabc8ib7e671ed821e2187@mail.gmail.com>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
	<1216909598.4888911eb6cea@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1216909598.4888911eb6cea-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
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
To: fuhz-GANU6spQydw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Thu, Jul 24, 2008 at 5:26 PM,  <fuhz-GANU6spQydw@public.gmane.org> wrote:
> Hi,
>
> Thank you so much for help.
>
>
>> yes, if you have the proper struct i2c_driver and struct i2c_device_id in
>> your driver the i2c subsystem should call the probe of your device.
>>
>> check drivers/i2c/chips/menelaus.c for an example.
>>
>> See how I2C_BOARD_INFO() in arch/arm/mach-omap2/board-h4
>> and struct i2c_device_id have the same name for the device (menelaus).
>
> I am not using the last snapshot of Linux, but the 2.6.23 release.
> My source code is not completly up-to-date.
>
> For example there is no reference of I2C_BOARD_INFO in board-h4.
> I have no 'i2c_device_id menelaus_id[]' in the i2c drivers code.
>
> Perhap's that's why I am quite confuse, I am refering to recent code exam=
ples
> and I am using not-so-recent Linux version.

might be. Why are you using 2.6.23 and not 2.6.26 ?

Anyways, in 2.6.23 there was no i2c_device_id, so you can drop that comment.

But if you have to give the same name in the driver and in the i2c_board_in=
fo().

something like:

struct i2c_board_info *info[] =3D
{


>
>
> In the documentation, "New-style" drivers are presented very quickly.
> In fact, I still don't know where must be located the valid client list:
> - in the board init source code with I2C_BOARD_INFO() macro
> - in the i2c driver source code
>
>
>> no, i2c layer will call device probe based on the driver name being the =
same
>> in
>> i2c_board_info and i2c_device_id (if I'm not wrong that's the match,
>> Jean correct
>> me if I'm wrong).
>>
>
> With my Linux version, i2c_device_id list was not present in the i2c_driv=
er
> structure. So i2c_board_info is supposed to match with what ?
>
>
>> That's old style i2c driver. You don't need that anymore ;-)
>
> Cool :)
> Lines removed !
>
>
>
> Best regards,
>
> L=E9gion.
>
> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c
>



-- =

Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
