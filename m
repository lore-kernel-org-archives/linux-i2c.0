From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Q: i2c-mux-pca954x.c : How to get deselect activated via device tree?
Date: Fri, 24 Oct 2014 13:25:36 +0200
Message-ID: <544A3730.9080007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

there is means to unselect I2C multiplexer pca954x after every transfer.
I've now run into situation where I need this feature: When two 
multiplexers are on same bus and they host devices with same address.

I could not yet find out from documentation or sources how to get 
deselect feature enabled:

i2c-mux-pca954x.c:pca954x_probe()
...
			i2c_add_mux_adapter(adap, &client->dev, client,
				force, num, class, pca954x_select_chan,
				(pdata && pdata->modes[num].deselect_on_exit)
					? pca954x_deselect_mux : NULL);
...

How to initialize pdata->modes[num].deselect_on_exit?
Some attribute in device tree should do the trick, shouldn't it?

Has anybody a useful hint?

-- 
KR
Michael
