From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Need to use a I2C EEPROM on normal x86 architecture
Date: Mon, 27 Jun 2011 13:50:58 +0200
Message-ID: <BANLkTimT_Sb4f6qC55uFUr6MfHzEd3wrGQ@mail.gmail.com>
References: <BANLkTimfbe4ntzzTu0SXJothK1N56m1ghA@mail.gmail.com> <20110623111016.368a7ca5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110623111016.368a7ca5-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2011/6/23 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>:
> Hi Christian,
>
> On Tue, 21 Jun 2011 13:54:52 +0200, Christian Gmeiner wrote:
>> Hi community,
>>
>> I am working on an embedded x86 device, which has an at24 based
>> eeprom. I am using
>> the i2c_eg20t driver to access the i2c bus. To be able to access the
>> eeprom in a separated
>> driver I did this:
>>
>> /* technical description of our used EEPROM */
>> static struct at24_platform_data custom_i2c_eeprom_info =3D {
>> =C2=A0 =C2=A0 =C2=A0 .byte_len =C2=A0 =C2=A0 =C2=A0 =3D EEPROM_BYTE_=
LEN,
>> =C2=A0 =C2=A0 =C2=A0 .page_size =C2=A0 =C2=A0 =C2=A0=3D 16,
>> =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0,
>
> Note that you don't have to mention struct members with value 0 (or
> NULL), as this is the default.
>

Thanks for this hint.

>> =C2=A0 =C2=A0 =C2=A0 .setup =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D co=
ntent_read,
>> =C2=A0 =C2=A0 =C2=A0 .context =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL,
>> };
>>
>> /* EEPROM at24 */
>> static struct i2c_board_info __initdata i2c_info[] =3D =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_BOARD_INFO("24c=
04", 0x50),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=A0=
=3D &custom_i2c_eeprom_info,
>> =C2=A0 =C2=A0 =C2=A0 },
>> };
>>
>> In the init function of my custom driver I do this:
>>
>> =C2=A0 =C2=A0 =C2=A0 /* register known devices on i2c bus */
>> =C2=A0 =C2=A0 =C2=A0 status =3D i2c_register_board_info(0, i2c_info,=
 ARRAY_SIZE(i2c_info))
>
> Out of curiosity, where did you put this code? Does x86 finally suppo=
rt
> per-machine initialization as e.g. arm does?
>

I have an other x86 based target machine, which runs a 2.6.36.4
kernel, where I created
a new driver under drivers/misc called custom_eeprom.c. The driver is
used to access
some special values stored in eeprom easily from userspace via /proc.

static int __init custom_eeprom_init(void)
{

    ...

	/* register known devices on i2c bus */
	status =3D i2c_register_board_info(0, i2c_info, ARRAY_SIZE(i2c_info));

	/* create procfs entries */

	...
=09
	return ret;
}

It is AMD LX800 based an I use the scx200_acb i2c driver, modified to
use i2c_add_numbered_adapter().
I did a small test with 3.0-rc4 on the LX800 target, but it get an
oops.. so there seems to be some changes in the involved subsystems.

>>
>> Now I run in some troubles... see
>> http://www.spinics.net/lists/linux-i2c/msg02022.html
>
> I see that I already replied to this post...
>
>> What options do I have to get this running? I could use
>> i2c_add_numbered_adapter, but I don't
>> want to touch too much from mainline kernel sources.
>
> It seems difficult to use i2c_add_numbered_adapter() unconditionally,=
 as
> i2c-eg20t is a PCI driver so you don't get to pass platform data to i=
t.
> Furthermore, i2c_add_numbered_adapter() is only suitable if machine
> setup code could be run before any device driver is initialized;
> otherwise odds are that another driver will have picked the i2c bus
> number you wanted. I am unsure if this is possible at all on x86 at t=
he
> moment.
>
> The way I would do it is from i2c-eg20t itself. Take a look at i2c-i8=
01
> for an example: at the end of the probe function, there is
> hardware-specific code to instantiate a few I2C devices. If you have =
a
> way to uniquely, reliably detect that you are running on your specifi=
c
> target system, you can do the same.
>
> I don't think it is particularly nice, BTW, but this is the only way =
I
> found so far with what the i2c subsystem core offers. If anyone has
> suggestions how to improve this, please speak up.
>
> If you want to be able to use i2c_add_numbered_adapter() conditionall=
y
> without the help of platform data, then you need a hint from i2c-core=
=2E
> Would the following patch help you? If it does, and others show
> interest, and there are no objections, this could go upstream in kern=
el
> 3.1.
>

