From: "Uma Kanta Patro" <upatro-cl0A3XQdnGcanlnWow0HJg@public.gmane.org>
Subject: Help Regarding I2C Driver...
Date: Mon, 23 Mar 2009 09:54:50 +0530
Message-ID: <000001c9ab6f$4ee35290$eca9f7b0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-us
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This is Uma Kanta, seekin=
g some help regarding the I2C
driver development on ARM Linux 2.6.19 platform.
I referred the second part of i2C driver articles in Linux Journal by G=
reg
Kroah. As well as the book Essential Linux Device Drivers.
I have to make I2C driver for a RTC (DS1340) and a camera module (Omniv=
ision
OVM7670).
I could be able to make a chip driver. Unfortunately I was unable to in=
sert
the core driver =93i2c_core=94 internally. So I inserted the i2c_core.k=
o and my
own driver i2c_test.ko.
Now both drivers are getting inserted fine but the problem exists is:
In my init I am adding my i2c driver structure by using =93i2c_add_driv=
er()=94,
and my i2c driver structure named =93i2c_test_driver=94, whose declarat=
ion is as
follows:

struct i2c_driver i2c_test_driver =3D {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .driver =3D {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =3D "i2c_test",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .id =3D I2C_DRIVERID_OVCA=
MCHIP,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OmniVision CMOS
image sens.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *//* defined in include/li=
nux/i2c-id.h */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .attach_adapter=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D i2c_test_attach_adapter,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .detach_client=A0=A0 =3D =
i2c_test_detach_client,
};
static int __init i2c_test_init(void) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char ret;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_INFO "In i2c_=
test_init\n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D i2c_add_driver(&i=
2c_test_driver);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_INFO "i2c_tes=
t_init ret: %d\n",ret);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
}
Now =93i2c_add_driver()=94 calls to =93i2c_register_driver()=94, residi=
ng in
KERN_SRC/drivers/i2c/i2c_core.c,=20
Inside i2c_register_driver()=94, =93driver_register()=94 is done, but t=
he code
given below is bit complex:

/* now look for instances of driver on our adapters */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (driver->attach_adapte=
r) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 list_for_each(item,&adapters) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 a=
dapter =3D list_entry(item,
struct i2c_adapter, list);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
driver->attach_adapter(adapter);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p=
rintk("In
list_for_each\n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }


So here =93list_for_each(item,&adapters)=94 returns FALSE for me. So my=
 attach
adapter function, =93i2c_test_attach_adapter()=94 is not getting called=
=2E
So I searched where the entry =93adapters=94 is getting a tail added in=
 the
function =93i2c_add_adapter()=94 So the function =93i2c_add_adapter ()=94=
 will be
called by any client driver(as mentioned in comment=85).
I tried by all =93*.ko=94 files in KERN_SRC/drivers/i2c/algos/ but no e=
ffect.
So now to get the full functional I2C chip driver do I need to write a
client driver for it?

Can you please explain what are the minimum needs for the chip driver t=
o be
functional?
And how can I get my driver working?
Thanks for sparing time for me.
Waiting for your reply=85



With Regards,
Uma Kanta Patro
