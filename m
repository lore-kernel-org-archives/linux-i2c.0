From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/1] i2c: core: add of_get_i2c_adapter_by_node
Date: Mon, 29 Jun 2015 17:14:44 +0300
Message-ID: <559152D4.10903@mentor.com>
References: <5590E763.3090703@mentor.com> <20150629081717.GA1586@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150629081717.GA1586@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "Frkuska, Joshua" <joshua_frkuska-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 29.06.2015 11:17, Wolfram Sang wrote:
> On Mon, Jun 29, 2015 at 03:36:19PM +0900, Frkuska, Joshua wrote:
>> This adds of_get_i2c_adapter_by_node which both finds and properly
>> increments the adapter reference count.
>>
>> This is different from of_find_i2c_device_by_node which does not
>> increment the adapter reference counter.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Joshua Frkuska <joshua_frkuska-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> 
> What is your use case?

the usecase is to avoid double getting of a pointer to the wanted struct
i2c_adapter with incrementing its user counter at once, now it is done
in two stages, namely find adapter and get adapter:

------8<------

 	struct i2c_adapter *ddc;
 	int id;
 ...

-	ddc = of_find_i2c_adapter_by_node(ddc_node);
-	if (ddc) {
-		id = i2c_adapter_id(dcc);
-		dcc = i2c_get_adapter(id);
+	dcc = of_get_i2c_adapter_by_node(ddc);
+	if (dcc)
+		put_device(&ddc->dev);
 		put_device(&ddc->dev);
-	}

 ...
 	i2c_put_adapter(ddc);

------8<------

Since i2c adapted is locked by client, it might have sense to add
put_device() hidden inside of_get_i2c_adapter_by_node().


> Which code will be using this function?
>

At the moment there is an intention to add clients in drivers/gpu/drm/*,
who should lock i2c bus driver to sustain DDC lines.


By the way to the current version the correspondent change in
include/linux/i2c.h is missing:

------8<------

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e83a738..555ad9c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -638,6 +638,9 @@ extern struct i2c_client
*of_find_i2c_device_by_node(struct device_node *node);
 /* must call put_device() when done with returned i2c_adapter device */
 extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct
device_node *node);

+/* must call put_device() when done with returned i2c_adapter device */
+extern struct i2c_adapter *of_get_i2c_adapter_by_node(struct
device_node *node);
+
 #else

 static inline struct i2c_client *of_find_i2c_device_by_node(struct
device_node *node)
@@ -649,6 +652,11 @@ static inline struct i2c_adapter
*of_find_i2c_adapter_by_node(struct device_node
 {
 	return NULL;
 }
+
+static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct
device_node *node)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF */

 #endif /* _LINUX_I2C_H */

------8<------

--
With best wishes,
Vladimir
