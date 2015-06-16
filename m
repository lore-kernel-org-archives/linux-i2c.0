From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC]: Supporting PIO mode of operation in i2c_msg->flags
Date: Tue, 16 Jun 2015 17:41:30 +0530
Message-ID: <55801272.1040006@linaro.org>
References: <5562EF9D.1090403@linaro.org> <20150611234118.GA1534@katana> <557D6FAF.1050408@linaro.org> <557FE4A9.5030004@linaro.org> <20150616091815.GA1595@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150616091815.GA1595@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Tuesday 16 June 2015 02:48 PM, Wolfram Sang wrote:
>
>> Any update on this?
>
> Not yet.
>
> a) there was no code to look at
>

Actually its simple question, whether we can call i2c_transfer in
pm_power_off fn, where interupts are disabled and i2c_transfer fn may
sleep.

Just to illustrate my point,
I just quickly created something for you. Correct me if I am wrong here.


pm_power_off Usecase:
=====

File: arch/arm64/kernel/process.c

void machine_power_off(void)
{
         local_irq_disable();
         smp_send_stop();
         if (pm_power_off)
                 pm_power_off();
}


Dummy pm_power_off Implementation:
=====

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 03b70f8..e364a2a 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1170,7 +1170,10 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, 
struct i2c_msg msgs[], int num
         i2c_pxa_enable(i2c, true);

         for (i = adap->retries; i >= 0; i--) {
-               ret = i2c_pxa_do_xfer(i2c, msgs, num);
+               if (msgs[0].flags & I2C_M_PIO)
+                       ret = i2c_pxa_do_pio_xfer(i2c, msgs, num);
+               else
+                       ret = i2c_pxa_do_xfer(i2c, msgs, num);
                 if (ret != I2C_RETRY)
                         goto out;

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 0464e2d..2d7b11b 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -488,6 +488,52 @@ static void pm800_pages_exit(struct pm80x_chip *chip)
                 i2c_unregister_device(subchip->gpadc_page);
  }

+static struct pm80x_chip *pm80x_chip_g;
+
+#define PM800_SW_PDOWN                 (1 << 5)
+
+static void pm800_power_off(void)
+{
+       u8 data, buf[2];
+       struct i2c_msg msgs[2];
+       struct i2c_client *client = pm80x_chip_g->client;
+
+       pr_info("turning off power....\n");
+
+       /*
+        * pm_power_off fn get called at the end of machine_power_off(),
+        * so at this stage the irqs are disabled, so we have to use
+        * PIO mode of I2C transaction for both read and write.
+        */
+       /* Read register first */
+       msgs[0].addr = client->addr;
+       msgs[0].flags = I2C_M_PIO;
+       msgs[0].len = 1;
+       msgs[0].buf = buf;
+
+       msgs[1].addr = client->addr;
+       msgs[1].flags = I2C_M_RD | I2C_M_PIO;
+       msgs[1].len = 1;
+       msgs[1].buf = &data;
+
+       buf[0] = PM800_WAKEUP1;
+       if ( __i2c_transfer(client->adapter, msgs, 2) < 0) {
+               pr_err("%s read register fails...\n", __func__);
+               WARN_ON(1);
+       }
+
+       /* issue SW power down */
+       msgs[0].addr = client->addr;
+       msgs[0].flags = I2C_M_PIO;
+       msgs[0].len = 2;
+       msgs[0].buf[0] = PM800_WAKEUP1;
+       msgs[0].buf[1] = data | PM800_SW_PDOWN;
+       if (__i2c_transfer(client->adapter, msgs, 1) < 0) {
+               pr_err("%s write data fails...\n", __func__);
+               WARN_ON(1);
+       }
+}
+
  static int device_800_init(struct pm80x_chip *chip,
                                      struct pm80x_platform_data *pdata)
  {
@@ -612,6 +658,10 @@ static int pm800_probe(struct i2c_client *client,
         if (pdata && pdata->plat_config)
                 pdata->plat_config(chip, pdata);

+       /* keep global copy, required in power_off fn */
+       pm80x_chip_g = chip;
+       pm_power_off = pm800_power_off;
+
         return 0;

  err_device_init:
diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index 0e949cb..22fda83 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -76,6 +76,7 @@ struct i2c_msg {
  #define I2C_M_IGNORE_NAK       0x1000  /* if I2C_FUNC_PROTOCOL_MANGLING */
  #define I2C_M_NO_RD_ACK                0x0800  /* if 
I2C_FUNC_PROTOCOL_MANGLING */
  #define I2C_M_RECV_LEN         0x0400  /* length will be first 
received byte */
+#define I2C_M_PIO              0x0200  /* pio mode of transaction */
         __u16 len;              /* msg length                           */
         __u8 *buf;              /* pointer to msg data                  */
  };
