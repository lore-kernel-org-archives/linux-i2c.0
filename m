From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH/RFC v2 3/4] hwmon: pmbus driver documentation
Date: Sun, 4 Jul 2010 21:10:17 -0700
Message-ID: <1278303018-22069-4-git-send-email-guenter.roeck@ericsson.com>
References: <1278303018-22069-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278303018-22069-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 Documentation/hwmon/pmbus |  139 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/pmbus

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
new file mode 100644
index 0000000..f5c256b
--- /dev/null
+++ b/Documentation/hwmon/pmbus
@@ -0,0 +1,139 @@
+Kernel driver pmbus
+====================
+
+Supported chips:
+  * Ericsson BMR45X series
+    DC/DC Converter
+    Prefix: 'bmr45x'
+    Addresses scanned: -
+    Datasheet:
+ http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146395
+  * Linear Technology LTC2978
+    Octal PMBus Power Supply Monitor and Controller
+    Prefix: 'ltc2978'
+    Addresses scanned: -
+    Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
+  * Maxim MAX16064
+    Quad Power-Supply Controller
+    Prefix: 'max16064'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX16064.pdf
+  * Maxim MAX8688
+    Digital Power-Supply Controller/Monitor
+    Prefix: 'max8688'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX8688.pdf
+  * Texas Instruments UCD92xx
+    Digital PWM System Controller
+    Prefix: 'ucd921x', 'ucd9220', 'ucd9240'
+    Addresses scanned: -
+    Datasheet: http://focus.ti.com/lit/ds/symlink/ucd9240.pdf
+  * Generic PMBus devices
+    Prefix: 'pmbus'
+    Addresses scanned: -
+    Datasheet: n.a.
+
+Author: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
+
+
+Description
+-----------
+
+This driver supports hardware montoring for various PMBus compliant devices.
+It supports voltage, current, power, and temperature sensors as supported
+by the device.
+
+Each monitored channel has its own high and low limits, plus a critical
+limit.
+
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices, since there is no register
+which can be safely used to identify the chip (The MFG_ID register is not
+supported by all chips), and since there is no well defined address range for
+PMBus devices. You will have to instantiate the devices explicitly.
+
+Example: the following will load the driver for an LTC2978 at address 0x60
+on I2C bus #1:
+$ modprobe pmbus
+$ echo ltc2978 0x60 > /sys/bus/i2c/devices/i2c-1/new_device
+
+
+Sysfs entries
+-------------
+
+When probing the chip, the driver identifies which PMBus registers are
+supported, and determines available sensors from this information.
+Attribute files only exist if respective sensors are suported by the chip.
+Labels are provided to inform the user about the sensor associated with
+a given sysfs entry.
+
+The following attributes are supported. Limits are read-write; all other
+attributes are read-only.
+
+inX_input		Measured voltage. From READ_VIN or READ_VOUT register.
+inX_min			Minumum Voltage.
+			From VIN_UV_WARN_LIMIT or VOUT_UV_WARN_LIMIT register.
+inX_max			Maximum voltage.
+			From VIN_OV_WARN_LIMIT or VOUT_OV_WARN_LIMIT register.
+inX_lcrit		Critical minumum Voltage.
+			From VIN_UV_FAULT_LIMIT or VOUT_UV_FAULT_LIMIT register.
+inX_crit		Critical maximum voltage.
+			From VIN_OV_FAULT_LIMIT or VOUT_OV_FAULT_LIMIT register.
+inX_min_alarm		Voltage low alarm. From VOLTAGE_UV_WARNING status.
+inX_max_alarm		Voltage high alarm. From VOLTAGE_OV_WARNING status.
+inX_lcrit_alarm		Voltage critical low alarm.
+			From VOLTAGE_UV_FAULT status.
+inX_crit_alarm		Voltage critical high alarm.
+			From VOLTAGE_OV_FAULT status.
+inX_label		"vin", "vcap", or "voutY"
+
+currX_input		Measured current. From READ_IIN or READ_IOUT register.
+currX_max		Maximum current.
+			From IIN_OC_WARN_LIMIT or IOUT_OC_WARN_LIMIT register.
+currX_lcrit		Critical minumum output current.
+			From IOUT_UC_FAULT_LIMIT register.
+currX_crit		Critical maximum current.
+			From IIN_OC_FAULT_LIMIT or IOUT_OC_FAULT_LIMIT register.
+currX_alarm		Current high alarm.
+			From IIN_OC_WARNING or IOUT_OC_WARNING status.
+currX_lcrit_alarm	Output current critical low alarm.
+			From IOUT_UC_FAULT status.
+currX_crit_alarm	Current critical high alarm.
+			From IIN_OC_FAULT or IOUT_OC_FAULT status.
+currX_label		"iin" or "vinY"
+
+powerX_input		Measured power. From READ_PIN or READ_POUT register.
+powerX_cap		Output power cap. From POUT_MAX register.
+powerX_max		Power limit. From PIN_OP_WARN_LIMIT or
+			POUT_OP_WARN_LIMIT register.
+powerX_crit		Critical output power limit.
+			From POUT_OP_FAULT_LIMIT register.
+powerX_alarm		Power high alarm.
+			From PIN_OP_WARNING or POUT_OP_WARNING status.
+powerX_crit_alarm	Output power critical high alarm.
+			From POUT_OP_FAULT status.
+powerX_label		"pin" or "poutY"
+
+tempX_input		Measured tempererature.
+			From READ_TEMPERATURE_X register.
+tempX_min		Mimimum tempererature. From UT_WARN_LIMIT register.
+tempX_max		Maximum tempererature. From OT_WARN_LIMIT register.
+tempX_lcrit		Critical low tempererature.
+			From UT_FAULT_LIMIT register.
+tempX_crit		Critical high tempererature.
+			From OT_FAULT_LIMIT register.
+tempX_min_alarm		Chip temperature low alarm. Set by comparing
+			READ_TEMPERATURE_X with UT_WARN_LIMIT if
+			TEMP_UT_WARNING status is set.
+tempX_max_alarm		Chip temperature high alarm. Set by comparing
+			READ_TEMPERATURE_X with OT_WARN_LIMIT if
+			TEMP_OT_WARNING status is set.
+tempX_lcrit_alarm	Chip temperature critical low alarm. Set by comparing
+			READ_TEMPERATURE_X with UT_FAULT_LIMIT if
+			TEMP_UT_FAULT status is set.
+tempX_crit_alarm	Chip temperature critical high alarm. Set by comparing
+			READ_TEMPERATURE_X with OT_FAULT_LIMIT if
+			TEMP_OT_FAULT status is set.
-- 
1.7.0.87.g0901d
