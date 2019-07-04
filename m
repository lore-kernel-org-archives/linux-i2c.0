From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Generic get_something from an i2c_client
Date: Thu, 4 Jul 2019 18:43:39 +0200
Message-ID: <07aa1229-2b67-e191-5740-70e6ed2a8ce3@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, Peter Korsgaard <peter.korsgaard@barco.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, I2C <linux-i2c@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-media <linux-media@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

In media drivers, TS drivers typically hard-code their front-end (demod and tuner)
init by loading the modules themselves.

I feel this is not a good solution for SoCs, where the TS HW might be on the SoC,
and the front-end be on the board. So we may have different front-ends for
different boards, and the driver would have to hard-code all of them.

Am I making sense?

Here's an example of what I mean:
https://elixir.bootlin.com/linux/latest/source/drivers/media/usb/dvb-usb-v2/dvbsky.c#L466

I've been working on defining the demod in DT, and having a phandle
to the demod in the TSIF node.

I've got everything working like I had hoped, but I have many ugly hacks.

The TSIF driver needs to register the frontend, which is created in
the demod driver.

So I have:

	struct device_node *toto = of_parse_phandle(np, "demod", 0);
	if (!toto) panic("of_parse_phandle");
	struct i2c_client *demod = of_find_i2c_device_by_node(toto);
	if (!demod) panic("of_find_i2c_device_by_node");
	printk("\tdemod=%px\n", demod);
	struct dvb_frontend *get_fe(struct i2c_client *client);
	my_dvb_frontend = get_fe(demod);

The problem is get_fe(). It needs to be a call-back, so that every
demod can implement his own version. But only a few i2c_client's
have a dvb_frontend to return.

Could we have a generic void *get_something() callback in struct i2c_client?
(Seems like the wrong place)

How can I solve this conundrum?

Maybe look above i2c, in struct device?

Regards.
