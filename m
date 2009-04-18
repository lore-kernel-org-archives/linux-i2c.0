From: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 1/5] [ARM] pxa: lx: add PCON i2c driver
Date: Sat, 18 Apr 2009 15:20:48 +0100
Message-ID: <1240064452-14691-1-git-send-email-linux@arm.linux.org.uk>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090418141932.GA1236-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The PCON device on the LX platform is the heart of the platform,
managing the power, providing battery information, booting, suspend/
resume and keyboard services to the PXA CPU.

Communication between the PXA and PCON is via a multi-master I2C bus,
where both the PCON and PXA behave like an 256 byte EEPROM, and each
reads and writes locations within that namespace.

It has a nasty habbit of resetting the PXA CPU if it sees something
it doesn't like, so we have to be careful how we communicate with the
PCON.  This happens (eg) if we hold the I2C bus for any "unreasonable"
length of time, or ignore the PCON's attempt to address us as a slave.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
CC: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
CC: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
---
 arch/arm/mach-pxa/include/mach/lx-pcon.h |  117 ++++++++
 drivers/i2c/chips/Kconfig                |   10 +
 drivers/i2c/chips/Makefile               |    1 +
 drivers/i2c/chips/lx-pcon.c              |  428 ++++++++++++++++++++++++++++++
 4 files changed, 556 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/lx-pcon.h
 create mode 100644 drivers/i2c/chips/lx-pcon.c

