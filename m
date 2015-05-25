From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC]: Supporting PIO mode of operation in i2c_msg->flags
Date: Mon, 25 May 2015 15:17:09 +0530
Message-ID: <5562EF9D.1090403@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi,

This is rather an old issue, for which I have also done custom & hacky
solution in the past.

Please let me know if there is already an some other method or accepted
workaround to this issue. Also, let me know if you have any suggestions
on this patch, I would be happy to work on it.


Problem Statement:
------------------
In certain embedded platforms, the board power on/off is managed by
PMIC IC, which in most of the cases is over I2C bus.
So during shutdown/reboot you may have to do I2C transactions to access
PMIC, which may sleep if I2C bus driver is not functioning in PIO by
default.

This is unexpected, to sleep after you disable the interrupts.

For example,

During reboot/shutdown, the execution call reaches to,

void machine_power_off(void)
{
         local_irq_disable();
         smp_send_stop();
         if (pm_power_off)
                 pm_power_off();
}

pm_power_off will try to do I2C transaction to access PMIC, which may
sleep/schedule.


Current implementation:
--------------------

Everyone probably does have their own custom implementation for this.
Or some other mechanism to achieve this (may be hardware support).


Proposal:
---------

If I am not missing any other way of handling this situation,
below proposal should be clean and acceptable (I hope so :) )


Add flags to choose PIO mode, for I2C transactions, and the default
would be to non-PIO mode.


struct i2c_msg flags :

#define I2C_M_PIO    0x0800


And also add respective functionality flags

#define I2C_FUNC_PIO    0x10000000 /* Driver should support PIO mode*/


In the bus driver,

Inside master_xfer() callback we will check whether the intended i2c
transaction is meant to be processed in PIO mode, if yes, then we will
call PIO api, else as usual non-pio api should serve.


static int xxx_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int 
num)
{
	...


/* We can also check i2c_check_functionality(adap,I2C_FUNC_PIO) */
	if (msg->flags & I2C_M_PIO) {
		/* PIO mode operation */
	} else {
		/* non-pio mode of operation */
	}


	...


         return ret;
}


Feedback/comments are always welcome.

Thanks,
Vaibhav
