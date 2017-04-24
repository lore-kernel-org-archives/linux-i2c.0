From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 24 Apr 2017 11:56:01 -0700
Message-ID: <CAFd5g45DQZz99y59AY-4465qnM+tRv6+bDdGQqS6VYHEfRfjDg@mail.gmail.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-5-brendanhiggins@google.com> <1490945610.3177.229.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490945610.3177.229.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Kachalov Anton <mouse-Pma6HLj0uuo@public.gmane.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg-Bxea+6Xhats@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>> +struct aspeed_i2c_bus {
>> +     struct i2c_adapter              adap;
>> +     struct device                   *dev;
>> +     void __iomem                    *base;
>> +     /* Synchronizes I/O mem access to base. */
>> +     spinlock_t                      lock;
>
> I am not entirely convinced we need that lock. The i2c core will
> take a mutex protecting all operations on the bus. So we only need
> to synchronize between our "xfer" code and our interrupt handler.

You are right if both having slave and master active at the same time
was not possible; however, it is. Imagine the case where the slave is
receiving a request and something in the I2C API gets called. I
suppose we could make the slave IRQ handler lock that lock, but I
think it makes more sense to have a separate lock, since we do not
control that lock making it harder to reason about. Plus, we put
ourselves in a position where an API user has access to a lock that an
interrupt handler needs to acquire, if the user does something dumb,
then we can get interrupt starvation.

>
> This probably be done without a lock if we are careful. Not a huge
> deal though as Aspeed SoC are currently not SMP so the lock compiles
> down to not much unless you have all the debug crap enabled :-)
>
>> +     struct completion               cmd_complete;
>> +     int                             irq;
>> +     /* Transaction state. */
>> +     enum aspeed_i2c_master_state    master_state;
>> +     struct i2c_msg                  *msgs;
>> +     size_t                          buf_index;
>> +     size_t                          msgs_index;
>> +     size_t                          msgs_size;
>> +     bool                            send_stop;
...
>> +             time_left = wait_for_completion_timeout(
>> +                             &bus->cmd_complete, bus->adap.timeout);
>> +
>> +             spin_lock_irqsave(&bus->lock, flags);
>> +             if (time_left == 0)
>> +                     ret = -ETIMEDOUT;
>> +             else if (bus->cmd_err)
>> +                     ret = -EIO;
>> +             /* Recovery failed. */
>> +             else if (!(aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG) &
>> +                        ASPEED_I2CD_SDA_LINE_STS))
>> +                     ret = -EIO;
>> +     }
>
> Some of those error states probably also warrant a reset of the controller,
> I think aspeed does that in the SDK.

For timeout and cmd_err, I do not see any argument against it; it
sounds like we are in a very messed up, very unknown state, so full
reset is probably the best last resort. For SDA staying pulled down, I
think we can say with reasonable confidence that some device on our
bus is behaving very badly and I am not convinced that resetting the
controller is likely to do anything to help; that being said, I really
do not have any good ideas to address that. So maybe praying and
resetting the controller is *the most reasonable thing to do.* I would
like to know what you think we should do in that case.

While I was thinking about this I also realized that the SDA line
check after recovery happens in the else branch, but SCL line check
does not happen after we attempt to STOP if SCL is hung. If we decide
to make special note SDA being hung by a device that won't let go, we
might want to make a special note that SCL is hung by a device that
won't let go. Just a thought.

>
>> +out:
...
> What about I2C_M_NOSTART ?
>
> Not that I've ever seen it used... ;-)

Right now I am not doing any of the protocol mangling options, but I
can add them in if you think it is important for initial support.

