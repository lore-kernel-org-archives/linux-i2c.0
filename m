From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-xii.c: Use OF instead of platform bus
Date: Thu, 20 May 2010 09:38:51 +0200
Message-ID: <AANLkTikzN_5j1r3D-SFWCkarUmJLtWJz5Yvsu1oFAk1y@mail.gmail.com>
References: <1274117574-1485-1-git-send-email-ricardo.ribalda@gmail.com>
	<20100519225832.GA4041@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100519225832.GA4041-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Richard R??jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Ben

  Thanks for your comments. I thought that xilinx_i2c was used only by
the cpus embedded in the fpga (this is ppc anc microblaze), and those
arches use OF, this is why I moved everything to of_platform.
Unfortunately not only my assumption was wrong (Richard was using the
xi2c with an x86) but also the of_platform bus seems to be almost
deprecated.

  I guess this patch has only sense for people like me, that are using
the xi2c with ppc and don't want to use the horrible driver provided
by xilinx. Nevertheless if the patch gain attention I will correct it,
support platform and of_platform and make your changes.

   Best regards and thanks again

On Thu, May 20, 2010 at 00:58, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Mon, May 17, 2010 at 07:32:54PM +0200, Ricardo Ribalda Delgado wro=
te:
>> Xiic cores are seen on ppc and microblaze arches. Both arches are us=
ing device-trees
>> instead of platform buses to descrive its peripherals.
>>
>> This patch ports i2c-xiic.c from platform bus to OF.
>
> are you really sure that moving to platform device only is
> the right thing to do?
>
>> ---
>> =A0drivers/i2c/busses/i2c-xiic.c | =A0121 ++++++++++++++++++++++----=
---------------
>> =A01 files changed, 64 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-=
xiic.c
>> index a9c419e..62f0ca5 100644
>> --- a/drivers/i2c/busses/i2c-xiic.c
>> +++ b/drivers/i2c/busses/i2c-xiic.c
>> @@ -2,6 +2,7 @@
>> =A0 * i2c-xiic.c
>> =A0 * Copyright (c) 2002-2007 Xilinx Inc.
>> =A0 * Copyright (c) 2009-2010 Intel Corporation
>> + * Copyright (c) 2010 Qtechnology A/S
>> =A0 *
>> =A0 * This program is free software; you can redistribute it and/or =
modify
>> =A0 * it under the terms of the GNU General Public License version 2=
 as
>> @@ -23,6 +24,8 @@
>> =A0 * Mocean Laboratories forked off the GNU/Linux platform work int=
o a
>> =A0 * separate company called Pelagicore AB, which commited the code=
 to the
