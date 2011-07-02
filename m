From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Need to use a I2C EEPROM on normal x86 architecture
Date: Sat, 2 Jul 2011 18:36:46 +0200
Message-ID: <BANLkTi=Ud=tnZ3pkqt3OFcFnJOrzqAkc8w@mail.gmail.com>
References: <BANLkTimfbe4ntzzTu0SXJothK1N56m1ghA@mail.gmail.com>
 <20110623111016.368a7ca5@endymion.delvare> <BANLkTimT_Sb4f6qC55uFUr6MfHzEd3wrGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTimT_Sb4f6qC55uFUr6MfHzEd3wrGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2011/6/27 Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2011/6/23 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>:
>> Hi Christian,
>>
>> On Tue, 21 Jun 2011 13:54:52 +0200, Christian Gmeiner wrote:
>>> Hi community,
>>>
>>> I am working on an embedded x86 device, which has an at24 based
>>> eeprom. I am using
>>> the i2c_eg20t driver to access the i2c bus. To be able to access th=
e
>>> eeprom in a separated
>>> driver I did this:
>>>
>>> /* technical description of our used EEPROM */
>>> static struct at24_platform_data custom_i2c_eeprom_info =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .byte_len =C2=A0 =C2=A0 =C2=A0 =3D EEPROM_BYTE=
_LEN,
>>> =C2=A0 =C2=A0 =C2=A0 .page_size =C2=A0 =C2=A0 =C2=A0=3D 16,
>>> =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
,
>>
>> Note that you don't have to mention struct members with value 0 (or
>> NULL), as this is the default.
>>
>
> Thanks for this hint.
>
>>> =C2=A0 =C2=A0 =C2=A0 .setup =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D c=
ontent_read,
>>> =C2=A0 =C2=A0 =C2=A0 .context =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL,
>>> };
>>>
>>> /* EEPROM at24 */
>>> static struct i2c_board_info __initdata i2c_info[] =3D =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_BOARD_INFO("24=
c04", 0x50),
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=
=A0=3D &custom_i2c_eeprom_info,
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> };
>>>
>>> In the init function of my custom driver I do this:
>>>
>>> =C2=A0 =C2=A0 =C2=A0 /* register known devices on i2c bus */
>>> =C2=A0 =C2=A0 =C2=A0 status =3D i2c_register_board_info(0, i2c_info=
, ARRAY_SIZE(i2c_info))
>>
>> Out of curiosity, where did you put this code? Does x86 finally supp=
ort
>> per-machine initialization as e.g. arm does?
>>
>
> I have an other x86 based target machine, which runs a 2.6.36.4
> kernel, where I created
> a new driver under drivers/misc called custom_eeprom.c. The driver is
> used to access
> some special values stored in eeprom easily from userspace via /proc.
>
> static int __init custom_eeprom_init(void)
> {
>
> =C2=A0 =C2=A0...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* register known devices on i2c bus */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D i2c_register_board_info(0, i2c_=
info, ARRAY_SIZE(i2c_info));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* create procfs entries */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> }
>
> It is AMD LX800 based an I use the scx200_acb i2c driver, modified to
> use i2c_add_numbered_adapter().
> I did a small test with 3.0-rc4 on the LX800 target, but it get an
> oops.. so there seems to be some changes in the involved subsystems.
>
>>>
>>> Now I run in some troubles... see
>>> http://www.spinics.net/lists/linux-i2c/msg02022.html
>>
>> I see that I already replied to this post...
>>
>>> What options do I have to get this running? I could use
>>> i2c_add_numbered_adapter, but I don't
>>> want to touch too much from mainline kernel sources.
>>
>> It seems difficult to use i2c_add_numbered_adapter() unconditionally=
, as
>> i2c-eg20t is a PCI driver so you don't get to pass platform data to =
it.
>> Furthermore, i2c_add_numbered_adapter() is only suitable if machine
>> setup code could be run before any device driver is initialized;
>> otherwise odds are that another driver will have picked the i2c bus
>> number you wanted. I am unsure if this is possible at all on x86 at =
the
>> moment.
>>
>> The way I would do it is from i2c-eg20t itself. Take a look at i2c-i=
801
>> for an example: at the end of the probe function, there is
>> hardware-specific code to instantiate a few I2C devices. If you have=
 a
>> way to uniquely, reliably detect that you are running on your specif=
ic
>> target system, you can do the same.
>>
>> I don't think it is particularly nice, BTW, but this is the only way=
 I
