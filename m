From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-xii.c: Use OF instead of platform bus
Date: Mon, 17 May 2010 20:45:14 +0200
Message-ID: <AANLkTik9hCEhCFd9ku6m1SkTz45q6JwxxLUgBjLMOV-0@mail.gmail.com>
References: <1274117574-1485-1-git-send-email-ricardo.ribalda@gmail.com>
	<4BF18D47.2030809@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BF18D47.2030809-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Richard

  Sorry, I did not think in scenarios as you expose, what a strange
device you have :). Let me be curious: what kind of bus is between the
fpga (xps/plb) and the x86?

Of course we can have a more flexible patch, let me think about the
best (clean) way to implement it.

        Best regards and thanks for your comment

On Mon, May 17, 2010 at 20:39, Richard R=F6jfors
<richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org> wrote:
> On 05/17/2010 07:32 PM, Ricardo Ribalda Delgado wrote:
>>
>> Xiic cores are seen on ppc and microblaze arches. Both arches are us=
ing
>> device-trees
>> instead of platform buses to descrive its peripherals.
>
> We have the XIIC exposed as a platform device by a MFD driver on X86.
>
> I think the patch must be more flexible to allow both platform an of
> devices.
>
> --Richard
>
>>
>> This patch ports i2c-xiic.c from platform bus to OF.
>>
>> ---
>> =A0drivers/i2c/busses/i2c-xiic.c | =A0121
>> ++++++++++++++++++++++-------------------
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
>> =A0#include<linux/init.h>
>> =A0#include<linux/errno.h>
>> =A0#include<linux/delay.h>
>> -#include<linux/platform_device.h>
>> =A0#include<linux/i2c.h>
>> =A0#include<linux/interrupt.h>
>> =A0#include<linux/wait.h>
>> =A0#include<linux/i2c-xiic.h>
>> =A0#include<linux/io.h>
>> +#include<linux/of.h>
>> +#include<linux/of_platform.h>
>> +#include<linux/of_i2c.h>
>> =A0#include<linux/slab.h>
>> +#include<asm/of_device.h>
>>
>> =A0#define DRIVER_NAME "xiic-i2c"
>>
>> @@ -68,11 +74,14 @@ struct xiic_i2c {
>> =A0 =A0 =A0 =A0struct i2c_adapter =A0 =A0 =A0adap;
>> =A0 =A0 =A0 =A0struct i2c_msg =A0 =A0 =A0 =A0 =A0*tx_msg;
>> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
>> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0tx_pos;
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0tx_pos;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0nmsgs;
>> =A0 =A0 =A0 =A0enum xilinx_i2c_state =A0 state;
>> =A0 =A0 =A0 =A0struct i2c_msg =A0 =A0 =A0 =A0 =A0*rx_msg;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_pos;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 iomem;
>> + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iolen;
>> =A0};
>>
>>
>> @@ -175,27 +184,27 @@ static void __xiic_start_xfer(struct xiic_i2c =
*i2c);
>>
>> =A0static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8=
 value)