>
>> +     aspeed_i2c_write(bus, slave_addr, ASPEED_I2C_BYTE_BUF_REG);
>> +     aspeed_i2c_write(bus, command, ASPEED_I2C_CMD_REG);
>> +}
...
>
>> +     spin_lock(&bus->lock);
>> +     irq_status = aspeed_i2c_read(bus, ASPEED_I2C_INTR_STS_REG);
>>
>
> I would "ack" (write back to INTR_STS_REG) immediately. Otherwise
> you have a race between status bits set as a result of what happened
> before the interrupt handler vs. as a result of what you did.
>
> For example, take TX. You get the TX bit in irq_status. You start
> a new character transmission bcs there's more to send *then* you ack
> the TX bit. That's racy. If that new transmission is fast enough,
> you'll end up acking the wrong one. Again this is extremely unlikely
> but code should be written in a way that is completely fool proof
> from such races. They can happen for stupid reasons, such as huge
> bus delays caused by a peripheral, FIQ going bonkers etc...
>
> In general, you always ACK all interrupts first. Then you handle
> the bits you have harvested.
>

The documentation says to ACK the interrupt after handling in the RX case:

<<<
S/W needs to clear this status bit to allow next data receiving.
>>>

I will double check with Ryan to make sure TX works the same way.

>> +     if (irq_status & ASPEED_I2CD_INTR_ERROR ||
>> +         (!bus->msgs && bus->master_state != ASPEED_I2C_MASTER_STOP)) {
>
...
>
> I would set master_state to "RECOVERY" (new state ?) and ensure
> those things are caught if they happen outside of a recovery.

Let me know if you still think we need a "RECOVERY" state.

>
>> +     if (bus->master_state == ASPEED_I2C_MASTER_START) {
>
...
>
>> +                     dev_dbg(bus->dev,
>> +                             "no slave present at %02x", msg->addr);
>> +                     status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>> +                     bus->cmd_err = -EIO;
>> +                     do_stop(bus);
>> +                     goto out_no_complete;
>> +             } else {
>> +                     status_ack |= ASPEED_I2CD_INTR_TX_ACK;
>> +                     if (msg->flags & I2C_M_RD)
>> +                             bus->master_state = ASPEED_I2C_MASTER_RX;
>> +                     else
>> +                             bus->master_state = ASPEED_I2C_MASTER_TX_FIRST;
>
> What about the SMBUS_QUICK case ? (0-len transfer). Do we need
> to handle this here ? A quick look at the TX_FIRST case makes
> me think we are ok there but I'm not sure about the RX case.

I did not think that there is an SMBUS_QUICK RX. Could you point me to
an example?

>
> I'm not sure the RX case is tight also. What completion does the
> HW give you for the address cycle ? Won't you get that before it
> has received the first character ? IE. You fall through to
> the read case of the state machine with the read potentially
> not complete yet no ?
...
>> +     case ASPEED_I2C_MASTER_RX:
>> +             if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE)) {
>> +                     dev_err(bus->dev, "master failed to RX");
>> +                     goto out_complete;
>> +             }
>
> See my comment above for a bog standard i2c_read. Aren't you getting
> the completion for the address before the read is even started ?

In practice no, but it is probably best to be safe :-)

