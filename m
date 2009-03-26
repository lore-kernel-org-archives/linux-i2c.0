From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Thu, 26 Mar 2009 09:59:12 +0100
Message-ID: <49CB43E0.2050503@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>

After system startup currently there is no way to add an i2c client to
subsystem. This may occur if the client sits on a subsystem that was
powerless at the beginning or is plugged in at runtime.
This patch adds ioctl to /dev/i2c-X to initiate a probe of an client and
to remove a client that may have gone.
Example:
fd=open("/dev/i2c-1",O_RDWR);
ioctl(fd,I2C_PROBE,"lm75,0x49");
close(fd);
will start probing of an lm75 compatible sensor at bus 1, id 0x49
ioctl(fd,I2C_REMOVE,0x49)
removes it again.

Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Add ioctls I2C_PROBE and I2C_REMOVE to /dev/i2c-x

 drivers/i2c/i2c-dev.c   |   50
++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c-dev.h |    2 +
 2 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index c171988..82cbe7f
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -367,9 +367,22 @@ static noinline int i2cdev_ioctl_smbus(struct
i2c_client *client,
 	return res;
 }

+static int i2c_check_addr(struct device *dev, void *addrp)
+{
+	struct i2c_client	*client = i2c_verify_client(dev);
+	int			addr = *(int *)addrp;
+
+	if (client && client->addr == addr)
+		return -EBUSY;
+	return 0;
+}
+
 static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned
long arg)
 {
-	struct i2c_client *client = (struct i2c_client *)file->private_data;
+	struct i2c_client *bus_client, *client = (struct i2c_client
*)file->private_data;
+	struct i2c_board_info bInfo;
+	struct device *dev;
+	char   *colon, request[I2C_NAME_SIZE + 5];
 	unsigned long funcs;

 	dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",
@@ -424,6 +437,41 @@ static long i2cdev_ioctl(struct file *file,
unsigned int cmd, unsigned long arg)
 	case I2C_TIMEOUT:
 		client->adapter->timeout = arg;
 		break;
+	case I2C_PROBE:
+		memset(&bInfo, 0, sizeof(bInfo));
+		copy_from_user(request, (char *)arg, sizeof(request));
+
+		colon = strchr(request, ',');
+		if((!colon) || (colon - request > I2C_NAME_SIZE - 1))
+			return -EINVAL;
+
+		strncpy(bInfo.type, request, colon - request);
+		bInfo.type[I2C_NAME_SIZE - 1] = '\0';
+		bInfo.addr = simple_strtoul(colon + 1, NULL, 0);
+
+		bus_client = i2c_new_device(client->adapter, &bInfo);
+
+		if(!bus_client)
+			return -EIO;
+			
+		if(!bus_client->driver)
+		{
+			/* probe failed -> cleanup */
+			i2c_unregister_device(bus_client);
+			return -ENODEV;
+		}
+		break;
+	case I2C_REMOVE:
+		dev = device_find_child(&client->adapter->dev, &arg, i2c_check_addr);
+		if (!dev)
+			return -ENODEV;
+
+		bus_client = i2c_verify_client(dev);
+		if(!bus_client)
+			return -EIO;
+
+		i2c_unregister_device(bus_client);
+		break;
 	default:
 		/* NOTE:  returning a fault code here could cause trouble
 		 * in buggy userspace code.  Some old kernel bugs returned
diff --git a/include/linux/i2c-dev.h b/include/linux/i2c-dev.h
index 311315b..8b66638
--- a/include/linux/i2c-dev.h
+++ b/include/linux/i2c-dev.h
@@ -50,6 +50,8 @@
 #define I2C_PEC		0x0708	/* != 0 to use PEC with SMBus */
 #define I2C_SMBUS	0x0720	/* SMBus transfer */

+#define I2C_PROBE   0x0730  /* Probe for client "<name>,<addr>" */
+#define I2C_REMOVE  0x0731  /* Remove client <addr> */

 /* This is the structure as used in the I2C_SMBUS ioctl call */
 struct i2c_smbus_ioctl_data {