diff --git a/arch/arm/mach-pxa/include/mach/lx-pcon.h b/arch/arm/mach-pxa/include/mach/lx-pcon.h
new file mode 100644
index 0000000..acc410d
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/lx-pcon.h
@@ -0,0 +1,117 @@
+/*
+ * PCON addresses
+ */
+#define PCON_KEYBOARD_CMD_ADDR		(0x00)
+#define PCON_KEYBOARD_CMD_VAL_READY	(0)
+#define PCON_KEYBOARD_CMD_VAL_BUSY 	(1)
+#define PCON_POWER_CF_ADDR		(0x02)
+#define PCON_POWER_PCMCIA_ADDR		(0x03)
+#define PCON_POWER_CFG_ADDR		(0x04)
+#define PCON_PWRSTATE_ADDR		(0x05)
+#define PCON_CMD_ADDR			(0x0c)	/* 1 + 8 args */
+
+typedef enum pcon_pwrstate_e {
+	PCON_PWRSTATE_HWReset    = 0,
+	PCON_PWRSTATE_SWReset    = 1,
+	PCON_PWRSTATE_Off        = 2,
+	PCON_PWRSTATE_Suspend    = 3,
+	PCON_PWRSTATE_Sleep      = 4,
+	PCON_PWRSTATE_Booting    = 5,
+	PCON_PWRSTATE_LoadingOS  = 6,
+	PCON_PWRSTATE_Idle       = 7,
+	PCON_PWRSTATE_Run        = 8,
+	PCON_PWRSTATE_Comatose   = 9,
+	PCON_PWRSTATE_PowerFail  = 10
+} pcon_pwrstate_t;
+
+extern void lx_pwr_setstate(pcon_pwrstate_t);
+extern void pcon_pwr_setstate(pcon_pwrstate_t);
+
+typedef enum {
+	PCON_CMD_Ready          = 0,
+	PCON_CMD_ADCRead        = 9,
+	PCON_CMD_GetVersion     = 10,
+	PCON_CMD_SetMMCPower    = 11,
+	PCON_CMD_SetModemPower  = 12,
+	PCON_CMD_SetUSBPower    = 13,
+	PCON_CMD_SetRedLED      = 14,
+	PCON_CMD_SetSerialPower = 15,
+	PCON_CMD_GetSerialCfg   = 17,
+	PCON_CMD_BatteryMonitor = 18,
+	PCON_CMD_GetMMCPower    = 19,
+	PCON_CMD_GetVModemPower = 20,
+	PCON_CMD_GetUSBPower    = 21,
+	PCON_CMD_SetWakeupAlarm = 22,
+} pcon_cmd_t;
+
+/*
+ * Host EEPROM emulation addresses
+ */
+#define PHST_KEYBOARD_START		(0x00)
+#define PHST_KEYBOARD_SIZE		(1)
+#define PHST_SERIAL_START		(0x02)
+#define PHST_SERIAL_SIZE		(1)
+#define PHST_POWER_START		(0x05)
+#define PHST_POWER_SIZE			(1)
+#define PHST_CMDRESP_START		(0x0d)
+#define PHST_CMDRESP_SIZE		(8)
+
+struct lx_i2cslave_watcher {
+	u16 start;
+	u16 size;
+	void (*write)(void *, unsigned int addr, unsigned char newval);
+};
+
+struct lx_i2cslave_watch {
+	struct list_head node;
+	u16 start;
+	u16 end;
+	struct lx_i2cslave_watcher *ops;
+	void *data;
+};
+
+#define I2C_EEPROM_EMU_SIZE (256)
+
+struct lx_eeprom_emu {
+	u16 size;
+	u16 ptr;
+	unsigned int seen_start;
+	struct list_head watch;
+
+	unsigned char bytes[I2C_EEPROM_EMU_SIZE];
+};
+
+extern int lx_i2cslave_addwatcher(struct lx_i2cslave_watcher *, void *data);
+extern void lx_i2cslave_delwatcher(struct lx_i2cslave_watcher *, void *data);
+
+
+
+#define PCON_FLG_ASYNC          (1)
+
+/* exported functions */
+
+extern int pcon_simple_cmd(unsigned int, unsigned int, unsigned int);
+#define pcon_set_usbhost_power(on)	\
+	pcon_simple_cmd(PCON_CMD_SetUSBPower, !!(on), PCON_FLG_ASYNC)
+#define pcon_set_mmc_power(on)		\
+	pcon_simple_cmd(PCON_CMD_SetMMCPower, !!(on), 0)
+#define pcon_set_modem_power(on)	\
+	pcon_simple_cmd(PCON_CMD_SetModemPower, !!(on), 0)
+#define pcon_set_serial_power(on)	\
+	pcon_simple_cmd(PCON_CMD_SetSerialPower, !!(on), PCON_FLG_ASYNC)
+
+#define pcon_monitorbattery(on, flag)	\
+	pcon_simple_cmd(PCON_CMD_BatteryMonitor, !!(on), flag)
+#define pcon_setredled(on)		\
+	pcon_simple_cmd(PCON_CMD_SetRedLED, !!(on), 0)
+
+extern int pcon_simple_write(unsigned int, unsigned int, unsigned int);
+#define pcon_kbd_ack()			\
+	pcon_simple_write(PCON_KEYBOARD_CMD_ADDR, PCON_KEYBOARD_CMD_VAL_READY, PCON_FLG_ASYNC)
+#define pcon_set_pcmcia_power(on)	\
+	pcon_simple_write(PCON_POWER_PCMCIA_ADDR, !!(on), 0)
+#define pcon_set_cf_power(on)		\
+	pcon_simple_write(PCON_POWER_CF_ADDR, !!(on), 0)
+
+struct rtc_time;
+extern int pcon_rtc_wakeup(struct rtc_time *tm);
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 8f8c81e..501fb5d 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -89,4 +89,14 @@ config SENSORS_TSL2550
 	  This driver can also be built as a module.  If so, the module
 	  will be called tsl2550.
 
