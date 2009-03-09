From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Document the different ways to instantiate i2c devices
Date: Mon, 9 Mar 2009 11:45:20 +0100
Message-ID: <20090309114520.4e520246@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On popular demand, here comes some documentation about how to
instantiate i2c devices in the new (standard) i2c device driver
binding model.

I have also clarified how the class bitfield lets driver authors
control which buses are probed in the auto-detect case, and warned
more loudly against the abuse of this method.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
---
 Documentation/i2c/instantiating-devices |  167 +++++++++++++++++++++++++++++++
 Documentation/i2c/writing-clients       |   19 ++-
 2 files changed, 182 insertions(+), 4 deletions(-)

--- linux-2.6.29-rc7.orig/Documentation/i2c/writing-clients	2009-03-08 20:03:46.000000000 +0100
+++ linux-2.6.29-rc7/Documentation/i2c/writing-clients	2009-03-08 22:36:28.000000000 +0100
@@ -207,15 +207,26 @@ You simply have to define a detect callb
 identify supported devices (returning 0 for supported ones and -ENODEV
 for unsupported ones), a list of addresses to probe, and a device type
 (or class) so that only I2C buses which may have that type of device
-connected (and not otherwise enumerated) will be probed.  The i2c
-core will then call you back as needed and will instantiate a device
-for you for every successful detection.
+connected (and not otherwise enumerated) will be probed.  For example,
+a driver for a hardware monitoring chip for which auto-detection is
+needed would set its class to I2C_CLASS_HWMON, and only I2C adapters
+with a class including I2C_CLASS_HWMON would be probed by this driver.
+Note that the absence of matching classes does not prevent the use of
+a device of that type on the given I2C adapter.  All it prevents is
+auto-detection; explicit instantiation of devices is still possible.
 
 Note that this mechanism is purely optional and not suitable for all
 devices.  You need some reliable way to identify the supported devices
 (typically using device-specific, dedicated identification registers),
 otherwise misdetections are likely to occur and things can get wrong