>> =A0{
>> - =A0 =A0 =A0 iowrite8(value, i2c->base + reg);
>> + =A0 =A0 =A0 out_be32(i2c->base + reg,value);
>> =A0}
>>
>> =A0static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
>> =A0{
>> - =A0 =A0 =A0 return ioread8(i2c->base + reg);
>> + =A0 =A0 =A0 return in_be32(i2c->base + reg);
>> =A0}
>>
>> =A0static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u=
16
>> value)
>> =A0{
>> - =A0 =A0 =A0 iowrite16(value, i2c->base + reg);
>> + =A0 =A0 =A0 out_be32(i2c->base + reg,value);
>> =A0}
>>
>> =A0static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, i=
nt
>> value)
>> =A0{
>> - =A0 =A0 =A0 iowrite32(value, i2c->base + reg);
>> + =A0 =A0 =A0 out_be32(i2c->base + reg,value);
>> =A0}
>>
>> =A0static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
>> =A0{
>> - =A0 =A0 =A0 return ioread32(i2c->base + reg);
>> + =A0 =A0 =A0 return in_be32(i2c->base + reg);
>> =A0}
>>
>> =A0static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
>> @@ -362,7 +371,7 @@ static void xiic_process(struct xiic_i2c *i2c)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * this is probably a TX error
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->adap.dev.parent, "%s erro=
r\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->adap.dev.parent, "%s erro=
r\n", __func__);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* dynamic mode seem to suffer from p=
roblems if we just
>> flushes
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * fifos and the next message is a TX=
 with len 0 (only
>> addr)
>> @@ -378,7 +387,7 @@ static void xiic_process(struct xiic_i2c *i2c)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clr =3D XIIC_INTR_RX_FULL_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!i2c->rx_msg) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->adap.dev.=
parent,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->adap.dev.=
parent,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s u=
nexpexted RX IRQ\n", __func__);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xiic_clear_rx_fifo(i2=
c);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>> @@ -687,122 +696,120 @@ static struct i2c_adapter xiic_adapter =3D {
>> =A0 =A0 =A0 =A0.algo =A0 =A0 =A0 =A0 =A0 =3D&xiic_algorithm,
>> =A0};
>>
>> -
>> -static int __devinit xiic_i2c_probe(struct platform_device *pdev)
>> +static int __init
>> +xiic_i2c_probe(struct of_device *op, const struct of_device_id *mat=
ch)
>> =A0{
>> - =A0 =A0 =A0 struct xiic_i2c *i2c;
>> - =A0 =A0 =A0 struct xiic_i2c_platform_data *pdata;
>> - =A0 =A0 =A0 struct resource *res;
>> - =A0 =A0 =A0 int ret, irq;
>> - =A0 =A0 =A0 u8 i;
>> -
>> - =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
>> - =A0 =A0 =A0 if (!res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>> -
>> - =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
>> - =A0 =A0 =A0 if (irq< =A00)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>>
>> - =A0 =A0 =A0 pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.=
platform_data;
>> - =A0 =A0 =A0 if (!pdata)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 struct xiic_i2c *i2c;
>> + =A0 =A0 =A0 struct resource mem;
>> + =A0 =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 =A0i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
>> =A0 =A0 =A0 =A0if (!i2c)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>>
>> - =A0 =A0 =A0 if (!request_mem_region(res->start, resource_size(res)=
,
>> pdev->name)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Memory region bus=
y\n");
>> + =A0 =A0 =A0 i2c->irq=3Dirq_of_parse_and_map(op->node,0);
>> + =A0 =A0 =A0 if (!i2c->irq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>> +
>> + =A0 =A0 =A0 if (of_address_to_resource(op->node,0,&mem))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto resource_missing;
>> + =A0 =A0 =A0 i2c->iomem=3Dmem.start;
>> + =A0 =A0 =A0 i2c->iolen=3Dmem.end-mem.start+1;
>> +
>> + =A0 =A0 =A0 if (!request_mem_region(i2c->iomem, i2c->iolen, DRIVER=
_NAME)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Memory region busy\=
n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EBUSY;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto request_mem_failed;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 i2c->base =3D ioremap(res->start, resource_size(res));
>> + =A0 =A0 =A0 i2c->base =3D ioremap(i2c->iomem, i2c->iolen);
>> =A0 =A0 =A0 =A0if (!i2c->base) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to map reg=
isters\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Unable to map regis=
ters\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EIO;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto map_failed;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* hook up driver to tree */
>> - =A0 =A0 =A0 platform_set_drvdata(pdev, i2c);
>> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, i2c);
>> =A0 =A0 =A0 =A0i2c->adap =3D xiic_adapter;
>> =A0 =A0 =A0 =A0i2c_set_adapdata(&i2c->adap, i2c);
>> - =A0 =A0 =A0 i2c->adap.dev.parent =3D&pdev->dev;
>> + =A0 =A0 =A0 i2c->adap.dev.parent =3D&op->dev;
>>
>> =A0 =A0 =A0 =A0xiic_reinit(i2c);
>>
>> =A0 =A0 =A0 =A0spin_lock_init(&i2c->lock);
>> =A0 =A0 =A0 =A0init_waitqueue_head(&i2c->wait);
>> - =A0 =A0 =A0 ret =3D request_irq(irq, xiic_isr, 0, pdev->name, i2c)=
;
>> + =A0 =A0 =A0 ret =3D request_irq(i2c->irq, xiic_isr, 0, DRIVER_NAME=
, i2c);
>> =A0 =A0 =A0 =A0if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot claim IRQ\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Cannot claim IRQ\n"=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto request_irq_failed;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* add i2c adapter to i2c tree */
>> + =A0 =A0 =A0 i2c->adap.id=3D0;
>> =A0 =A0 =A0 =A0ret =3D i2c_add_adapter(&i2c->adap);
>> =A0 =A0 =A0 =A0if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to add ada=
pter\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Failed to add adapt=
er\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto add_adapter_failed;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 /* add in known devices to the bus */
>> - =A0 =A0 =A0 for (i =3D 0; i< =A0pdata->num_devices; i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_new_device(&i2c->adap, pdata->devi=
ces + i);
>> + =A0 =A0 =A0 of_register_i2c_devices(&i2c->adap, op->node);
>>
>> =A0 =A0 =A0 =A0return 0;
>>
>> =A0add_adapter_failed:
>> - =A0 =A0 =A0 free_irq(irq, i2c);
>> + =A0 =A0 =A0 free_irq(i2c->irq, i2c);
>> =A0request_irq_failed:
>> =A0 =A0 =A0 =A0xiic_deinit(i2c);
>> =A0 =A0 =A0 =A0iounmap(i2c->base);
>> =A0map_failed:
>> - =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
>> + =A0 =A0 =A0 release_mem_region(i2c->iomem, i2c->iolen);
>> =A0request_mem_failed:
>> - =A0 =A0 =A0 kfree(i2c);
>>
>> =A0 =A0 =A0 =A0return ret;
>> =A0resource_missing:
>> - =A0 =A0 =A0 dev_err(&pdev->dev, "IRQ or Memory resource is missing=
\n");
>> + =A0 =A0 =A0 kfree(i2c);
>> + =A0 =A0 =A0 dev_err(&op->dev, "IRQ or Memory resource is missing\n=
");
>> =A0 =A0 =A0 =A0return -ENOENT;
>> =A0}
>>
>> -static int __devexit xiic_i2c_remove(struct platform_device* pdev)
>> +
>> +static int __devexit xiic_i2c_remove(struct of_device *op)
>> =A0{
>> - =A0 =A0 =A0 struct xiic_i2c *i2c =3D platform_get_drvdata(pdev);
>> - =A0 =A0 =A0 struct resource *res;
>> + =A0 =A0 =A0 struct xiic_i2c *i2c =3D dev_get_drvdata(&op->dev);
>>
>> =A0 =A0 =A0 =A0/* remove adapter& =A0data */
>> =A0 =A0 =A0 =A0i2c_del_adapter(&i2c->adap);
>>
>> =A0 =A0 =A0 =A0xiic_deinit(i2c);
>>
>> - =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, NULL);
>>
>> - =A0 =A0 =A0 free_irq(platform_get_irq(pdev, 0), i2c);
>> + =A0 =A0 =A0 free_irq(i2c->irq, i2c);
>>
>> =A0 =A0 =A0 =A0iounmap(i2c->base);
>>
>> - =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
>> - =A0 =A0 =A0 if (res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, resourc=
e_size(res));
>> + =A0 =A0 =A0 release_mem_region(i2c->iomem, i2c->iolen);
>>
>> =A0 =A0 =A0 =A0kfree(i2c);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> +/* Match table for of_platform binding */
>> + static struct of_device_id __devinitdata xiic_match[] =3D {
>> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-iic-2.00.a", },
>> + =A0 =A0 =A0 {},
>> + };
>>
>> -/* work with hotplug and coldplug */
>> -MODULE_ALIAS("platform:"DRIVER_NAME);
>> +MODULE_DEVICE_TABLE(of, xiic_of_match);
>>
>> -static struct platform_driver xiic_i2c_driver =3D {
>> +static struct of_platform_driver xiic_i2c_of_driver =3D {
>> + =A0 =A0 =A0 .match_table =3D xiic_match,
>> =A0 =A0 =A0 =A0.probe =A0 =3D xiic_i2c_probe,
>> =A0 =A0 =A0 =A0.remove =A0=3D __devexit_p(xiic_i2c_remove),
>> - =A0 =A0 =A0 .driver =A0=3D {
>> + =A0 =A0 =A0 .driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D DRIVER_NAME,
>> =A0 =A0 =A0 =A0},
>> @@ -810,12 +817,12 @@ static struct platform_driver xiic_i2c_driver =
=3D {
>>
>> =A0static int __init xiic_i2c_init(void)
>> =A0{
>> - =A0 =A0 =A0 return platform_driver_register(&xiic_i2c_driver);
>> + =A0 =A0 =A0 return of_register_platform_driver(&xiic_i2c_of_driver=
);
>> =A0}
>>
>> =A0static void __exit xiic_i2c_exit(void)
>> =A0{
>> - =A0 =A0 =A0 platform_driver_unregister(&xiic_i2c_driver);
>> + =A0 =A0 =A0 of_unregister_platform_driver(&xiic_i2c_of_driver);
>> =A0}
>>
>> =A0module_init(xiic_i2c_init);
>



--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