>> =A0 * kernel.
>> + *
>> + * Ricardo Ribalda: Ported from platform device to device tree (OF)
>> =A0 */
>>
>> =A0/* Supports:
>> @@ -33,13 +36,16 @@
>> =A0#include <linux/init.h>
>> =A0#include <linux/errno.h>
>> =A0#include <linux/delay.h>
>> -#include <linux/platform_device.h>
>> =A0#include <linux/i2c.h>
>> =A0#include <linux/interrupt.h>
>> =A0#include <linux/wait.h>
>> =A0#include <linux/i2c-xiic.h>
>> =A0#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_i2c.h>
>> =A0#include <linux/slab.h>
>> +#include <asm/of_device.h>
>>
>> =A0#define DRIVER_NAME "xiic-i2c"
>>
>> @@ -68,11 +74,14 @@ struct xiic_i2c {
>> =A0 =A0 =A0 struct i2c_adapter =A0 =A0 =A0adap;
>> =A0 =A0 =A0 struct i2c_msg =A0 =A0 =A0 =A0 =A0*tx_msg;
>> =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
>> - =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0tx_pos;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0tx_pos;
> hmm, useles change.
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0nmsgs;
>> =A0 =A0 =A0 enum xilinx_i2c_state =A0 state;
>> =A0 =A0 =A0 struct i2c_msg =A0 =A0 =A0 =A0 =A0*rx_msg;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_pos;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>> + =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 iomem;
>> + =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iolen;
>> =A0};
>>
>>
>> @@ -175,27 +184,27 @@ static void __xiic_start_xfer(struct xiic_i2c =
*i2c);
>>
>> =A0static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8=
 value)
>> =A0{
>> - =A0 =A0 iowrite8(value, i2c->base + reg);
>> + =A0 =A0 out_be32(i2c->base + reg,value);
>> =A0}
>>
>> =A0static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
>> =A0{
>> - =A0 =A0 return ioread8(i2c->base + reg);
>> + =A0 =A0 return in_be32(i2c->base + reg);
>> =A0}
>>
>> =A0static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u=
16 value)
>> =A0{
>> - =A0 =A0 iowrite16(value, i2c->base + reg);
>> + =A0 =A0 out_be32(i2c->base + reg,value);
>> =A0}
>>
>> =A0static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, i=
nt value)
>> =A0{
>> - =A0 =A0 iowrite32(value, i2c->base + reg);
>> + =A0 =A0 out_be32(i2c->base + reg,value);
>> =A0}
>>
>> =A0static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
>> =A0{
>> - =A0 =A0 return ioread32(i2c->base + reg);
>> + =A0 =A0 return in_be32(i2c->base + reg);
>> =A0}
>>
>> =A0static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
>> @@ -362,7 +371,7 @@ static void xiic_process(struct xiic_i2c *i2c)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this is probably a TX error
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->adap.dev.parent, "%s error\n"=
, __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->adap.dev.parent, "%s error\n"=
, __func__);
>
> no, don't change dev_ macros unless ncessary. I expect you'll
> find probling an i2c bus causes floods of htee.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* dynamic mode seem to suffer from prob=
lems if we just flushes
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fifos and the next message is a TX =
with len 0 (only addr)
>> @@ -378,7 +387,7 @@ static void xiic_process(struct xiic_i2c *i2c)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clr =3D XIIC_INTR_RX_FULL_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!i2c->rx_msg) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->adap.dev.pare=
nt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->adap.dev.pare=
nt,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s unex=
pexted RX IRQ\n", __func__);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_clear_rx_fifo(i2c);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> @@ -687,122 +696,120 @@ static struct i2c_adapter xiic_adapter =3D {
>> =A0 =A0 =A0 .algo =A0 =A0 =A0 =A0 =A0 =3D &xiic_algorithm,
>> =A0};
>>
>> -
>> -static int __devinit xiic_i2c_probe(struct platform_device *pdev)
>> +static int __init
> the __devinit change was probably worthwile, but you've wrapped it up
> with a whole pile of other changes.
>
>> +xiic_i2c_probe(struct of_device *op, const struct of_device_id *mat=
ch)
>> =A0{
>> - =A0 =A0 struct xiic_i2c *i2c;
>> - =A0 =A0 struct xiic_i2c_platform_data *pdata;
>> - =A0 =A0 struct resource *res;
>> - =A0 =A0 int ret, irq;
>> - =A0 =A0 u8 i;
>> -
>> - =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> - =A0 =A0 if (!res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>> -
>> - =A0 =A0 irq =3D platform_get_irq(pdev, 0);
>> - =A0 =A0 if (irq < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>>
>> - =A0 =A0 pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.plat=
form_data;
>> - =A0 =A0 if (!pdata)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 struct xiic_i2c *i2c;
>> + =A0 =A0 struct resource mem;
>> + =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
>> =A0 =A0 =A0 if (!i2c)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>
>> - =A0 =A0 if (!request_mem_region(res->start, resource_size(res), pd=
ev->name)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Memory region busy\n"=
);
>> + =A0 =A0 i2c->irq=3Dirq_of_parse_and_map(op->node,0);
>> + =A0 =A0 if (!i2c->irq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>> +
>> + =A0 =A0 if (of_address_to_resource(op->node,0,&mem))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>> + =A0 =A0 i2c->iomem=3Dmem.start;
>> + =A0 =A0 i2c->iolen=3Dmem.end-mem.start+1;
>
> use resource_size()
>
>> + =A0 =A0 if (!request_mem_region(i2c->iomem, i2c->iolen, DRIVER_NAM=
E)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Memory region busy\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto request_mem_failed;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 i2c->base =3D ioremap(res->start, resource_size(res));
>> + =A0 =A0 i2c->base =3D ioremap(i2c->iomem, i2c->iolen);
>> =A0 =A0 =A0 if (!i2c->base) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to map registe=
rs\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Unable to map registers=
\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto map_failed;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* hook up driver to tree */
>> - =A0 =A0 platform_set_drvdata(pdev, i2c);
>> + =A0 =A0 dev_set_drvdata(&op->dev, i2c);
>> =A0 =A0 =A0 i2c->adap =3D xiic_adapter;
>> =A0 =A0 =A0 i2c_set_adapdata(&i2c->adap, i2c);
>> - =A0 =A0 i2c->adap.dev.parent =3D &pdev->dev;
>> + =A0 =A0 i2c->adap.dev.parent =3D &op->dev;
>>
>> =A0 =A0 =A0 xiic_reinit(i2c);
>>
>> =A0 =A0 =A0 spin_lock_init(&i2c->lock);
>> =A0 =A0 =A0 init_waitqueue_head(&i2c->wait);
>> - =A0 =A0 ret =3D request_irq(irq, xiic_isr, 0, pdev->name, i2c);
>> + =A0 =A0 ret =3D request_irq(i2c->irq, xiic_isr, 0, DRIVER_NAME, i2=
c);
>> =A0 =A0 =A0 if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot claim IRQ\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Cannot claim IRQ\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto request_irq_failed;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* add i2c adapter to i2c tree */
>> + =A0 =A0 i2c->adap.id=3D0;
>> =A0 =A0 =A0 ret =3D i2c_add_adapter(&i2c->adap);
>> =A0 =A0 =A0 if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to add adapter=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Failed to add adapter\n=
");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto add_adapter_failed;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /* add in known devices to the bus */
>> - =A0 =A0 for (i =3D 0; i < pdata->num_devices; i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 i2c_new_device(&i2c->adap, pdata->devices =
+ i);
>> + =A0 =A0 of_register_i2c_devices(&i2c->adap, op->node);
>>
>> =A0 =A0 =A0 return 0;
>>
>> =A0add_adapter_failed:
>> - =A0 =A0 free_irq(irq, i2c);
>> + =A0 =A0 free_irq(i2c->irq, i2c);
>> =A0request_irq_failed:
>> =A0 =A0 =A0 xiic_deinit(i2c);
>> =A0 =A0 =A0 iounmap(i2c->base);
>> =A0map_failed:
>> - =A0 =A0 release_mem_region(res->start, resource_size(res));
>> + =A0 =A0 release_mem_region(i2c->iomem, i2c->iolen);
>> =A0request_mem_failed:
>> - =A0 =A0 kfree(i2c);
>>
>> =A0 =A0 =A0 return ret;
>> =A0resource_missing:
>> - =A0 =A0 dev_err(&pdev->dev, "IRQ or Memory resource is missing\n")=
;
>> + =A0 =A0 kfree(i2c);
>> + =A0 =A0 dev_err(&op->dev, "IRQ or Memory resource is missing\n");
>> =A0 =A0 =A0 return -ENOENT;
>> =A0}
>>
>> -static int __devexit xiic_i2c_remove(struct platform_device* pdev)
>> +
>> +static int __devexit xiic_i2c_remove(struct of_device *op)
>> =A0{
>> - =A0 =A0 struct xiic_i2c *i2c =3D platform_get_drvdata(pdev);
>> - =A0 =A0 struct resource *res;
>> + =A0 =A0 struct xiic_i2c *i2c =3D dev_get_drvdata(&op->dev);
>>
>> =A0 =A0 =A0 /* remove adapter & data */
>> =A0 =A0 =A0 i2c_del_adapter(&i2c->adap);
>>
>> =A0 =A0 =A0 xiic_deinit(i2c);
>>
>> - =A0 =A0 platform_set_drvdata(pdev, NULL);
>> + =A0 =A0 dev_set_drvdata(&op->dev, NULL);
>>
>> - =A0 =A0 free_irq(platform_get_irq(pdev, 0), i2c);
>> + =A0 =A0 free_irq(i2c->irq, i2c);
>>
>> =A0 =A0 =A0 iounmap(i2c->base);
>>
>> - =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> - =A0 =A0 if (res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, resource_si=
ze(res));
>> + =A0 =A0 release_mem_region(i2c->iomem, i2c->iolen);
>>
>> =A0 =A0 =A0 kfree(i2c);
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +/* Match table for of_platform binding */
>> + static struct of_device_id __devinitdata xiic_match[] =3D {
>> + =A0 =A0 { .compatible =3D "xlnx,xps-iic-2.00.a", },
>> + =A0 =A0 {},
>> + };
>>
>> -/* work with hotplug and coldplug */
>> -MODULE_ALIAS("platform:"DRIVER_NAME);
>> +MODULE_DEVICE_TABLE(of, xiic_of_match);
>>
>> -static struct platform_driver xiic_i2c_driver =3D {
>> +static struct of_platform_driver xiic_i2c_of_driver =3D {
>> + =A0 =A0 .match_table =3D xiic_match,
>> =A0 =A0 =A0 .probe =A0 =3D xiic_i2c_probe,
>> =A0 =A0 =A0 .remove =A0=3D __devexit_p(xiic_i2c_remove),
>> - =A0 =A0 .driver =A0=3D {
>> + =A0 =A0 .driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DRIVER_NAME,
>> =A0 =A0 =A0 },
>> @@ -810,12 +817,12 @@ static struct platform_driver xiic_i2c_driver =
=3D {
>>
>> =A0static int __init xiic_i2c_init(void)
>> =A0{
>> - =A0 =A0 return platform_driver_register(&xiic_i2c_driver);
>> + =A0 =A0 return of_register_platform_driver(&xiic_i2c_of_driver);
>> =A0}
>>
>> =A0static void __exit xiic_i2c_exit(void)
>> =A0{
>> - =A0 =A0 platform_driver_unregister(&xiic_i2c_driver);
>> + =A0 =A0 of_unregister_platform_driver(&xiic_i2c_of_driver);
>> =A0}
>>
>> =A0module_init(xiic_i2c_init);
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>
> =A0'a smiley only costs 4 bytes'
>



--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
