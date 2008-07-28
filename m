From: Matti Kaasinen <matti.kaasinen-91aMuT3/2DXHOG6cAo2yLw@public.gmane.org>
Subject: at24.c, how to get kobject for sysfs/bin_attribute methods?
Date: Mon, 28 Jul 2008 09:20:03 +0300
Message-ID: <488D6513.6070701@sitecno.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all!

Background first (quite a lot of it) --------------

At24.c seems supporting:
ssize_t (*read)(struct kobject *, char *, loff_t, size_t) and
ssize_t (*write)(struct kobject *, char *, loff_t, size_t) methods to 
provide access to i2c clients through sysfs/bin_attribute interface. It 
expects "struct kobject *" parameter to be the embedded kobject of 
struct i2c_client    (->dev->kobj). Based on this facet at24.c expands 
koject parameter to i2c_client (container_of .. container_of) and 
executes required i2c_transfer transactions. Therefore, kernel modules 
wanting to access i2c devices through at24.c should be able to point the 
kobject embedded within the i2c_client structure.

I have not found quite solid method for this purpose in this "new" 
device model where drivers and devices get paired somewhere after boot 
up. Best choice I've found so far is using following helper functions 
iterating over devices and drivers on i2c_bus_type to find i2c_device 
matching required name/address:

int bus_for_each_dev(struct bus_type *bus, struct device *start,
void *data, int (*fn)(struct device *, void *));

int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
void *data, int (*fn)(struct device_driver *, void *));

Problem with these functions at the moment is that i2_bus_type is not 
exported at least in 2.6.24 kernel that I'm playing with. I've seen 
export patches around and discussion for exporting/not exporting it.

Questions ----------

Do anyone know plans for exporting it in future releases? Do anyone know 
better solution for other kernel module finding the correct kobject 
reference for selected i2c device (e.g. by name) to be used as parameter 
to bin_attribute read/write method?

thanks, Matti Kaasinen

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
