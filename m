From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: core: make it possible to match a pure device tree driver
Date: Mon, 13 May 2013 11:26:32 +0200
Message-ID: <CACRpkdawcx-AZhKGWffj0WFAWfbAEAw6XPmJo5Te0NaUcrF79g@mail.gmail.com>
References: <1368397583-22769-1-git-send-email-linus.walleij@linaro.org>
	<20130513071637.GD32299@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130513071637.GD32299-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 13, 2013 at 9:16 AM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

>> -     status = driver->probe(client, i2c_match_id(driver->id_table, client));
>> +     if (dev->driver->of_match_table)
>> +             /* Device tree matching */
>> +             status = driver->probe(client, NULL);
>> +     else
>> +             /* Fall back to matching the id_table */
>> +             status = driver->probe(client, i2c_match_id(driver->id_table, client));
>
> If you correctly register a device with "vendor,product" in the devicetree
> the driver can already fetch the of_device_id using of_match_device(dt_ids, &client->dev)
> just like a platform driver would do aswell.

Yes, this is what I write in the commit message:

  "(...) If the driver wants to deduce secondary info
  from the struct of_device_id .data field, it has to call
  of_match_device() on its own match table in the probe function
  device tree probe path."

> i2c_match_id will return a NULL pointer if called with "vendor,product",
> because nothing matches in the drivers id_table, so for this case you
> change nothing.
>
> If anything, you introduce the problem that a devicetree capable driver
> no longer gets a i2c_device_id if the device was instantiated with
> i2c_board_info.

Hm, you're right there, what about this:

+     if (dev->of_node)
+             /* Device tree matching */
+             status = driver->probe(client, NULL);
+     else
+             /* Fall back to matching the id_table */
+             status = driver->probe(client,
i2c_match_id(driver->id_table, client));

If the device has an of_node it surely should not be using the
id_table and it'd be correct to pass NULL, right?

Yours,
Linus Walleij
