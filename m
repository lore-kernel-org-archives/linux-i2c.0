From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: nvmem: at24: Provide an EEPROM framework interface
Date: Thu, 17 Sep 2015 17:55:28 +0300
Message-ID: <8A1214E9-A452-4DDA-8CFE-6C6EC940FB81@konsulko.com>
References: <1442419884-5060-1-git-send-email-pantelis.antoniou@konsulko.com> <CAMpxmJXXoWZ+585ikSprLx-yyBp-rXxiQfP7Nr2kMV3eK3E0VQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMpxmJXXoWZ+585ikSprLx-yyBp-rXxiQfP7Nr2kMV3eK3E0VQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bartosz,

> On Sep 17, 2015, at 17:42 , Bartosz Golaszewski <bgolaszewski@baylibr=
e.com> wrote:
>=20
> 2015-09-16 18:11 GMT+02:00 Pantelis Antoniou <pantelis.antoniou@konsu=
lko.com>:
>> For DT and in-kernel users there is no interface to the
>> at24 EEPROMs so provide an NVMEM framework interface.
>>=20
>> This allows us to use AT24 based EEPROMs and reference them
>> from within the DT tree.
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>> ---
>> drivers/misc/eeprom/at24.c | 219 +++++++++++++++++++++++++++++++++++=
----------
>> 1 file changed, 174 insertions(+), 45 deletions(-)
>>=20
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index c6cb7f8..195a45e 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -3,6 +3,7 @@
>>  *
>>  * Copyright (C) 2005-2007 David Brownell
>>  * Copyright (C) 2008 Wolfram Sang, Pengutronix
>> + * Copyright (C) 2015 Pantelis Antoniou, Konsulko Group
>>  *
>>  * This program is free software; you can redistribute it and/or mod=
ify
>>  * it under the terms of the GNU General Public License as published=
 by
