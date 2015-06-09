From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [V4, 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller driver
Date: Tue, 9 Jun 2015 13:26:06 -0400
Message-ID: <CAC=U0a2R=G0toDqUQzVueREDXFxs0Dm4eiBAdyhzH7Fp57-nRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

>
> Don't print out, it will spoil the logs. Timeouts can happen on I2C
> busses, no need to inform the user.
>

If ii is alright with you I will change the  dev_err(...)messages to
dev_dbg(...) so that they do not spoil the logs.

>> +     rc = of_property_read_string(dev->device->of_node, "interrupt-names",
>> +                                  &int_name);
>
> I haven't checked but is that really needed? of_irq_to_resource() seems
> to parse the "interrupt-names" property

Since the driver also fall's back to polling it will not work in case
there is no irq domain assigned. The above approach works for both
cases. So we do need it.

Thanks
Kamal

On Wed, Jun 3, 2015 at 11:54 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Tue, May 19, 2015 at 12:23:44PM -0400, Kamal Dasu wrote:
>> Adding support for i2c controller driver for Broadcom settop
>> SoCs.
>>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> We are very close.
>
>> +/* Wait for device to be ready */
>> +static int brcmstb_i2c_wait_if_busy(struct brcmstb_i2c_dev *dev)
>> +{
>> +     unsigned long timeout = jiffies + msecs_to_jiffies(I2C_TIMEOUT);
>> +
>> +     while ((bsc_readl(dev, iic_enable) & BSC_IIC_EN_INTRP_MASK)) {
>> +             if (time_after(jiffies, timeout)) {
>> +                     dev_err(dev->device, "i2c device busy timeout\n");
>
> Don't print out, it will spoil the logs. Timeouts can happen on I2C
> busses, no need to inform the user.
>
> ...
>
>> +     /* Wait for transaction to finish or timeout */
>> +     rc = brcmstb_i2c_wait_for_completion(dev);
>> +     if (rc) {
>> +             dev_err(dev->device, "intr timeout for cmd %s\n",
>> +                     cmd_string[cmd]);
>> +             goto cmd_out;
>> +     }
>
> ditto
>
>> +
>> +     if ((CMD_RD || CMD_WR) &&
>> +         bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
>> +             rc = -EREMOTEIO;
>> +             dev_dbg(dev->device, "controller received NOACK intr for %s\n",
>> +                     cmd_string[cmd]);
>
> I'd leave this out, too. But you decide.
>
> ...
>
>> +     rc = of_property_read_string(dev->device->of_node, "interrupt-names",
>> +                                  &int_name);
>
> I haven't checked but is that really needed? of_irq_to_resource() seems
> to parse the "interrupt-names" property.
>
> Thanks,
>
>    Wolfram
>
