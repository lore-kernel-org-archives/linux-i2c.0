From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dynamically-allocated i2c_device_id vs MODULE_DEVICE_TABLE
Date: Fri, 23 Jan 2009 17:26:50 -0500
Message-ID: <9e4733910901231426t7487ad12k5725168a06c36fb9@mail.gmail.com>
References: <497A3097.1030808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <497A3097.1030808-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 23, 2009 at 4:03 PM, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> I currently have this in my code:

I'm not sure what you are trying to achieve. The id table has one
entry per chip. It is static data, all instances of the chip should
have the same ID entry.

Look at drivers/of_i2c.c and how it passed in dynamic data.

Also, I just added of_find_i2c_device_by_node() so you can follow
references in the device tree.
i2s driver loads and uses the codec-handle to locate the i2c entry.

                i2s@2200 { /* PSC2 in i2s mode */
                        compatible =
"fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
                        cell-index = <1>;
                        reg = <0x2200 0x100>;
                        interrupts = <0x2 0x2 0x0>;
                        interrupt-parent = <&mpc5200_pic>;
                        codec-handle = <&tas0>;
                };

               i2c@3d00 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        compatible =
"fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
                        cell-index = <0>;
                        reg = <0x3d00 0x40>;
                        interrupts = <0x2 0xf 0x0>;
                        interrupt-parent = <&mpc5200_pic>;
                        fsl5200-clocking;

                        tas0:codec@1b {
                                compatible = "ti,tas5504";
                                reg = <0x1b>;
                        };
                        clock0:clock@68 {
                                compatible = "maxim,max9485";
                                reg = <0x68>;
                        };
                };


>
> static const struct i2c_device_id cs4270_id[] = {
>        {"cs4270", 0},
>        {}
> };
> MODULE_DEVICE_TABLE(i2c, cs4270_id);
>
> static struct i2c_driver cs4270_i2c_driver = {
>        .driver = {
>                .name = "cs4270",
>                .owner = THIS_MODULE,
>        },
>        .id_table = cs4270_id,
>        .probe = cs4270_i2c_probe,
>        .remove = cs4270_i2c_remove,
> };
>
> ret = i2c_add_driver(&cs4270_i2c_driver);
>
> I would like to use the i2c_device_id.driver_data variable to pass private data
> to my cs4270_i2c_probe() function.  So it will look like this:
>
>        socdev = kmalloc(...);
>        c24270_id.driver_data = socdev;
>        i2c_add_driver(&cs4270_i2c_driver);
>
> And then in my cs4270_i2c_probe(), I would do this:
>
> static int cs4270_i2c_probe(struct i2c_client *i2c_client,
>        const struct i2c_device_id *id)
> {
>        struct X *socdev = (struct X *) id->driver_data.
>
> The problem I'm having is the MODULE_DEVICE_TABLE.  What I really should be
> doing is this:
>
>        socdev = kmalloc(...);
>        struct i2c_driver *cs4270_i2c_driver = kmalloc(...);
>        struct i2c_device_id *cs4270_id = kmalloc(...);
>        cs4270_i2c_driver->id_table = cs4270_id;
>        c24270_id->driver_data = socdev;
>        i2c_add_driver(cs4270_i2c_driver);
>
> But if I do this, then I can't use MODULE_DEVICE_TABLE.  So I have two questions:
>
> 1) What happens if I don't use MODULE_DEVICE_TABLE to identify my I2C ID table?
>
> 2) Is there a way to mimic the behavior of MODULE_DEVICE_TABLE on a
> dynamically-created ID table?
>
> --
> Timur Tabi
> Linux kernel developer at Freescale
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