>> @@ -23,6 +24,9 @@
>> #include <linux/of.h>
>> #include <linux/i2c.h>
>> #include <linux/platform_data/at24.h>
>> +#include <linux/regmap.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/io.h>
>>=20
>> /*
>>  * I2C EEPROMs from most vendors are inexpensive and mostly intercha=
ngeable.
>> @@ -63,12 +67,16 @@ struct at24_data {
>>         * but not from changes by other I2C masters.
>>         */
>>        struct mutex lock;
>> -       struct bin_attribute bin;
>>=20
>>        u8 *writebuf;
>>        unsigned write_max;
>>        unsigned num_addresses;
>>=20
>> +       struct regmap_config *regmap_config;
>> +       struct regmap *regmap;
>> +       struct nvmem_config *nvmem_config;
>> +       struct nvmem_device *nvmem_dev;
>> +
>>        /*
>>         * Some chips tie up multiple I2C addresses; dummy devices re=
serve
>>         * them for us, and we'll use them with SMBus calls.
>> @@ -131,6 +139,8 @@ static const struct i2c_device_id at24_ids[] =3D=
 {
>> };
>> MODULE_DEVICE_TABLE(i2c, at24_ids);
>>=20
>> +static DEFINE_IDA(at24_ida);
>> +
>> /*------------------------------------------------------------------=
-------*/
>>=20
>> /*
>> @@ -276,17 +286,6 @@ static ssize_t at24_read(struct at24_data *at24=
,
>>        return retval;
>> }
>>=20
>> -static ssize_t at24_bin_read(struct file *filp, struct kobject *kob=
j,
>> -               struct bin_attribute *attr,
>> -               char *buf, loff_t off, size_t count)
>> -{
>> -       struct at24_data *at24;
>> -
>> -       at24 =3D dev_get_drvdata(container_of(kobj, struct device, k=
obj));
>> -       return at24_read(at24, buf, off, count);
>> -}
>> -
>> -
>> /*
>>  * Note that if the hardware write-protect pin is pulled high, the w=
hole
>>  * chip is normally write protected. But there are plenty of product
>> @@ -407,18 +406,10 @@ static ssize_t at24_write(struct at24_data *at=
24, const char *buf, loff_t off,
>>        return retval;
>> }
>>=20
>> -static ssize_t at24_bin_write(struct file *filp, struct kobject *ko=
bj,
>> -               struct bin_attribute *attr,
>> -               char *buf, loff_t off, size_t count)
>> -{
>> -       struct at24_data *at24;
>> -
>> -       at24 =3D dev_get_drvdata(container_of(kobj, struct device, k=
obj));
>> -       return at24_write(at24, buf, off, count);
>> -}
>> -
>> /*------------------------------------------------------------------=
-------*/
>>=20
>> +/* panto: using the EEPROM framework macc is superfluous */
>> +
>> /*
>>  * This lets other kernel code access the eeprom data. For example, =
it
>>  * might hold a board's Ethernet address, or board-specific calibrat=
ion
>> @@ -464,6 +455,91 @@ static void at24_get_ofdata(struct i2c_client *=
client,
>> { }
>> #endif /* CONFIG_OF */
>>=20
>> +static int regmap_at24_read(void *context,
>> +                           const void *reg, size_t reg_size,
>> +                           void *val, size_t val_size)
>> +{
>> +       struct i2c_client *client =3D context;
>> +       struct at24_data *at24;
>> +       unsigned int offset;
>> +       int ret;
>> +
>> +       /* reg bits is hardcoded to 32 bits */
>> +       BUG_ON(reg_size !=3D 4);
>> +       offset =3D __raw_readl(reg);
>> +
>> +       at24 =3D i2c_get_clientdata(client);
>> +       if (at24 =3D=3D NULL)
>> +               return -ENODEV;
>> +
>> +       /* val bytes is always 1 */
>> +       BUG_ON(at24->regmap_config->val_bits !=3D 8);
>> +
>> +       ret =3D at24_read(at24, val, offset, val_size);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (ret !=3D val_size)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +static int regmap_at24_gather_write(void *context,
>> +                                   const void *reg, size_t reg_size=
,
>> +                                   const void *val, size_t val_size=
)
>> +{
>> +       struct i2c_client *client =3D context;
>> +       struct at24_data *at24;
>> +       unsigned int offset;
>> +       int ret;
>> +
>> +       at24 =3D i2c_get_clientdata(client);
>> +       if (at24 =3D=3D NULL)
>> +               return -ENODEV;
>> +
>> +       BUG_ON(reg_size !=3D 4);
>> +       offset =3D __raw_readl(reg);
>> +
>> +       /* val bytes is always 1 */
>> +       BUG_ON(at24->regmap_config->val_bits !=3D 8);
>> +
>> +       ret =3D at24_write(at24, val, offset, val_size);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (ret !=3D val_size)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +static int regmap_at24_write(void *context, const void *data, size_=
t count)
>> +{
>> +       struct i2c_client *client =3D context;
>> +       struct at24_data *at24;
>> +       unsigned int reg_bytes, offset;
>> +
>> +       at24 =3D i2c_get_clientdata(client);
>> +       if (at24 =3D=3D NULL)
>> +               return -ENODEV;
>> +
>> +       reg_bytes =3D at24->regmap_config->reg_bits / 8;
>> +       offset =3D reg_bytes;
>> +
>> +       BUG_ON(reg_bytes !=3D 4);
>> +       BUG_ON(count <=3D offset);
>> +
>> +       return regmap_at24_gather_write(context, data, reg_bytes,
>> +                       data + offset, count - offset);
>> +}
>> +
>> +static struct regmap_bus regmap_at24_bus =3D {
>> +       .read =3D regmap_at24_read,
>> +       .write =3D regmap_at24_write,
>> +       .gather_write =3D regmap_at24_gather_write,
>> +       .reg_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
>> +       .val_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
>> +};
>> +
>> static int at24_probe(struct i2c_client *client, const struct i2c_de=
vice_id *id)
>> {
>>        struct at24_platform_data chip;
>> @@ -474,6 +550,10 @@ static int at24_probe(struct i2c_client *client=
, const struct i2c_device_id *id)
>>        int err;
>>        unsigned i, num_addresses;
>>        kernel_ulong_t magic;
>> +       struct regmap_config *regmap_config;
>> +       struct regmap *regmap;
>> +       struct nvmem_config *nvmem_config;
>> +       struct nvmem_device *nvmem_dev;
>>=20
>>        if (client->dev.platform_data) {
>>                chip =3D *(struct at24_platform_data *)client->dev.pl=
atform_data;
>> @@ -541,16 +621,75 @@ static int at24_probe(struct i2c_client *clien=
t, const struct i2c_device_id *id)
>>                }
>>        }
>>=20
>> +       regmap_config =3D devm_kzalloc(&client->dev, sizeof(*regmap_=
config),
>> +                       GFP_KERNEL);
>> +       if (IS_ERR(regmap_config)) {
>> +               err =3D PTR_ERR(regmap_config);
>> +               dev_err(&client->dev, "%s: regmap_config allocation =
failed (%d)\n",
>> +                       __func__, err);
>> +               return err;
>> +       }
>> +
>> +       /* use 32 bits as registers, they don't appear on the wire a=
nyway */
>> +       regmap_config->reg_bits =3D 32;
>> +       regmap_config->val_bits =3D 8;
>> +       regmap_config->cache_type =3D REGCACHE_NONE;
>> +       regmap_config->max_register =3D chip.byte_len;
>> +
>>        if (chip.flags & AT24_FLAG_TAKE8ADDR)
>>                num_addresses =3D 8;
>>        else
>>                num_addresses =3D DIV_ROUND_UP(chip.byte_len,
>>                        (chip.flags & AT24_FLAG_ADDR16) ? 65536 : 256=
);
>>=20
>> +       /* we can't use devm_regmap_init_i2c due to the many i2c cli=
ents */
>> +       regmap =3D devm_regmap_init(&client->dev, &regmap_at24_bus,
>> +                       client, regmap_config);
>> +       if (IS_ERR(regmap)) {
>> +               err =3D PTR_ERR(regmap);
>> +               dev_err(&client->dev, "%s: regmap allocation failed =
(%d)\n",
>> +                       __func__, err);
>> +               return err;
>> +       }
>> +
>> +       nvmem_config =3D devm_kzalloc(&client->dev, sizeof(*nvmem_co=
nfig),
>> +                       GFP_KERNEL);
>> +       if (IS_ERR(nvmem_config)) {
>> +               err =3D PTR_ERR(nvmem_config);
>> +               dev_err(&client->dev, "%s: nvmem_config allocation f=
ailed (%d)\n",
>> +                       __func__, err);
>> +               return err;
>> +       }
>> +       nvmem_config->dev =3D &client->dev;
>> +       nvmem_config->name =3D "at24-";
>> +       nvmem_config->id =3D ida_simple_get(&at24_ida, 0, 0, GFP_KER=
NEL);
>> +       nvmem_config->owner =3D THIS_MODULE;
>> +       if (nvmem_config->id < 0) {
>> +               err =3D nvmem_config->id;
>> +               dev_err(&client->dev, "%s: eeprom id allocation fail=
ed (%d)\n",
>> +                       __func__, err);
>> +               return err;
>> +       }
>> +
>> +       nvmem_dev =3D nvmem_register(nvmem_config);
>> +       if (IS_ERR(nvmem_dev)) {
>> +               err =3D PTR_ERR(nvmem_dev);
>> +               dev_err(&client->dev, "%s: nvmem_register failed (%d=
)\n",
>> +                       __func__, err);
>> +               goto err_out;
>> +       }
>> +
>>        at24 =3D devm_kzalloc(&client->dev, sizeof(struct at24_data) =
+
>>                num_addresses * sizeof(struct i2c_client *), GFP_KERN=
EL);
>> -       if (!at24)
>> -               return -ENOMEM;
>> +       if (!at24) {
>> +               err =3D -ENOMEM;
>> +               goto err_out;
>> +       }
>> +
>> +       at24->regmap =3D regmap;
>> +       at24->regmap_config =3D regmap_config;
>> +       at24->nvmem_config =3D nvmem_config;
>> +       at24->nvmem_dev =3D nvmem_dev;
>>=20
>>        mutex_init(&at24->lock);
>>        at24->use_smbus =3D use_smbus;
>> @@ -558,16 +697,6 @@ static int at24_probe(struct i2c_client *client=
, const struct i2c_device_id *id)
>>        at24->chip =3D chip;
>>        at24->num_addresses =3D num_addresses;
>>=20
>> -       /*
>> -        * Export the EEPROM bytes through sysfs, since that's conve=
nient.
>> -        * By default, only root should see the data (maybe password=
s etc)
>> -        */
>> -       sysfs_bin_attr_init(&at24->bin);
>> -       at24->bin.attr.name =3D "eeprom";
>> -       at24->bin.attr.mode =3D chip.flags & AT24_FLAG_IRUGO ? S_IRU=
GO : S_IRUSR;
>> -       at24->bin.read =3D at24_bin_read;
>> -       at24->bin.size =3D chip.byte_len;
>=20
> Hi Pantelis,
>=20
> this breaks the ABI.
>=20
> Additionally: the nvmem file is 0 in size with this patch and reading
> it produces the following NULL pointer dereference on BeagleBone
> Black:
>=20
> I'm using an at24cs02 chip, that works with mainline.
>=20
> [  147.023405] Unable to handle kernel NULL pointer dereference at
> virtual address 00000002
> [  147.041713] pgd =3D de6f8000
> [  147.053787] [00000002] *pgd=3D9e6eb831, *pte=3D00000000, *ppte=3D0=
0000000
> [  147.070152] Internal error: Oops: 17 [#1] SMP ARM
> [  147.084543] Modules linked in: gpio_pca953x ina2xx ipv6 omap_rng
> rng_core rtc_omap omap_wdt at24 cpufreq_dt leds_gpio thermal_sys
> led_class hwmon
> [  147.109168] CPU: 0 PID: 177 Comm: dd Not tainted 4.3.0-rc1-acme+ #=
18
> [  147.126126] Hardware name: Generic AM33XX (Flattened Device Tree)
> [  147.142765] task: de68c380 ti: de672000 task.ti: de672000
> [  147.158659] PC is at at24_read+0x1c4/0x200 [at24]
> [  147.173739] LR is at at24_read+0x54/0x200 [at24]
> [  147.188538] pc : [<bf02a20c>]    lr : [<bf02a09c>]    psr: 6008001=
3
> [  147.188538] sp : de673d88  ip : bf02b17c  fp : ffffc440
> [  147.220290] r10: de673da4  r9 : c09c6100  r8 : de6f3300
> [  147.235487] r7 : de77c1d0  r6 : 00000000  r5 : 00000000  r4 : 0000=
0001
> [  147.251957] r3 : 00000001  r2 : de673dc0  r1 : de673dc0  r0 : 0000=
0001
> [  147.268442] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  S=
egment none
> [  147.285639] Control: 10c5387d  Table: 9e6f8019  DAC: 00000051
> [  147.301332] Process dd (pid: 177, stack limit =3D 0xde672218)
> [  147.316864] Stack: (0xde673d88 to 0xde674000)
> [  147.331094] 3d80:                   00000080 00000080 00000100
> 00000000 00000100 de77c1f0
> [  147.349553] 3da0: 00000001 00000000 00000000 00000000 00000000
> 00000000 00000000 00000100
> [  147.368085] 3dc0: de68c380 00000101 00000101 de6c2e00 c0a7f4ac
> c0a7f4e4 00000101 00000000
> [  147.386542] 3de0: de6f3200 bf02a290 00000001 c06b5d3c de617800
> c04707a8 00000101 00000020
> [  147.404852] 3e00: 00000000 00000000 60080013 c0a7d784 00000000
> c0093c74 00000001 de617800
> [  147.423274] 3e20: 00000000 00000001 00000101 de6f3200 00000101
> 00000101 00000000 c04709c0
> [  147.441694] 3e40: 00000001 c0093c74 00000001 00000101 00000000
> 00000000 00000000 00000000
> [  147.460163] 3e60: 00000000 dba5a94c 00000000 c05a15ac c0a6e5dc
> de641980 00000000 de6f3200
> [  147.478710] 3e80: 00000000 c01f0fb8 00000000 00000000 00000200
> c008da64 dba5a940 de673f80
> [  147.497227] 3ea0: 00000200 00000000 00000000 dba5a94c 00000000
> c01f08ac 00000000 00000000
> [  147.515693] 3ec0: 00000256 000af008 de673f04 de641980 c06d16bc
> 00000200 000af008 de673f80
> [  147.534153] 3ee0: 00000000 00000000 00000000 c0176af8 de641988
> ddcf1868 de641980 00000000
> [  147.552575] 3f00: 00000000 00000000 00000000 c0326588 00000000
> 00000000 00000001 de641980
> [  147.570949] 3f20: 00000200 00000000 00000000 c0176c04 60080013
> de6afc00 de641980 00000200
> [  147.589215] 3f40: 000af008 de673f80 00000000 00000000 00000000
> c0177acc de6afc00 de6afe80
> [  147.607452] 3f60: de641980 de641980 de641980 00000200 000af008
> 00000000 00000000 c0177c00
> [  147.625712] 3f80: 00000000 00000000 000aea10 000aea10 00000000
> 000af008 00000003 c000ff44
> [  147.643928] 3fa0: de672000 c000fda0 000aea10 00000000 00000000
> 000af008 00000200 00000000
> [  147.662047] 3fc0: 000aea10 00000000 000af008 00000003 000af008
> 00000000 000af008 00000000
> [  147.680078] 3fe0: 00000000 beec7aac 0000fc00 b6f2c07c 60080010
> 00000000 00000000 00000000
> [  147.698148] [<bf02a20c>] (at24_read [at24]) from [<bf02a290>]
> (regmap_at24_read+0x48/0x78 [at24])
> [  147.717080] [<bf02a290>] (regmap_at24_read [at24]) from
> [<c04707a8>] (_regmap_raw_read+0xdc/0x1f4)
> [  147.736127] [<c04707a8>] (_regmap_raw_read) from [<c04709c0>]
> (regmap_raw_read+0x100/0x160)
> [  147.754515] [<c04709c0>] (regmap_raw_read) from [<c05a15ac>]
> (bin_attr_nvmem_read+0x54/0x8c)
> [  147.773017] [<c05a15ac>] (bin_attr_nvmem_read) from [<c01f0fb8>]
> (sysfs_kf_bin_read+0xa0/0xac)
> [  147.791728] [<c01f0fb8>] (sysfs_kf_bin_read) from [<c01f08ac>]
> (kernfs_fop_read+0xb8/0x180)
> [  147.810159] [<c01f08ac>] (kernfs_fop_read) from [<c0176af8>]
> (__vfs_read+0x2c/0xe0)
> [  147.827787] [<c0176af8>] (__vfs_read) from [<c0177acc>] (vfs_read+=
0x90/0xf0)
> [  147.844732] [<c0177acc>] (vfs_read) from [<c0177c00>] (SyS_read+0x=
44/0x88)
> [  147.861535] [<c0177c00>] (SyS_read) from [<c000fda0>]
> (ret_fast_syscall+0x0/0x1c)
> [  147.878728] Code: e28d1038 e0812002 a3a03001 e5425004 (e1d620b2)
> [  147.894527] ---[ end trace 4f2f3a675fee7446 ]---
>=20
> Best regards,
> Bartosz Golaszewski
>=20
>>        at24->macc.read =3D at24_macc_read;
>>=20
>>        writable =3D !(chip.flags & AT24_FLAG_READONLY);
>> @@ -578,9 +707,6 @@ static int at24_probe(struct i2c_client *client,=
 const struct i2c_device_id *id)
>>=20
>>                        at24->macc.write =3D at24_macc_write;
>>=20
>> -                       at24->bin.write =3D at24_bin_write;
>> -                       at24->bin.attr.mode |=3D S_IWUSR;
>> -
>>                        if (write_max > io_limit)
>>                                write_max =3D io_limit;
>>                        if (use_smbus && write_max > I2C_SMBUS_BLOCK_=
MAX)
>> @@ -590,8 +716,10 @@ static int at24_probe(struct i2c_client *client=
, const struct i2c_device_id *id)
>>                        /* buffer (data + address at the beginning) *=
/
>>                        at24->writebuf =3D devm_kzalloc(&client->dev,
>>                                write_max + 2, GFP_KERNEL);
>> -                       if (!at24->writebuf)
>> -                               return -ENOMEM;
>> +                       if (!at24->writebuf) {
>> +                               err =3D -ENOMEM;
>> +                               goto err_out;
>> +                       }
>>                } else {
>>                        dev_warn(&client->dev,
>>                                "cannot write due to controller restr=
ictions.");
>> @@ -612,14 +740,10 @@ static int at24_probe(struct i2c_client *clien=
t, const struct i2c_device_id *id)
>>                }
>>        }
>>=20
>> -       err =3D sysfs_create_bin_file(&client->dev.kobj, &at24->bin)=
;
>> -       if (err)
>> -               goto err_clients;
>> -
>>        i2c_set_clientdata(client, at24);
>>=20
>>        dev_info(&client->dev, "%zu byte %s EEPROM, %s, %u bytes/writ=
e\n",
>> -               at24->bin.size, client->name,
>> +               at24->chip.byte_len, client->name,
>>                writable ? "writable" : "read-only", at24->write_max)=
;
>>        if (use_smbus =3D=3D I2C_SMBUS_WORD_DATA ||
>>            use_smbus =3D=3D I2C_SMBUS_BYTE_DATA) {
>> @@ -635,10 +759,14 @@ static int at24_probe(struct i2c_client *clien=
t, const struct i2c_device_id *id)
>>        return 0;
>>=20
>> err_clients:
>> +
>>        for (i =3D 1; i < num_addresses; i++)
>>                if (at24->client[i])
>>                        i2c_unregister_device(at24->client[i]);
>>=20
>> +err_out:
>> +       ida_simple_remove(&at24_ida, nvmem_config->id);
>> +
>>        return err;
>> }
>>=20
>> @@ -648,11 +776,12 @@ static int at24_remove(struct i2c_client *clie=
nt)
>>        int i;
>>=20
>>        at24 =3D i2c_get_clientdata(client);
>> -       sysfs_remove_bin_file(&client->dev.kobj, &at24->bin);
>>=20
>>        for (i =3D 1; i < at24->num_addresses; i++)
>>                i2c_unregister_device(at24->client[i]);
>>=20
>> +       nvmem_unregister(at24->nvmem_dev);
>> +
>>        return 0;
>> }
>>=20
>>=20
>> 1.7.12

Thanks for the bug report. Are you using the user-space API to read fro=
m the device?

Regards

=E2=80=94 Pantelis