+config LX_PCON
+	bool
+	depends on I2C=y && MACH_NETBOOKPRO
+	default y
+	help
+	  The LX PCON driver is required to communicate with the LX
+	  platform power control device.  This device is the heart
+	  of the system, providing power management and keyboard
+	  handling for the system.
+
 endmenu
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 55a3760..871c8ae 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_PCF8575)		+= pcf8575.o
+obj-$(CONFIG_LX_PCON)		+= lx-pcon.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
diff --git a/drivers/i2c/chips/lx-pcon.c b/drivers/i2c/chips/lx-pcon.c
new file mode 100644
index 0000000..67a0a5b
--- /dev/null
+++ b/drivers/i2c/chips/lx-pcon.c
@@ -0,0 +1,428 @@
+/*
+ *  linux/drivers/i2c/chips/lx-pcon.c
+ *
+ *  Driver for LX PCON chip
+ *  Copyright (C) 2004 Simtec Electronics
+ *
+ *  based on linux/drivers/acorn/char/pcf8583.c
+ *  Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+/* This driver provides the low-level i2c sending for the LX's
+ * power-management and general support processor. This allows other parts
+ * of the system to send messages to the chip for processing (including
+ * the userland)
+ *
+ * Note, this code does not provide the i2c client facilities needed by
+ * the PCon to send data to the systems that need information feeding in.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioctl.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+
+#include <mach/lx-pcon.h>
+
+struct pcon_client {
+	struct i2c_client	*client;
+	struct task_struct	*thread;
+	wait_queue_head_t	thr_wait;
+	struct platform_device	*kbd;
+	struct platform_device	*pwr;
+	void                   *pcon_dev;
+};
+
+/* pcon_cmd_ent
+ *
+ * command entry for the command queue
+*/
+
+struct pcon_cmd_ent {
+	struct pcon_cmd_ent	*next;
+	struct completion	done;
+
+	unsigned int		flags;
+
+#define PCON_FLG__ASYNC		(1 << 0)	/* defined elsewhere */
+#define PCON_FLG_CHKRDY		(1 << 1)
+#define PCON_FLG_RECVMSG	(1 << 2)
+
+	int			sendlen;
+	int			result;
+	unsigned char		sendmsg[16];
+	unsigned char		recvmsg[1];
+};
+
+static struct pcon_cmd_ent *queue;
+static struct pcon_client *cur_client;
+
+#define PCON_I2C_ADDR (0x26 >> 1)
+
+static int
+pcon_do_read(struct pcon_client *pc, int loc, unsigned char *result)
+{
+	struct i2c_client *client = pc->client;
+	unsigned char loc_data[1];
+	struct i2c_msg msgs[2] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= 1,
+			.buf	= loc_data,
+		}, {
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= 1,
+			.buf	= result,
+		}
+	};
+
+	loc_data[0] = loc;
+
+	return i2c_transfer(client->adapter, msgs, 2);
+}
+
+static int pcon_send(struct pcon_client *pc, unsigned char *data, int length)
+{
+	struct i2c_client *client = pc->client;
+	struct i2c_msg msgs[1] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= length,
+			.buf	= data
+		}
+	};
+
+	return i2c_transfer(client->adapter, msgs, 1) == 1 ? 1 : 0;
+}
+
+static int pcon_check_ready(struct pcon_client *client)
+{
+	unsigned char inbuff;
+	int ret;
+
+	while (1) {
+		/* the sfi code places this in the way to make sure that the
+		 * friendly pcon isn't going to ack us... dunno if this is
+		 * going to help us or not with our problems with reboot
+		 * after suspend...
+		 *
+		 * yep, this delay fixes the problem.
+		 */
+		msleep(100);
+
+		ret = pcon_do_read(client, PCON_CMD_ADDR, &inbuff);
+
+		if (ret == 2 && inbuff == PCON_CMD_Ready)
+			return 0;
+
+		/* ok, we didn't get an ok response, let us
+		 * wait for a little while and try again
+		 */
+		msleep(100);
+	}
+
+	return 0;
+}
+
+static int pcon_thread(void *param)
+{
+	struct pcon_client *pc = param;
+	unsigned long flags;
+	int ret;
+
+	current->flags |= PF_NOFREEZE;
+
+	while (1) {
+		struct pcon_cmd_ent *cmd;
+
+		wait_event_interruptible(pc->thr_wait, queue ||
+					 kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		/*
+		 * remove one item from the queue, and execute it
+		 */
+		local_irq_save(flags);
+		cmd = queue;
+		if (cmd != NULL)
+			queue = cmd->next;
+		local_irq_restore(flags);
+
+		if (!cmd)
+			continue;
+
+		if (cmd->flags & PCON_FLG_CHKRDY)
+			pcon_check_ready(pc);
+
+		if (cmd->flags & PCON_FLG_RECVMSG)
+			ret = pcon_do_read(pc, cmd->sendmsg[0], cmd->recvmsg);
+		else
+			ret = pcon_send(pc, cmd->sendmsg, cmd->sendlen);
+
+		cmd->result = ret;
+
+		if ((cmd->flags & PCON_FLG_ASYNC) == 0) {
+			complete(&cmd->done);
+		} else {
+			kfree(cmd);
+		}
+	}
+
+	return 0;
+}
+
+static int pcon_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct pcon_client *pc;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	dev_info(&client->dev, "LX: pcon found at 0x%02x\n", client->addr);
+
+	pc = kzalloc(sizeof(*pc), GFP_KERNEL);
+	if (pc == NULL) {
+		pr_err("pcon: no memory for pcon client data\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	pc->client = client;
+	i2c_set_clientdata(client, pc);
+
+	pc->kbd = platform_device_alloc("lx-kbd", -1);
+	pc->pwr = platform_device_alloc("lx-pwr", -1);
+	if (!pc->kbd || !pc->pwr) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	pc->kbd->dev.parent = &client->dev;
+	pc->pwr->dev.parent = &client->dev;
+
+	init_waitqueue_head(&pc->thr_wait);
+
+	cur_client = pc;
+
+	pc->thread = kthread_run(pcon_thread, pc, "pcon");
+	if (IS_ERR(pc->thread)) {
+		ret = PTR_ERR(pc->thread);
+		pr_err("pcon: cannot start thread: %d\n", ret);
+		goto done;
+	}
+
+	ret = platform_device_add(pc->kbd);
+	if (ret < 0)
+		goto done;
+
+	ret = platform_device_add(pc->pwr);
+	if (ret < 0) {
+		platform_device_del(pc->kbd);
+		goto done;
+	}
+
+	if (1) {
+		pr_info("Moving power state to Run\n");
+		pcon_pwr_setstate(PCON_PWRSTATE_Run);
+	}
+	ret = 0;
+
+done:
+	if (ret < 0) {
+		if (!IS_ERR(pc->thread) && pc->thread)
+			kthread_stop(pc->thread);
+		platform_device_put(pc->kbd);
+		platform_device_put(pc->pwr);
+		kfree(pc);
+	}
+
+	return ret;
+}
+
+static int pcon_remove(struct i2c_client *client)
+{
+	struct pcon_client *pc = i2c_get_clientdata(client);
+
+	platform_device_unregister(pc->pwr);
+	platform_device_unregister(pc->kbd);
+	kthread_stop(pc->thread);
+	kfree(pc);
+	return 0;
+}
+
+static int
+__pcon_command(struct pcon_client *pc, unsigned int flags, unsigned char *msg,
+		int len, int *result)
+{
+	struct pcon_cmd_ent *ent;
+	unsigned long irq_flags;
+	int ret = 0;
+
+	ent = kmalloc(sizeof(*ent), (flags & PCON_FLG_ASYNC)
+		? GFP_ATOMIC : GFP_KERNEL);
+	if (ent == NULL) {
+		pr_err("%s: no memory for command\n", __func__);
+		return -ENOMEM;
+	}
+
+	init_completion(&ent->done);
+	ent->next    = NULL;
+	ent->flags   = flags;
+	ent->sendlen = len;
+	memcpy(ent->sendmsg, msg, len);
+
+	local_irq_save(irq_flags);
+
+	if (queue == NULL) {
+		queue = ent;
+	} else {
+		struct pcon_cmd_ent *ptr = queue;
+
+		for (; ptr->next != NULL; ptr = ptr->next)
+			;
+
+		ptr->next = ent;
+	}
+
+	local_irq_restore(irq_flags);
+
+	if (pc != NULL)
+		wake_up(&pc->thr_wait);
+
+	if (flags & PCON_FLG_ASYNC) {
+		/* nothing to do, leave it to it. */
+	} else {
+		WARN_ON(pc == NULL);
+		wait_for_completion(&ent->done);
+
+		if (flags & PCON_FLG_RECVMSG) {
+			if (ent->result == 2) {
+				if (result)
+					*result = ent->recvmsg ? 1 : 0;
+				ret = 0;
+			} else
+				ret = ent->result;
+		}
+
+		/* dump this, we've been left with it*/
+		kfree(ent);
+	}
+
+	return ret;
+}
+
+int pcon_simple_cmd(unsigned int cmd, unsigned int val, unsigned int flags)
+{
+	unsigned char sendmsg[3];
+
+	might_sleep_if(flags != PCON_FLG_ASYNC);
+
+	sendmsg[0] = PCON_CMD_ADDR;
+	sendmsg[1] = cmd;
+	sendmsg[2] = val;
+
+	return __pcon_command(cur_client, flags | PCON_FLG_CHKRDY,
+			      sendmsg, sizeof(sendmsg), NULL);
+}
+EXPORT_SYMBOL(pcon_simple_cmd);
+
+int pcon_simple_write(unsigned int addr, unsigned int val, unsigned int flags)
+{
+	unsigned char sendmsg[2];
+
+	might_sleep_if(flags != PCON_FLG_ASYNC);
+
+	sendmsg[0] = addr;
+	sendmsg[1] = val;
+
+	return __pcon_command(cur_client, flags, sendmsg, sizeof(sendmsg),
+			      NULL);
+}
+EXPORT_SYMBOL(pcon_simple_write);
+
+int pcon_rtc_wakeup(struct rtc_time *tm)
+{
+	unsigned char sendmsg[10];
+
+	might_sleep();
+
+	sendmsg[0] = PCON_CMD_ADDR;
+	sendmsg[1] = PCON_CMD_SetWakeupAlarm;
+	sendmsg[2] = tm->tm_sec;
+	sendmsg[3] = tm->tm_min;
+	sendmsg[4] = tm->tm_hour;
+	sendmsg[5] = tm->tm_wday; /* 6 = Saturday */
+	sendmsg[6] = tm->tm_mday; /* 1 = 1st */
+	sendmsg[7] = tm->tm_mon;
+	sendmsg[8] = tm->tm_year >> 8;
+	sendmsg[9] = tm->tm_year & 255;
+
+	return __pcon_command(cur_client, PCON_FLG_CHKRDY, sendmsg,
+			      sizeof(sendmsg), NULL);
+}
+EXPORT_SYMBOL(pcon_rtc_wakeup);
+
+void pcon_pwr_setstate(pcon_pwrstate_t pwrstate)
+{
+	unsigned char sendmsg[2];
+
+	if (cur_client == NULL) {
+		pr_err("%s: no client for write\n", __func__);
+		return;
+	}
+
+	sendmsg[0] = PCON_PWRSTATE_ADDR;
+	sendmsg[1] = pwrstate;
+
+	pcon_send(cur_client, sendmsg, sizeof(sendmsg));
+}
+
+
+static const struct i2c_device_id pcon_id[] = {
+	{ "lxpcon", 0 },
+	{ }
+};
+
+static struct i2c_driver pcon_driver = {
+	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= "pcon",
+	},
+	.id_table	= pcon_id,
+	.probe		= pcon_probe,
+	.remove		= pcon_remove,
+};
+
+static __init int pcon_init(void)
+{
+	return i2c_add_driver(&pcon_driver);
+}
+
+static __exit void pcon_exit(void)
+{
+	i2c_del_driver(&pcon_driver);
+}
+
+MODULE_AUTHOR("Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
+MODULE_DESCRIPTION("Psion Teklogix NetBookPro PCon chip driver");
+
+module_init(pcon_init);
+module_exit(pcon_exit);
-- 
1.6.0.6
