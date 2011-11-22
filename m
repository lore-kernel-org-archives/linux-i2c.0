From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Waiting until probe of i2c driver is done
Date: Tue, 22 Nov 2011 14:09:02 +0100
Message-ID: <CAH9NwWfev2DWQpNj=4Hb55DOK-_i=U24uB=aawszakeAGPC6qw@mail.gmail.com>
References: <CAH9NwWdLH32zMqzr8qsEb-HaW9sBAGHxHiBVdpTdhGsnjzwQZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAH9NwWdLH32zMqzr8qsEb-HaW9sBAGHxHiBVdpTdhGsnjzwQZg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Okay...

I found a solution, but it feels more like a hack :)
I am using the setup callback of the pca953x driver to register
all needed platform devices. Is there a better way?


thanks
--
Christian Gmeiner, MSc



2011/11/22 Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi ml,
>
> I run into a little problem, which I don't know how to solve it.
> I am using the eg20t i2c bus and a custom platform init
> driver, which gets started after eg20t is ready.
>
> And there I do the following:
>
> /* buzzer and relay */
> static struct gpio_led _gpio[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D "rel=
ay",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio =3D 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.active_low =3D=
 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.default_state=
 =3D LEDS_GPIO_DEFSTATE_OFF,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.default_trigg=
er =3D "timer",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> };
>
> static struct gpio_led_platform_data _gpio_data =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_leds =3D ARRAY_SIZE(_gpio),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.leds =3D _gpio,
> };
>
> static struct platform_device _gpio_hw =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D "leds-gpio",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev.platform_data =3D &_gpio_data,
> };
>
> static struct platform_device *devices_tc[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&ot1300_gpio_hw,
> };
>
>
> int tunnelcreek_init(void)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_adapter *i2c_adap;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we use the integrated i2c adapter */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_adap =3D i2c_get_adapter(0);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_adap)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eeprom =3D =C2=A0i2c_new_device(i2c_adap, =
&i2c_eeprom);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pca953x =3D i2c_new_device(i2c_adap, &pca9=
555_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0lm75 =3D i2c_new_device(i2c_adap, &lm75_in=
fo);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_add_devices(devices_tc, ARRAY_SIZ=
E(devices_tc));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> }
>
> If I run this code I get following messages:
>
> [ =C2=A0 =C2=A01.552122] i2c 0-0050: uevent
> [ =C2=A0 =C2=A01.552307] at24 0-0050: probe
> [ =C2=A0 =C2=A01.552361] i2c 0-0051: uevent
> [ =C2=A0 =C2=A01.552530] dummy 0-0051: probe
> [ =C2=A0 =C2=A01.552544] i2c i2c-0: client [dummy] registered with bu=
s id 0-0051
> [ =C2=A0 =C2=A01.552559] at24 0-0050: 512 byte 24c04 EEPROM, writable=
, 16 bytes/write
> [ =C2=A0 =C2=A01.552644] i2c i2c-0: master_xfer[0] W, addr=3D0x50, le=
n=3D1
> [ =C2=A0 =C2=A01.552655] i2c i2c-0: master_xfer[1] R, addr=3D0x50, le=
n=3D24
> [ =C2=A0 =C2=A01.557235] i2c i2c-0: master_xfer[0] W, addr=3D0x51, le=
n=3D1
> [ =C2=A0 =C2=A01.557248] i2c i2c-0: master_xfer[1] R, addr=3D0x51, le=
n=3D20
> [ =C2=A0 =C2=A01.560820] i2c i2c-0: client [24c04] registered with bu=
s id 0-0050
> [ =C2=A0 =C2=A01.560944] i2c 0-0021: uevent
> [ =C2=A0 =C2=A01.561136] i2c i2c-0: client [pca9555] registered with =
bus id 0-0021
> [ =C2=A0 =C2=A01.561197] i2c 0-0048: uevent
> [ =C2=A0 =C2=A01.561357] i2c i2c-0: client [lm75] registered with bus=
 id 0-0048
> [ =C2=A0 =C2=A01.561638] leds-gpio: probe of leds-gpio.0 failed with =
error -22
> [ =C2=A0 =C2=A01.568354] VFS: Mounted root (ext2 filesystem) readonly=
 on device 8:2.
> [ =C2=A0 =C2=A01.569161] devtmpfs: mounted
> [ =C2=A0 =C2=A01.569307] Freeing unused kernel memory: 284k freed
> [ =C2=A0 =C2=A01.569725] Write protecting the kernel text: 2096k
> [ =C2=A0 =C2=A01.569880] Write protecting the kernel read-only data: =
1008k
> [ =C2=A0 =C2=A01.577121] hub 1-1:1.0: USB hub found
> [ =C2=A0 =C2=A01.579246] hub 1-1:1.0: 3 ports detected
> [ =C2=A0 =C2=A01.795723] udev[1136]: starting version 164
> [ =C2=A0 =C2=A01.951100] usb 5-1: new low speed USB device number 2 u=
sing ohci_hcd
> [ =C2=A0 =C2=A01.968166] i2c 0-0021: uevent
> [ =C2=A0 =C2=A01.968284] i2c 0-0048: uevent
> [ =C2=A0 =C2=A01.968400] at24 0-0050: uevent
> [ =C2=A0 =C2=A01.968510] dummy 0-0051: uevent
> [ =C2=A0 =C2=A02.206885] i2c 0-0021: uevent
> [ =C2=A0 =C2=A02.208069] i2c 0-0048: uevent
> [ =C2=A0 =C2=A02.209305] at24 0-0050: uevent
> [ =C2=A0 =C2=A02.209928] at24 0-0050: uevent
> [ =C2=A0 =C2=A02.210459] dummy 0-0051: uevent
> [ =C2=A0 =C2=A02.211089] dummy 0-0051: uevent
> [ =C2=A0 =C2=A02.245582] pca953x 0-0021: probe
> [ =C2=A0 =C2=A02.245607] i2c i2c-0: master_xfer[0] W, addr=3D0x21, le=
n=3D1
> [ =C2=A0 =C2=A02.245624] i2c i2c-0: master_xfer[1] R, addr=3D0x21, le=
n=3D2
> [ =C2=A0 =C2=A02.250589] i2c i2c-0: master_xfer[0] W, addr=3D0x21, le=
n=3D1
> [ =C2=A0 =C2=A02.250607] i2c i2c-0: master_xfer[1] R, addr=3D0x21, le=
n=3D2
> [ =C2=A0 =C2=A02.251338] i2c i2c-0: master_xfer[0] W, addr=3D0x21, le=
n=3D3
> [ =C2=A0 =C2=A02.251900] pca953x 0-0021: interrupt support not compil=
ed in
> [ =C2=A0 =C2=A02.252236] i2c-core: driver [pca953x] registered
> [
>
> The problem is that leds-gpio gets loaded before pca953x driver
> is ready. So no gpio's are available. Whats the best way to fix this?
>
> Thanks
> --
> Christian Gmeiner, MSc
>