-quickly.
+quickly.  Keep in mind that the I2C protocol doesn't include any
+standard way to detect the presence of a chip at a given address, let
+alone a standard way to identify devices.  Even worse is the lack of
+semantics associated to bus transfers, which means that the same
+transfer can be seen as a read operation by a chip and as a write
+operation by another chip.  For these reasons, explicit device
+instantiation should always be preferred to auto-detection where
+possible.
 
 
 Device Deletion
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.29-rc7/Documentation/i2c/instantiating-devices	2009-03-09 11:37:33.000000000 +0100
@@ -0,0 +1,167 @@
+How to instantiate I2C devices
+==============================
+
+Unlike PCI or USB devices, I2C devices are not enumerated at the hardware
+level. Instead, the software must know which devices are connected on each
+I2C bus segment, and what address these devices are using. For this
+reason, the kernel code must instantiate I2C devices explicitly. There are
+several ways to achieve this, depending on the context and requirements.
+
+
+Method 1: Declare the I2C devices by bus number
+-----------------------------------------------
+
+This method is appropriate when the I2C bus is a system bus as is the case
+for many embedded systems. On such systems, each I2C bus has a number
+which is known in advance. It is thus possible to pre-declare the I2C
+devices which live on this bus. This is done with an array of struct
+i2c_board_info which is registered by calling i2c_register_board_info().
+
+Example (from omap2 h4):
+
+static struct i2c_board_info __initdata h4_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("isp1301_omap", 0x2d),
+		.irq		= OMAP_GPIO_IRQ(125),
+	},
+	{	/* EEPROM on mainboard */
+		I2C_BOARD_INFO("24c01", 0x52),
+		.platform_data	= &m24c01,
+	},
+	{	/* EEPROM on cpu card */
+		I2C_BOARD_INFO("24c01", 0x57),
+		.platform_data	= &m24c01,
+	},
+};
+
+static void __init omap_h4_init(void)
+{
+	(...)
+	i2c_register_board_info(1, h4_i2c_board_info,
+			ARRAY_SIZE(h4_i2c_board_info));
+	(...)
+}
+
+The above code declares 3 devices on I2C bus 1, including their respective
+addresses and custom data needed by their drivers. When the I2C bus in
+question is registered, the I2C devices will be instantiated automatically
+by i2c-core.
+
+The devices will be automatically unbound and destroyed when the I2C bus
+they sit on goes away (if ever.)
+
+
+Method 2: Instantiate the devices explicitly
+--------------------------------------------
+
+This method is appropriate when a larger device uses an I2C bus for
+internal communication. A typical case is TV adapters. These can have a
+tuner, a video decoder, an audio decoder, etc. usually connected to the
+main chip by the means of an I2C bus. You won't know the number of the I2C
+bus in advance, so the method 1 described above can't be used. Instead,
+you can instantiate your I2C devices explicitly. This is done by filling
+a struct i2c_board_info and calling i2c_new_device().
+
+Example (from the sfe4001 network driver):
+
+static struct i2c_board_info sfe4001_hwmon_info = {
+	I2C_BOARD_INFO("max6647", 0x4e),
+};
+
+int sfe4001_init(struct efx_nic *efx)
+{
+	(...)
+	efx->board_info.hwmon_client =
+		i2c_new_device(&efx->i2c_adap, &sfe4001_hwmon_info);
+
+	(...)
+}
+
+The above code instantiates 1 I2C device on the I2C bus which is on the
+network adapter in question.
+
+A variant of this is when you don't know for sure if an I2C device is
+present or not (for example for an optional feature which is not present
+on cheap variants of a board but you have no way to tell them apart), or
+it may have different addresses from one board to the next (manufacturer
+changing its design without notice). In this case, you can call
+i2c_new_probed_device() instead of i2c_new_device().
+
+Example (from the pnx4008 OHCI driver):
+
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
+
+static int __devinit usb_hcd_pnx4008_probe(struct platform_device *pdev)
+{
+	(...)
+	struct i2c_adapter *i2c_adap;
+	struct i2c_board_info i2c_info;
+
+	(...)
+	i2c_adap = i2c_get_adapter(2);
+	memset(&i2c_info, 0, sizeof(struct i2c_board_info));
+	strlcpy(i2c_info.name, "isp1301_pnx", I2C_NAME_SIZE);
+	isp1301_i2c_client = i2c_new_probed_device(i2c_adap, &i2c_info,
+						   normal_i2c);
+	i2c_put_adapter(i2c_adap);
+	(...)
+}
+
+The above code instantiates up to 1 I2C device on the I2C bus which is on
+the OHCI adapter in question. It first tries at address 0x2c, if nothing
+is found there it tries address 0x2d, and if still nothing is found, it
+simply gives up.
+
+The driver which instantiated the I2C device is responsible for destroying
+it on cleanup. This is done by calling i2c_unregister_device() on the
+pointer that was earlier returned by i2c_new_device() or
+i2c_new_probed_device().
+
+
+Method 3: Probe an I2C bus for certain devices
+----------------------------------------------
+
+Sometimes you do not have enough information about an I2C device, not even
+to call i2c_new_probed_device(). The typical case is hardware monitoring
+chips on PC mainboards. There are several dozen models, which can live
+at 25 different addresses. Given the huge number of mainboards out there,
+it is next to impossible to build an exhaustive list of the hardware
+monitoring chips being used. Fortunately, most of these chips have
+manufacturer and device ID registers, so they can be identified by
+probing.
+
+In that case, I2C devices are neither declared nor instantiated
+explicitly. Instead, i2c-core will probe for such devices as soon as their
+drivers are loaded, and if any is found, an I2C device will be
+instantiated automatically. In order to prevent any misbehavior of this
+mechanism, the following restrictions apply:
+* The I2C device driver must implement the detect() method, which
+  identifies a supported device by reading from arbitrary registers.
+* Only buses which are likely to have a supported device and agree to be
+  probed, will be probed. For example this avoids probing for hardware
+  monitoring chips on a TV adapter.
+
+Example:
+See lm90_driver and lm90_detect() in drivers/hwmon/lm90.c
+
+I2C devices instantiated as a result of such a successful probe will be
+destroyed automatically when the driver which detected them is removed,
+or when the underlying I2C bus is itself destroyed, whichever happens
+first.
+
+Those of you familiar with the i2c subsystem of 2.4 kernels and early 2.6
+kernels will find out that this method 3 is essentially similar to what
+was done there. Two significant differences are:
+* Probing is only one way to instantiate I2C devices now, while it was the
+  only way back then. Where possible, methods 1 and 2 should be preferred.
+  Method 3 should only be used when there is no other way, as it can have
+  undesirable side effects.
+* I2C buses must now explicitly say which I2C driver classes can probe
+  them (by the means of the class bitfield), while all I2C buses were
+  probed by default back then. The default is an empty class which means
+  that no probing happens. The purpose of the class bitfield is to limit
+  the aforementioned undesirable side effects.
+
+Once again, method 3 should be avoided wherever possible. Explicit device
+instantiation (methods 1 and 2) is much preferred for it is safer and
+faster.


-- 
Jean Delvare
