From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [RFC] SW connection between DVB Transport Stream demuxer and
 I2C-based frontend
Date: Mon, 8 Jul 2019 17:03:55 +0200
Message-ID: <79b9bd5e-be05-daa8-0d16-d84a383138a7@free.fr>
References: <5e35b4fb-646d-6428-f372-ee47d7352cd6@free.fr>
 <b6abf5a2-3151-29e5-8eb7-c960580fd4ea@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b6abf5a2-3151-29e5-8eb7-c960580fd4ea@metux.net>
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
To: Enrico Weigelt <lkml@metux.net>, I2C <linux-i2c@vger.kernel.org>, linux-media <linux-media@vger.kernel.org>, GPIO <linux-gpio@vger.kernel.org>
Cc: Peter Korsgaard <peter@korsgaard.com>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Brad Love <brad@nextdimension.cc>, =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, Antti Palosaari <crope@iki.fi>, Simon Horman <horms+renesas@verge.net.au>, Mauro Carvalho Chehab <mchehab@kernel.org>, Olli Salonen <olli.salonen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 08/07/2019 16:44, Enrico Weigelt wrote:

> On 08.07.19 13:08, Marc Gonzalez wrote:
> 
>> The tuner (si2157) is not on the i2c5 bus, instead it is on a private
>> i2c bus *behind* si2168, which routes requests to the proper client.
> 
> Should the si2168 make up its own i2c controller ?

It does AFAIU ;-)

https://elixir.bootlin.com/linux/latest/source/drivers/media/dvb-frontends/si2168.c#L780

	/* create mux i2c adapter for tuner */
	dev->muxc = i2c_mux_alloc(client->adapter, &client->dev, 1, 0, I2C_MUX_LOCKED, si2168_select, si2168_deselect);

	ret = i2c_mux_add_adapter(dev->muxc, 0, 0, 0);

	/* this is the new internal i2c bus */
	struct i2c_adapter *si2168_bus = dev->muxc->adapter[0];


One problem is that since the internal bus is "created" (declared?) at run-time,
it doesn't seem possible to define it (or its client) in DT.

Regards.
