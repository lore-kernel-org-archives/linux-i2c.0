From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Calling wait_event_interruptible_timeout() in I2C wait functions
Date: Tue, 03 Feb 2009 13:37:30 -0600
Message-ID: <49889CFA.7070308@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linuxppc-dev <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In i2c-mpc.c, the i2c_wait() function has this:

	} else {
		/* Interrupt mode */
		result = wait_event_interruptible_timeout(i2c->queue,
			(i2c->interrupt & CSR_MIF), timeout * HZ);

		if (unlikely(result < 0)) {
			pr_debug("I2C: wait interrupted\n");
			writeccr(i2c, 0);
		} else if (unlikely(!(i2c->interrupt & CSR_MIF))) {

That is, the driver calls wait_event_interruptible_timeout() to wait for
a response from the I2C controller after a read or write operation.

However, it appears that this is not common behavior for I2C driver.  In
fact, only these six drivers ever call wait_event_interruptible_timeout():

i2c-cpm.c
i2c-ibm_iic.c
i2c-mpc.c
i2c-taos-evm.c
i2c-iop3xx.c
i2c-mv64xxx.c

Although one would think that calling wait_event_interruptible_timeout()
is a good idea, it fails in one situation: when the abrupt termination
of a process causes an I2C operation to occur.  That is, you press ^C in
your application, and the driver issues a final I2C operation to shut
down the device.  In this situation, wait_event_interruptible_timeout()
returns -ERESTARTSYS, which is then passed up through
i2c_smbus_write_byte_data().

So my question is, is i2c-mpc.c wrong in using
wait_event_interruptible_timeout()?

-- 
Timur Tabi
Linux kernel developer at Freescale
