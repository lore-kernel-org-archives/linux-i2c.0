From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik
 I2C driver
Date: Fri, 04 May 2012 22:27:45 +0100
Message-ID: <4FA449D1.1040106@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-2-git-send-email-lee.jones@linaro.org> <201205042002.20943.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201205042002.20943.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/05/12 21:02, Arnd Bergmann wrote:
> On Friday 04 May 2012, Lee Jones wrote:
>> +static const struct nmk_i2c_controller *
>> +nmk_i2c_find_pdata_from_compatible(struct device_node *np)
>> +{
>> +       /*
>> +        * The u8500 is currently our only user. As more SoCs are ad=
ded,
>> +        * search for the correct value set using of_machine_is_comp=
atible
>> +        * and return a 'struct nmk_i2c_controller *' which contains=
 the
>> +        * correct information for the given SoC, whilst leaving u85=
00_i2c
>> +        * as the default/fall-back value set.
>> +        */
>> +       return&u8500_i2c;
>> +}
>
> Why not just put this pointer ...
>
>> +static const struct of_device_id nmk_gpio_match[] =3D {
>> +       { .compatible =3D "st,nomadik-i2c", },
>> +       {}
>> +};
>
> into the .data field after the .compatible match, and make it more sp=
ecific
> to the soc, i.e.
>
> static const struct of_device_id nmk_gpio_match[] =3D {
> 	{ .compatible =3D "st-ericsson,u8500-i2c", .data =3D&u8500_i2c },
> 	{ .compatible =3D "st,nomadik-i2c", .data =3D&default_i2c_controller=
 },
> };

Because;
a) I only learned about .data way after this patch was written
and
b) _You_ told me to do it like this. ;)


--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