>
>> +             status_ack |= ASPEED_I2CD_INTR_RX_DONE;
>> +
>> +             recv_byte = aspeed_i2c_read(bus, ASPEED_I2C_BYTE_BUF_REG) >> 8;
>> +             msg->buf[bus->buf_index++] = recv_byte;
>> +
>> +             if (msg->flags & I2C_M_RECV_LEN &&
>> +                 recv_byte <= I2C_SMBUS_BLOCK_MAX) {
>> +                     msg->len = recv_byte +
>> +                                     ((msg->flags & I2C_CLIENT_PEC) ? 2 : 1);
...
>> +     return ((clk_high << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
>> +             & ASPEED_I2CD_TIME_SCL_HIGH_MASK)
>> +                     | ((clk_low << ASPEED_I2CD_TIME_SCL_LOW_SHIFT)
>> +                        & ASPEED_I2CD_TIME_SCL_LOW_MASK)
>> +                     | (base_clk & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
>> +}
>
> As I think I mentioned earlier, the AST2500 has a slightly different
> register layout which support larger values for high and low, thus
> allowing a finer granularity.

I am developing against the 2500.

> BTW. In case you haven't, I would suggest you copy/paste the above in
> a userspace app and run it for all frequency divisors and see if your
> results match the aspeed table :)

Good call.

>
>> +static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
>> +                            struct platform_device *pdev)
>> +{
>> +     u32 clk_freq, divisor;
>> +     struct clk *pclk;
>> +     int ret;
>> +
>> +     pclk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(pclk)) {
>> +             dev_err(&pdev->dev, "clk_get failed\n");
>> +             return PTR_ERR(pclk);
>> +     }
>> +     ret = of_property_read_u32(pdev->dev.of_node,
>> +                                "clock-frequency", &clk_freq);
>
> See my previous comment about calling that 'bus-frequency' rather
> than 'clock-frequency'.
>
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev,
>> +                     "Could not read clock-frequency property\n");
>> +             clk_freq = 100000;
>> +     }
>> +     divisor = clk_get_rate(pclk) / clk_freq;
>> +     /* We just need the clock rate, we don't actually use the clk object. */
>> +     devm_clk_put(&pdev->dev, pclk);
>> +
>> +     /* Set AC Timing */
>> +     if (clk_freq / 1000 > 1000) {
>> +             aspeed_i2c_write(bus, aspeed_i2c_read(bus,
>> +                                                   ASPEED_I2C_FUN_CTRL_REG) |
>> +                             ASPEED_I2CD_M_HIGH_SPEED_EN |
>> +                             ASPEED_I2CD_M_SDA_DRIVE_1T_EN |
>> +                             ASPEED_I2CD_SDA_DRIVE_1T_EN,
>> +                             ASPEED_I2C_FUN_CTRL_REG);
>> +
>> +             aspeed_i2c_write(bus, 0x3, ASPEED_I2C_AC_TIMING_REG2);
>> +             aspeed_i2c_write(bus, aspeed_i2c_get_clk_reg_val(divisor),
>> +                              ASPEED_I2C_AC_TIMING_REG1);
>
> I already discussed by doubts about the above. I can try to scope
> it with the EVB if you don't get to it. For now I'd rather take the
> code out.
>
> We should ask aspeed from what frequency the "1T" stuff is useful.

Will do, I will try to rope Ryan in on the next review; it will be
good for him to get used to working with upstream anyway.

>
>> +     } else {
>> +             aspeed_i2c_write(bus, aspeed_i2c_get_clk_reg_val(divisor),
>> +                              ASPEED_I2C_AC_TIMING_REG1);
>> +             aspeed_i2c_write(bus, ASPEED_NO_TIMEOUT_CTRL,
>> +                              ASPEED_I2C_AC_TIMING_REG2);
>> +     }
...
>> +     spin_lock_init(&bus->lock);
>> +     init_completion(&bus->cmd_complete);
>> +     bus->adap.owner = THIS_MODULE;
>> +     bus->adap.retries = 0;
>> +     bus->adap.timeout = 5 * HZ;
>> +     bus->adap.algo = &aspeed_i2c_algo;
>> +     bus->adap.algo_data = bus;
>> +     bus->adap.dev.parent = &pdev->dev;
>> +     bus->adap.dev.of_node = pdev->dev.of_node;
>> +     snprintf(bus->adap.name, sizeof(bus->adap.name), "Aspeed i2c");
>
> Another trivial one, should we put some kind of bus number
> in that string ?

Whoops, looks like I missed this one; I will get to it in the next revision.

>
>> +     bus->dev = &pdev->dev;
>> +
>> +     /* reset device: disable master & slave functions */
>> +     aspeed_i2c_write(bus, 0, ASPEED_I2C_FUN_CTRL_REG);
...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