>> found so far with what the i2c subsystem core offers. If anyone has
>> suggestions how to improve this, please speak up.
>>
>> If you want to be able to use i2c_add_numbered_adapter() conditional=
ly
>> without the help of platform data, then you need a hint from i2c-cor=
e.
>> Would the following patch help you? If it does, and others show
>> interest, and there are no objections, this could go upstream in ker=
nel
>> 3.1.
>>
>
> I get an oops quite early in kernel bootup... I will try to catch it
> and if you are
> interested I will post it here.
>
>> ---
>> =C2=A0drivers/i2c/busses/i2c-eg20t.c | =C2=A0 =C2=A07 ++++++-
>> =C2=A0drivers/i2c/i2c-boardinfo.c =C2=A0 =C2=A0| =C2=A0 20 +++++++++=
+++++++++++
>> =C2=A0include/linux/i2c.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A05 +++++
>> =C2=A03 files changed, 31 insertions(+), 1 deletion(-)
>>
>> --- linux-3.0-rc4.orig/drivers/i2c/i2c-boardinfo.c =C2=A0 =C2=A0 =C2=
=A02011-05-20 10:42:40.000000000 +0200
>> +++ linux-3.0-rc4/drivers/i2c/i2c-boardinfo.c =C2=A0 2011-06-23 10:1=
5:56.000000000 +0200
>> @@ -90,3 +90,23 @@ i2c_register_board_info(int busnum,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
>> =C2=A0}
>> +
>> +/**
>> + * i2c_adapter_is_static - let drivers know if their bus is static
>> + * @busnum: identifies the bus
>> + *
>> + * After calling this function, i2c bus drivers can decide whether
>> + * to call i2c_add_adapter or i2c_add_numbered_adapter.
>> + */
>> +int
>> +i2c_adapter_is_static(int busnum)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 int is_static;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 down_write(&__i2c_board_lock);
>> + =C2=A0 =C2=A0 =C2=A0 is_static =3D busnum < __i2c_first_dynamic_bu=
s_num;
>> + =C2=A0 =C2=A0 =C2=A0 up_write(&__i2c_board_lock);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return is_static;
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_adapter_is_static);
>> --- linux-3.0-rc4.orig/include/linux/i2c.h =C2=A0 =C2=A0 =C2=A02011-=
06-21 10:32:32.000000000 +0200
>> +++ linux-3.0-rc4/include/linux/i2c.h =C2=A0 2011-06-23 09:58:21.000=
000000 +0200
>> @@ -306,6 +306,7 @@ extern void i2c_unregister_device(struct
>> =C2=A0extern int
>> =C2=A0i2c_register_board_info(int busnum, struct i2c_board_info cons=
t *info,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned n);
>> +extern int i2c_adapter_is_static(int busnum);
>> =C2=A0#else
>> =C2=A0static inline int
>> =C2=A0i2c_register_board_info(int busnum, struct i2c_board_info cons=
t *info,
>> @@ -313,6 +314,10 @@ i2c_register_board_info(int busnum, stru
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> =C2=A0}
>> +static inline int i2c_adapter_is_static(int busnum)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> =C2=A0#endif /* I2C_BOARDINFO */
>>
>> =C2=A0/*
>> --- linux-3.0-rc4.orig/drivers/i2c/busses/i2c-eg20t.c =C2=A0 2011-05=
-30 20:45:09.000000000 +0200
>> +++ linux-3.0-rc4/drivers/i2c/busses/i2c-eg20t.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A02011-06-23 10:48:26.000000000 +0200
>> @@ -787,7 +787,12 @@ static int __devinit pch_i2c_probe(struc
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pch_adap->dev=
=2Eparent =3D &pdev->dev;
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_add_a=
dapter(pch_adap);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_adapter_i=
s_static(i)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* We assume that a single PCI device is present */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pch_adap->nr =3D i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D i2c_add_numbered_adapter(pch_adap);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D i2c_add_adapter(pch_adap);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto err_i2c_add_adapter;
>>
>>
>>

I played for some hours with the i2c subsystem an my problem. I got it
working somehow, but I have some questions :)

When does a driver gets loaded during kernel init? It looks like, if I
put a driver into drivers/misc it gets loaded before a driver
in dirvers/platform/x86.

If this is true in every case, I can not use i2c_register_board_info,
as the i2c driver gets loaded before my driver.
I think I will also run into problems using platform_add_devices...
hmmm.. not so easy to solve my problem and get
the driver flying.

I need to make a driver that does the following:

1) search an 24c04 eeprom at defined i2c addresses (0x50 and 0x52).
2) read model informations from eeprom
3) call platform_add_devices depending on model

This is what I get:

[    0.110652] i2c-core: driver [dummy] registered
[    1.497886] i2c-core: driver [at24] registered
[    3.076437] i2c /dev entries driver
[    3.087607] i2c_eg20t 0000:02:0c.2: PCI INT C -> GSI 18 (level,
low) -> IRQ 18
[    3.110134] i2c_adapter_is_static: busnum 0 -> is static 0
[    3.121981] i2c-dev: adapter [i2c_eg20t] registered as minor 0
[    3.122161] i2c i2c-0: adapter [i2c_eg20t] registered
[    3.122173] i2c-eg20t: i2c_add_adapter
[    3.178255] i2c_register_board_info for busnum 0
[    3.189125] i2c_register_board_info for busnum 0
[    3.199581] bachmann-ot: i2c_register 0

based on this module_init()

static int __init bachmann_ot_init(void)
{
        int ret;
        struct i2c_adapter *adap =3D NULL;
        struct i2c_client *e =3D NULL;

        /* declare the I2C devices by bus number */
        ret =3D i2c_register_board_info(0, eeprom_board_info,
ARRAY_SIZE(eeprom_board_info));
        printk(KERN_INFO "bachmann-ot: i2c_register %d\n", ret);

        /* instantiate the devices explicitly */
        adap =3D i2c_get_adapter(0);
        if (adap =3D=3D NULL) {
                printk(KERN_ERR "bachmann-ot: failed to get i2c adapter=
\n");
                return -ENODEV;
        }

        i2c_put_adapter(adap);
        e =3D i2c_new_device(adap, &eeprom_board_info[0]);

        if (e =3D=3D NULL) {
                printk(KERN_ERR "bachmann-ot: failed to eeprom device\n=
");
                return -ENODEV;
        }

        return 0;
}


If I do not use i2c_new_device, the at24 driver never gets registered
and the eeprom never gets
read.

--
Christian Gmeiner, MSc
