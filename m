From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] i2c: at91: implement i2c bus recovery
Date: Fri, 4 Oct 2019 22:39:33 +0200
Message-ID: <20191004203933.tfhr6cwbsq2hxrov@pengutronix.de>
References: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
 <20191002144658.7718-3-kamel.bouhara@bootlin.com>
 <08e99a4b-851e-0bee-4c5a-8578b42c283e@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08e99a4b-851e-0bee-4c5a-8578b42c283e@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: kamel.bouhara@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 04, 2019 at 09:35:23AM +0000, Claudiu.Beznea@microchip.com wrote:
> Hi Kamel,
> 
> On 02.10.2019 17:46, Kamel Bouhara wrote:
> > +static int at91_init_twi_recovery_info(struct platform_device *pdev,
> > +				       struct at91_twi_dev *dev)
> > +{
> > +	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
> > +
> > +	dev->pinctrl = devm_pinctrl_get(&pdev->dev);
> > +	if (!dev->pinctrl || IS_ERR(dev->pinctrl)) {
> 
> You may use IS_ERR_OR_NULL() here.

Can devm_pinctrl_get return NULL? From a quick look, it cannot.

rule of thumb: IS_ERR_OR_NULL is wrong as it is a sign of poor return
value semantics.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
