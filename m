From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RESEND PATCH v4 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Mon, 28 Aug 2017 11:21:09 +0800
Message-ID: <CAMz4ku+MJ49-Orp4mGL=jW0bfnko5o9fZgAjpZKqAMVUiw-o4Q@mail.gmail.com>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <acbfda522aa806284b86f8935278cc7f7133e876.1500021046.git.baolin.wang@spreadtrum.com>
 <20170827153054.ijqxbjk25zpskojl@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33759 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdH1DVK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 27 Aug 2017 23:21:10 -0400
Received: by mail-oi0-f43.google.com with SMTP id r203so32403198oih.0
        for <linux-i2c@vger.kernel.org>; Sun, 27 Aug 2017 20:21:10 -0700 (PDT)
In-Reply-To: <20170827153054.ijqxbjk25zpskojl@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Baolin Wang <baolin.wang@spreadtrum.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>

Hi Wolfram,

On 27 August 2017 at 23:30, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi,
>
> thanks for your submission.
>
>> +static void sprd_i2c_dump_reg(struct sprd_i2c *i2c_dev)
>> +{
>> +     dev_err(&i2c_dev->adap.dev, ": ======dump i2c-%d reg=======\n",
>> +             i2c_dev->adap.nr);
>> +     dev_err(&i2c_dev->adap.dev, ": I2C_CTRL:0x%x\n",
>> +             readl(i2c_dev->base + I2C_CTL));
>> +     dev_err(&i2c_dev->adap.dev, ": I2C_ADDR_CFG:0x%x\n",
>> +             readl(i2c_dev->base + I2C_ADDR_CFG));
>> +     dev_err(&i2c_dev->adap.dev, ": I2C_COUNT:0x%x\n",
>> +             readl(i2c_dev->base + I2C_COUNT));
>> +     dev_err(&i2c_dev->adap.dev, ": I2C_RX:0x%x\n",
>> +             readl(i2c_dev->base + I2C_RX));
>> +     dev_err(&i2c_dev->adap.dev, ": I2C_STATUS:0x%x\n",
>> +             readl(i2c_dev->base + I2C_STATUS));
>> +     dev_err(&i2c_dev->adap.dev, ": ADDR_DVD0:0x%x\n",
>> +             readl(i2c_dev->base + ADDR_DVD0));
>> +     dev_err(&i2c_dev->adap.dev, ": ADDR_DVD1:0x%x\n",
>> +             readl(i2c_dev->base + ADDR_DVD1));
>> +     dev_err(&i2c_dev->adap.dev, ": ADDR_STA0_DVD:0x%x\n",
>> +             readl(i2c_dev->base + ADDR_STA0_DVD));
>> +     dev_err(&i2c_dev->adap.dev, ": ADDR_RST:0x%x\n",
>> +             readl(i2c_dev->base + ADDR_RST));
>
> I really thing register dumps should be dev_dbg().

OK. Will fix in next version.

>
>> +}
>> +
>> +static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
>> +{
>> +     writel(count, i2c_dev->base + I2C_COUNT);
>> +}
>> +
>> +static void sprd_i2c_send_stop(struct sprd_i2c *i2c_dev, int stop)
>> +{
>> +     unsigned int tmp = readl(i2c_dev->base + I2C_CTL);
>
> u32? Here and in many other places?

OK.

>
> ...
>
>> +static irqreturn_t sprd_i2c_isr_thread(int irq, void *dev_id)
>> +{
>> +     struct sprd_i2c *i2c_dev = dev_id;
>> +     struct i2c_msg *msg = i2c_dev->msg;
>> +     int ack = readl(i2c_dev->base + I2C_STATUS) & I2C_RX_ACK;
>> +     u32 i2c_count = readl(i2c_dev->base + I2C_COUNT);
>> +     u32 i2c_tran;
>> +
>> +     if (msg->flags & I2C_M_RD)
>> +             i2c_tran = i2c_dev->count >= I2C_FIFO_FULL_THLD;
>> +     else
>> +             i2c_tran = i2c_count;
>> +
>> +     /*
>> +      * If we got one ACK from slave when writing data, and we did not
>
> Here you say: "If we get ack..."
>
>> +      * finish this transmission (i2c_tran is not zero), then we should
>> +      * continue to write data.
>> +      *
>> +      * For reading data, ack is always 0, if i2c_tran is not 0 which
>> +      * means we still need to contine to read data from slave.
>> +      */
>> +     if (i2c_tran && !ack) {
>
> ... but the code gives the assumption you did NOT get an ack. So, either
> rename the variable to 'ack_err' or keep it 'ack' and invert the logic
> when initializing the variable.

If ack == 0 means we got one ack. I will invert the logic as you suggested.

>
>> +             sprd_i2c_data_transfer(i2c_dev);
>> +             return IRQ_HANDLED;
>> +     }
>> +
>> +     i2c_dev->err = 0;
>> +
>> +     /*
>> +      * If we did not get one ACK from slave when writing data, we should
>> +      * dump all registers to check I2C status.
>
> Why? I would say no. NACK from a slave can always happen, e.g. when an
> EEPROM is busy erasing a page.

For our I2C controller databook, if the master did not get one ACK
from slave when writing data to salve, we should send one STOP signal
to abort this data transfer or generate one repeated START signal to
start one new data transfer cycle. Considering our I2C usage
scenarios, we should dump registers to analyze I2C status and notify
to user to re-start new data transfer.

>
>> +      */
>> +     if (ack) {
>> +             i2c_dev->err = -EIO;
>> +             sprd_i2c_dump_reg(i2c_dev);
>> +     } else if (msg->flags & I2C_M_RD && i2c_dev->count) {
>> +             sprd_i2c_read_bytes(i2c_dev, i2c_dev->buf, i2c_dev->count);
>> +     }
>> +
>> +     /* Transmission is done and clear ack and start operation */
>> +     sprd_i2c_clear_ack(i2c_dev);
>> +     sprd_i2c_clear_start(i2c_dev);
>> +     complete(&i2c_dev->complete);
>> +
>> +     return IRQ_HANDLED;
>> +}
>
> ...
>
>> +
>> +     pm_runtime_set_autosuspend_delay(i2c_dev->dev, SPRD_I2C_PM_TIMEOUT);
>> +     pm_runtime_use_autosuspend(i2c_dev->dev);
>> +     pm_runtime_set_active(i2c_dev->dev);
>> +     pm_runtime_enable(i2c_dev->dev);
>> +
>> +     ret = pm_runtime_get_sync(i2c_dev->dev);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "i2c%d pm runtime resume failed!\n",
>> +                     pdev->id);
>
> Error message has wrong text.

Will fix it.

>
>> +             goto err_rpm_put;
>> +     }
>> +
>> +static int sprd_i2c_init(void)
>> +{
>> +     return platform_driver_register(&sprd_i2c_driver);
>> +}
>> +arch_initcall_sync(sprd_i2c_init);
>
> arch_initcall? and no exit() function? Why is it that way and/or why
> can't you use platform_module_driver()?

As I explained before, in our Spreadtrum platform, our regulator
driver will depend on I2C driver and the regulator driver uses
subsys_initcall() level to initialize. Moreover some other drivers
like GPU, they will depend on regulator to set voltage and they also
need initialization much earlier.

Since it is arch_initcall() level, Andy suggested I should get rid of
tristate (use bool) and drop module.h here and all leftovers like
MODULE_*() calls including module_exit().

>
> Rest looks good. I like the comments you added to the code.

Really appreciated for your comments.

-- 
Baolin.wang
Best Regards
