From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Model Divider in CCF
Date: Tue, 28 May 2019 09:52:21 +0200
Message-ID: <716a7b8a-c2f8-a3c4-0b3a-be3cb26a6c12@i2se.com>
References: <20190508071227.18609-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190508071227.18609-1-nh6z@nh6z.net>
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
To: Annaliese McDermond <nh6z@nh6z.net>, eric@anholt.net, f.fainelli@gmail.com, wsa@the-dreams.de, swarren@wwwdotorg.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com
List-Id: linux-i2c@vger.kernel.org

Hi Annaliese,

thank you for mention that we have multiple I2C interfaces.

On 08.05.19 09:12, Annaliese McDermond wrote:
> +
> +static struct clk *bcm2835_i2c_register_div(struct device *dev,
> +					const char *mclk_name,
> +					struct bcm2835_i2c_dev *i2c_dev)
> +{
> +	struct clk_init_data init;
> +	struct clk_bcm2835_i2c *priv;
> +	const char *devname = dev_name(dev);
> +
> +	init.ops = &clk_bcm2835_i2c_ops;
> +	init.name = "bcm2835-i2c";

Does this work intentionally in case i2c-0 and i2c-1 are used at the
same time?

Please also check the output of /sys/kernel/debug/clk/clk_summary

Regards
Stefan
