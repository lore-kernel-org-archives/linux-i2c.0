From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Documentation issue on attaching new style drivers
Date: Tue, 3 Jun 2008 16:35:37 +0200
Message-ID: <20080603163537.22c69aff@hyperion.delvare>
References: <20080603103450.GA8391@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080603103450.GA8391-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Tue, 3 Jun 2008 11:34:50 +0100, Ben Dooks wrote:
> Quoting from Documentation/i2c/writing-clients, the section
> entitled "Standard Driver Model Binding ("New Style")" has
> the following paragraph:
> 
> Drivers match devices when i2c_client.driver_name and the driver name are
> the same; this approach is used in several other busses that don't have
> device typing support in the hardware.  The driver and module name should
> match, so hotplug/coldplug mechanisms will modprobe the driver.
> 
> Having tried this whilst upgrading an old driver in my own
> tree, I found that this does not work, and that you need to
> supply your own idtable for the .id_table entry.
> 
> I had a quick look in drivers/i2c/i2c-core.c and it seems
> that the only thing the .match entry i2c_device_match() 
> is doing is checking the driver's id_table, as so:
> 
> static int i2c_device_match(struct device *dev, struct device_driver *drv)
> {
> 	struct i2c_client	*client = to_i2c_client(dev);
> 	struct i2c_driver	*driver = to_i2c_driver(drv);
> 
> 	/* make legacy i2c drivers bypass driver model probing entirely;
> 	 * such drivers scan each i2c adapter/bus themselves.
> 	 */
> 	if (!is_newstyle_driver(driver))
> 		return 0;
> 
> 	/* match on an id table if there is one */
> 	if (driver->id_table)
> 		return i2c_match_id(driver->id_table, client) != NULL;
> 
> 	return 0;
> }
> 
> Is the documentation wrong, and all drivers need to have an id_table
> in them, or is the i2c-core.c wrong for only checking the id_table
> entries?

The documentation is wrong, or more precisely, it's out-of-date. It was
correct when it was written, but the i2c subsystem was updated since
then and I forgot to update this piece of documentation. Do you feel
like submitting a patch fixing it?

> My suspicion is that everyone is using the id_table as this can be
> passed to the MODULE_DEVICE_TABLE() to allow autoloading of the
> relevant modules? Note, the i2c_probe function will correctly pass
> a NULL ID if there is no id_table present.

The id_table is mandatory. The i2c_device_probe() function can be
simplified now, as it will never be called if driver->id_table is NULL.
I'll send a patch right now, thanks for pointing this out.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
