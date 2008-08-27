From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Wed, 27 Aug 2008 09:40:22 -0400
Message-ID: <9e4733910808270640h2e5fb88fn46548d3630b7f45d@mail.gmail.com>
References: <200808251941.54964.david-b@pacbell.net>
	<200808261335.36103.david-b@pacbell.net>
	<Pine.LNX.4.58.0808261852580.2423@shell2.speakeasy.net>
	<200808270019.12987.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200808270019.12987.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 8/27/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Tuesday 26 August 2008, Trent Piepho wrote:
>  > Lots of tv cards have eeproms with configuration information.  They use an
>  > I2C driver called tveeprom that exports this:
>  >
>  > int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len)
>
>
> That presumes the driver somehow has access to that I2C client.

How about using bus_find_device? PowerPC uses it to locate the i2c
device using pointers in the device tree.

+static int of_dev_node_match(struct device *dev, void *data)
+{
+        return dev->archdata.of_node == data;
+}
+
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	struct device *dev;
+	
+	dev = bus_find_device(&i2c_bus_type, NULL, node,
+					 of_dev_node_match);
+	if (!dev)
+		return NULL;
+		
+	return to_i2c_client(dev);
+}
+EXPORT_SYMBOL(of_find_i2c_device_by_node);
+




>
>  (Also, that it's an I2C EEPROM.  I keep wanting to have something
>  usable for SPI EEPROMs and NVRAM too.  But maybe nobody else cares.)
>
>
>
>  > > Last I heard, the U-Boot policy was not to touch controllers that are
>  > > not required during boot.  Despite relatively common cases like needing
>  > > to set up MAC addresses ... maybe this patch of Kevin's can make it a
>  > > bunch easier to cope with that U-Boot policy.  :)
>  >
>  > U-boot can put the MAC address into a property of the MAC's device node in
>  > the OF device tree (which u-boot passes to the kernel).
>
>
> Maybe with PowerPC it does.  Not on ARM.  ;)
>
>
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