I get an oops quite early in kernel bootup... I will try to catch it
and if you are
interested I will post it here.

> ---
> =C2=A0drivers/i2c/busses/i2c-eg20t.c | =C2=A0 =C2=A07 ++++++-
> =C2=A0drivers/i2c/i2c-boardinfo.c =C2=A0 =C2=A0| =C2=A0 20 ++++++++++=
++++++++++
> =C2=A0include/linux/i2c.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A05 +++++
> =C2=A03 files changed, 31 insertions(+), 1 deletion(-)
>
> --- linux-3.0-rc4.orig/drivers/i2c/i2c-boardinfo.c =C2=A0 =C2=A0 =C2=A0=
2011-05-20 10:42:40.000000000 +0200
> +++ linux-3.0-rc4/drivers/i2c/i2c-boardinfo.c =C2=A0 2011-06-23 10:15=
:56.000000000 +0200
> @@ -90,3 +90,23 @@ i2c_register_board_info(int busnum,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
> +
> +/**
> + * i2c_adapter_is_static - let drivers know if their bus is static
> + * @busnum: identifies the bus
> + *
> + * After calling this function, i2c bus drivers can decide whether
> + * to call i2c_add_adapter or i2c_add_numbered_adapter.
> + */
> +int
> +i2c_adapter_is_static(int busnum)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int is_static;
> +
> + =C2=A0 =C2=A0 =C2=A0 down_write(&__i2c_board_lock);
> + =C2=A0 =C2=A0 =C2=A0 is_static =3D busnum < __i2c_first_dynamic_bus=
_num;
> + =C2=A0 =C2=A0 =C2=A0 up_write(&__i2c_board_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return is_static;
> +}
> +EXPORT_SYMBOL_GPL(i2c_adapter_is_static);
> --- linux-3.0-rc4.orig/include/linux/i2c.h =C2=A0 =C2=A0 =C2=A02011-0=
6-21 10:32:32.000000000 +0200
> +++ linux-3.0-rc4/include/linux/i2c.h =C2=A0 2011-06-23 09:58:21.0000=
00000 +0200
> @@ -306,6 +306,7 @@ extern void i2c_unregister_device(struct
> =C2=A0extern int
> =C2=A0i2c_register_board_info(int busnum, struct i2c_board_info const=
 *info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned n);
> +extern int i2c_adapter_is_static(int busnum);
> =C2=A0#else
> =C2=A0static inline int
> =C2=A0i2c_register_board_info(int busnum, struct i2c_board_info const=
 *info,
> @@ -313,6 +314,10 @@ i2c_register_board_info(int busnum, stru
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
> +static inline int i2c_adapter_is_static(int busnum)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> =C2=A0#endif /* I2C_BOARDINFO */
>
> =C2=A0/*
> --- linux-3.0-rc4.orig/drivers/i2c/busses/i2c-eg20t.c =C2=A0 2011-05-=
30 20:45:09.000000000 +0200
> +++ linux-3.0-rc4/drivers/i2c/busses/i2c-eg20t.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A02011-06-23 10:48:26.000000000 +0200
> @@ -787,7 +787,12 @@ static int __devinit pch_i2c_probe(struc
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pch_adap->dev.=
parent =3D &pdev->dev;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_add_ad=
apter(pch_adap);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_adapter_is=
_static(i)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* We assume that a single PCI device is present */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pch_adap->nr =3D i;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D i2c_add_numbered_adapter(pch_adap);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D i2c_add_adapter(pch_adap);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto err_i2c_add_adapter;
>
>
>
> --
> Jean Delvare
>

--
Christian Gmeiner, MSc
