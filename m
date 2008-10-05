From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-stub
Date: Sun, 5 Oct 2008 13:28:58 +0200
Message-ID: <20081005132858.53857377@hyperion.delvare>
References: <aea25fc40810021503i13ea57cal183a7bf9bc88e351@mail.gmail.com>
	<20081003095647.5fb7f0de@hyperion.delvare>
	<aea25fc40810031007i6a6fe090w64d0e4d8ecacb285@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <aea25fc40810031007i6a6fe090w64d0e4d8ecacb285-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: naitik amin <greatamin1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 3 Oct 2008 13:07:00 -0400, naitik amin wrote:
> Please see my responses below (in bold).

It would help if you could just send plain text e-mails and use the
standard quoting format. You current method is a complete mess and this
is the last time I'm going through it. I have better things to do with
my time than reformatting e-mail quotes.

> On Fri, Oct 3, 2008 at 3:56 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> 
> > On Thu, 2 Oct 2008 18:03:35 -0400, naitik amin wrote:
> > > I was trying to use the i2c-stub driver.
> > >
> > > What I did was I hardcoded the address to 0x23 and inserted the
> > > i2c-stub.ko
> >
> > Hard-coded? How, and why? The address is supposed to be passed as a
> > module parameter:
> >
> > modprobe i2c-stub chip_addr=0x23
> 
> I did it this way because doing insmod with argument gave me an
> error.
>
>  insmod i2c-stub.ko chip_addr=0x23
>  insmod: init_module 'i2c-stub.ko' failed (No such device)
> This is may be because I am using Android Goldfish environment. So just to
> go around I hardcoded it.
> 
> > > I then inserted ds1682.ko also part of the 2.6 kernel.
> >
> > Which kernel version exactly?
>
> 2.6.25

"insmod i2c-stub.ko chip_addr=0x23" should work just fine on a 2.6.25
kernel (although I'm not sure why you insist on using insmod when
modprobe is so much more convenient.) Do you have any message in the
logs when you load the i2c-stub driver? It should only return -ENODEV
if no chip_addr parameter was passed.

If such a simply thing doesn't work then I have a serious doubt on your
"Android Goldfish environment". Or you did some mistake when typing the
command.

> > > I was hoping to see that the probe function for ds1682.ko to be called
> > > but it didn't.  Can someone comment on what I maybe missing.
> >
> > The ds1682 driver is a new-style driver, it doesn't scan the adapters
> > for devices. Instead, kernel code must explicitly instantiate the
> > devices. Alternatively, we could add a mechanism to instantiate devices
> > from user-space, but it's not there yet.
> >
> > I don't think you will get it to work anyway, because the ds1682 driver
> > makes use of I2C block transactions, which i2c-stub doesn't support
> > yet. So you would have to add support for I2C block transactions first.

I can only reiterate what I wrote here...

> > > Oh and BTW I did change the i2c_board_info by calling
> > > i2c_register_board_info in machine level init. The parameters that I had
> > > here were "ds1362" for driver name and 0x23 for address.
> >
> > "ds1362"? The only device supported by the ds1682 driver is "ds1682".
> > But the way I2C devices are matched changed recently, so it really
> > depends on what exact kernel version you are using.
> >
> > Anyway, what are you trying to achieve in the first place?
>
> What I am trying to achieve is to automatically instantiate a i2c
> device from the board level init (something that you mentioned is not there
> yet). So thats what I was trying to do, correct me if I am wrong here, I am
> new to this architecture, but what my understanding is,
>
>    - under new style drivers, you have to populate i2c_board_info struct
>    and when i2c_new_device gets called creates it the i2c_client stance.
>    - so in order to add "ds1682" to i2c_board_info I did
>
>         struct i2c_board_info __initdata goldfish_i2c_devices[] =
>         {
>             {
>                 I2C_BOARD_INFO("ds1682", 0x23),
>             }
>         };
> 
>         static void __init goldfish_init(void)
>         {
>              platform_device_register(&goldfish_pdev_bus_device);
>              platform_device_register(&goldfish_vms_device);
>              /* I2C */
>              //goldfish_add_device_i2c(goldfish_i2c_devices, ARRAY_SIZE(goldfish_i2c_devices));
>              i2c_register_board_info(0, goldfish_i2c_devices, ARRAY_SIZE(goldfish_i2c_devices));
>         }
> 
>         goldfish_init is called as a part of the board level init (init_machine)

This is not going to work. The above asks for a ds1682 chip to be
created at 0x23 on i2c bus 0. However, i2c-stub will not get bus number
0, because it doesn't ask for a specific bus number and thus gets the
first available dynamic bus number (which will most likely be 1 in your
case.)

>    - So now with my i2c_board_info populated with ds1682, i modified
>    i2c-stub.c to hardcode it to 0x23 and inserted i2c-stub.ko
>
>    - looking at the code for i2c-stub.c, its init fn calls
>    i2c_add_adapter, it goes then goes through the i2c_board_info list and
>    should find "ds1682" and should go through source below

You would need to change i2c-stub to use i2c_add_numbered_adapter (with
bus number 0) instead of i2c_add_adapter.

>
>    - i2c_add_adapter-->i2c_register_adapter-->i2c_scan_static_board_info-->i2c_new_device-->
>    i2c_attach_client
>
>    - So it should create a new i2c_client and attach to it.
>
> Is is a right way to do things ? Please let me know.

You told us what you tried, but you still didn't tell us what you were
trying to achieve. Why do you want to use i2c-stub in the first place?
What is your goal? What problem are you trying to solve?

The typical scenario for using i2c-stub is as follows:

* Load i2c-stub with a given chip address.
* Load i2c-dev.
* Use i2cset to program the fake chip.
* Load an i2c chip driver, either old-style or new-style with the
  "detect" callback implemented, in the hope that it will identify the
  fake device as something it supports and bind to it.

The goal of this approach is to perform some tests on the i2c chip
driver in question. This works reasonably well with standalone drivers
such as hwmon drivers or eeprom. For example, I frequently use it to
check that new hwmon drivers implement a sysfs interface which complies
with the standard.

You are trying to use i2c-stub with a new-style i2c device, which is
created early during the boot process. This is different from what
i2c-stub was designed for. Even if you modify the code to fix the two
problems mentioned above, if the chip driver (ds1682 in your case) is
built into the kernel, then the binding will happen before you have a
chance to program the fake chip using i2c-dev and i2cset. You can still
program it afterwards but this may confuse the driver.

If you explained clearly what you want to do, we could figure out if
i2c-stub is the right tool for you. And if it is, we could discuss how
to improve it so that it works for you. But at this point I'm not
really sure.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
