From: BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2.6.26.5] rtc-ds1307 : SMBus compatibility
Date: Thu, 9 Oct 2008 08:59:17 +0200
Message-ID: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59E27@PRI-MBX-101.dom1.vinci-energies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

This patch change all i2c access functions to SMBus access functions in ord=
er to use the ds1307 on SMBus.
I expect that using SMBus access functions is correct for all boards with i=
2C or SMBus adapter. Is it correct ?

I have tested it on my Geode LX board with a ds1307 device.

Please CC me your comments.
Thanks.

--- a/drivers/rtc/rtc-ds1307.c  2008-09-08 17:40:20.000000000 +0000
+++ b/drivers/rtc/rtc-ds1307.c  2008-10-07 13:21:57.000000000 +0000
@@ -92,7 +92,6 @@ struct ds1307 {
        bool                    has_nvram;
        u8                      regs[8];
        enum ds_type            type;
-       struct i2c_msg          msg[2];
        struct i2c_client       *client;
        struct i2c_client       dev;
        struct rtc_device       *rtc;
@@ -138,12 +137,10 @@ static int ds1307_get_time(struct device
        int             tmp;

        /* read the RTC date and time registers all at once */
-       ds1307->msg[1].flags =3D I2C_M_RD;
-       ds1307->msg[1].len =3D 7;
-
-       tmp =3D i2c_transfer(to_i2c_adapter(ds1307->client->dev.parent),
-                       ds1307->msg, 2);
-       if (tmp !=3D 2) {
+       u8      *buf =3D ds1307->regs;
+       tmp =3D i2c_smbus_read_i2c_block_data(ds1307->client,
+                       DS1307_REG_SECS, 7, buf);
+       if (tmp !=3D 7) {
                dev_err(dev, "%s error %d\n", "read", tmp);
                return -EIO;
        }
@@ -180,7 +177,6 @@ static int ds1307_get_time(struct device
 static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 {
        struct ds1307   *ds1307 =3D dev_get_drvdata(dev);
-       int             result;
        int             tmp;
        u8              *buf =3D ds1307->regs;

@@ -190,7 +186,6 @@ static int ds1307_set_time(struct device
                t->tm_hour, t->tm_mday,
                t->tm_mon, t->tm_year, t->tm_wday);

-       *buf++ =3D 0;             /* first register addr */
        buf[DS1307_REG_SECS] =3D BIN2BCD(t->tm_sec);
        buf[DS1307_REG_MIN] =3D BIN2BCD(t->tm_min);
        buf[DS1307_REG_HOUR] =3D BIN2BCD(t->tm_hour);
@@ -215,16 +210,12 @@ static int ds1307_set_time(struct device
                break;
        }

-       ds1307->msg[1].flags =3D 0;
-       ds1307->msg[1].len =3D 8;
-
        dev_dbg(dev, "%s: %02x %02x %02x %02x %02x %02x %02x\n",
                "write", buf[0], buf[1], buf[2], buf[3],
                buf[4], buf[5], buf[6]);

-       result =3D i2c_transfer(to_i2c_adapter(ds1307->client->dev.parent),
-                       &ds1307->msg[1], 1);
-       if (result !=3D 1) {
+       tmp =3D i2c_smbus_write_i2c_block_data(ds1307->client, 0, 7, buf);
+       if (tmp < 0) {
                dev_err(dev, "%s error %d\n", "write", tmp);
                return -EIO;
        }
@@ -246,8 +237,7 @@ ds1307_nvram_read(struct kobject *kobj,
 {
        struct i2c_client       *client;
        struct ds1307           *ds1307;
-       struct i2c_msg          msg[2];
-       int                     result;
+       int     tmp;

        client =3D kobj_to_i2c_client(kobj);
        ds1307 =3D i2c_get_clientdata(client);
@@ -259,24 +249,13 @@ ds1307_nvram_read(struct kobject *kobj,
        if (unlikely(!count))
                return count;

-       msg[0].addr =3D client->addr;
-       msg[0].flags =3D 0;
-       msg[0].len =3D 1;
-       msg[0].buf =3D buf;
-
-       buf[0] =3D 8 + off;
-
-       msg[1].addr =3D client->addr;
-       msg[1].flags =3D I2C_M_RD;
-       msg[1].len =3D count;
-       msg[1].buf =3D buf;
-
-       result =3D i2c_transfer(to_i2c_adapter(client->dev.parent), msg, 2);
-       if (result !=3D 2) {
-               dev_err(&client->dev, "%s error %d\n", "nvram read", result=
);
+       tmp =3D i2c_smbus_read_i2c_block_data(client, 8 + off, count, buf);
+       if (tmp < 0) {
+               dev_err(&client->dev, "%s error %d\n", "read", tmp);
                return -EIO;
        }
-       return count;
+
+       return tmp;
 }

 static ssize_t
@@ -284,8 +263,8 @@ ds1307_nvram_write(struct kobject *kobj,
                char *buf, loff_t off, size_t count)
 {
        struct i2c_client       *client;
-       u8                      buffer[NVRAM_SIZE + 1];
-       int                     ret;
+       u8                      buffer[NVRAM_SIZE];
+       int                     tmp;

        client =3D kobj_to_i2c_client(kobj);

@@ -296,11 +275,14 @@ ds1307_nvram_write(struct kobject *kobj,
        if (unlikely(!count))
                return count;

-       buffer[0] =3D 8 + off;
-       memcpy(buffer + 1, buf, count);
+       memcpy(buffer, buf, count);

-       ret =3D i2c_master_send(client, buffer, count + 1);
-       return (ret < 0) ? ret : (ret - 1);
+       tmp =3D i2c_smbus_write_i2c_block_data(client, 8 + off, count, buff=
er);
+       if (tmp < 0) {
+               dev_err(&client->dev, "%s error %d\n", "write", tmp);
+               return -EIO;
+       }
+       return count;
 }

 static struct bin_attribute nvram =3D {
@@ -325,11 +307,15 @@ static int __devinit ds1307_probe(struct
        struct ds1307           *ds1307;
        int                     err =3D -ENODEV;
        int                     tmp;
+       u8                      *buf;
+
        const struct chip_desc  *chip =3D &chips[id->driver_data];
        struct i2c_adapter      *adapter =3D to_i2c_adapter(client->dev.par=
ent);

        if (!i2c_check_functionality(adapter,
-                       I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
+                       I2C_FUNC_SMBUS_WRITE_BYTE_DATA
+                       | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
+                       | I2C_FUNC_SMBUS_READ_I2C_BLOCK))
                return -EIO;

        if (!(ds1307 =3D kzalloc(sizeof(struct ds1307), GFP_KERNEL)))
@@ -338,35 +324,21 @@ static int __devinit ds1307_probe(struct
        ds1307->client =3D client;
        i2c_set_clientdata(client, ds1307);

-       ds1307->msg[0].addr =3D client->addr;
-       ds1307->msg[0].flags =3D 0;
-       ds1307->msg[0].len =3D 1;
-       ds1307->msg[0].buf =3D &ds1307->reg_addr;
-
-       ds1307->msg[1].addr =3D client->addr;
-       ds1307->msg[1].flags =3D I2C_M_RD;
-       ds1307->msg[1].len =3D sizeof(ds1307->regs);
-       ds1307->msg[1].buf =3D ds1307->regs;
-
        ds1307->type =3D id->driver_data;

        switch (ds1307->type) {
        case ds_1337:
        case ds_1339:
-               ds1307->reg_addr =3D DS1337_REG_CONTROL;
-               ds1307->msg[1].len =3D 2;
-
+               buf =3D &ds1307->regs[DS1337_REG_CONTROL];
                /* get registers that the "rtc" read below won't read... */
-               tmp =3D i2c_transfer(adapter, ds1307->msg, 2);
+               tmp =3D i2c_smbus_read_i2c_block_data(ds1307->client,
+                               DS1337_REG_CONTROL, 2, buf);
                if (tmp !=3D 2) {
                        pr_debug("read error %d\n", tmp);
                        err =3D -EIO;
                        goto exit_free;
                }

-               ds1307->reg_addr =3D 0;
-               ds1307->msg[1].len =3D sizeof(ds1307->regs);
-
                /* oscillator off?  turn it on, so clock can tick. */
                if (ds1307->regs[0] & DS1337_BIT_nEOSC)
                        i2c_smbus_write_byte_data(client, DS1337_REG_CONTRO=
L,
@@ -385,9 +357,9 @@ static int __devinit ds1307_probe(struct

 read_rtc:
        /* read RTC registers */
-
-       tmp =3D i2c_transfer(adapter, ds1307->msg, 2);
-       if (tmp !=3D 2) {
+       buf =3D ds1307->regs;
+       tmp =3D i2c_smbus_read_i2c_block_data(ds1307->client, 0, 8, buf);
+       if (tmp !=3D 8) {
                pr_debug("read error %d\n", tmp);
                err =3D -EIO;
                goto exit_free;
