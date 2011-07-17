From: Ben Stoltz <benstoltz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: FYI: i2c-mpc.c vs. SMBUS reset
Date: Sun, 17 Jul 2011 13:04:02 -0700
Message-ID: <93937195-53AC-42F2-8E24-B24BF0840F54@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

When working with an SMBUS device that implements the SMBUS reset
function, there is a basic problem with the i2c-mpc driver.  Even
in the interrupt driven mode, the indirect call to schedule() in i2c_wait() can
cause a delay exceeding 35ms while SCL is low. SCL low for >35ms will reset the 
I2C interface of certain slave devices.  This behavior has been observed with the
ADT74xx series fan controllers controlled with i2c-mpc.c on an MPC8347 processor.

A workaround is to have application layer code retry the failed operation until it wins the race [schedule() vs. SMBUS reset].

However, it would be best to follow the lead of other I2C drivers and perform realtime operations in the ISR.

 Ben Stoltz

line numbers reference http://lxr.linux.no/linux+v2.6.39/drivers/i2c/busses/i2c-mpc.c

85 static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
86 {
87        struct mpc_i2c *i2c = dev_id;
88        if (readb(i2c->base + MPC_I2C_SR) & CSR_MIF) {
89                /* Read again to allow register to stabilise */
90                i2c->interrupt = readb(i2c->base + MPC_I2C_SR);
91                writeb(0, i2c->base + MPC_I2C_SR);
Note: SCL is held low. The HW controller does not know if next change is to SCL or SDA, so it maintains SCL low until the driver reads or writes I2Cn.DR or writes I2Cn.CR.
92                wake_up(&i2c->queue);
93        }
94        return IRQ_HANDLED;
95 }


119 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
120 {
121        unsigned long orig_jiffies = jiffies;
122        u32 x;
123        int result = 0;
124
125        if (!i2c->irq) {
...
137        } else {
138                /* Interrupt mode */
139                result = wait_event_timeout(i2c->queue,
140                        (i2c->interrupt & CSR_MIF), timeout);
141
142                if (unlikely(!(i2c->interrupt & CSR_MIF))) {
143                        dev_dbg(i2c->dev, "wait timeout\n");
144                        writeccr(i2c, 0);
145                        result = -ETIMEDOUT;
146                }
147
148                x = i2c->interrupt;
149                
...
171         return 0;
172 }

428 static int mpc_write(struct mpc_i2c *i2c, int target,
429                     const u8 *data, int length, int restart)
430 {
431        int i, result;
432        unsigned timeout = i2c->adap.timeout;
433        u32 flags = restart ? CCR_RSTA : 0;
434
435        /* Start as master */
436        writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
437        /* Write target byte */
438        writeb((target << 1), i2c->base + MPC_I2C_DR);
439
440        result = i2c_wait(i2c, timeout, 1);
441        if (result < 0)
442                return result;
// BUG W.R.T. SMBUS reset. delay due to schedule() called at line 139 may exceed 35ms while SCL was low.
// Next byte will be NoAck.
443
444        for (i = 0; i < length; i ++) {
445                /* Write data byte */
446                writeb(data[i], i2c->base + MPC_I2C_DR);
447
448                result = i2c_wait(i2c, timeout, 1);
// BUG W.R.T. SMBUS reset. delay due to schedule() called at line 139 may exceed 35ms while SCL was low.
// Next byte will be NoAck.
449                if (result < 0)
450                        return result;
451 }
452
453 return 0;
454}
