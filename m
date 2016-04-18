From: Pan Gao <pandy.gao@nxp.com>
Subject: RE: [Patch v1] i2c: imx7ulp: add i.MX7ULP i2c controller bus driver
Date: Mon, 18 Apr 2016 02:05:23 +0000
Message-ID: <AM4PR0401MB17804BB4146BF63052774048F66B0@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1458035482-14905-1-git-send-email-pandy.gao@nxp.com>
 <20160416212911.GE1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-am1on0091.outbound.protection.outlook.com ([157.56.112.91]:54790
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751441AbcDRCF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 17 Apr 2016 22:05:26 -0400
In-Reply-To: <20160416212911.GE1522@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>

From: Wolfram Sang <wsa@the-dreams.de> Sent: Sunday, April 17, 2016 5:29 AM
> To: Pan Gao <pandy.gao@nxp.com>
> Cc: u.kleine-koenig@pengutronix.de; linux-i2c@vger.kernel.org; Frank Li
> <frank.li@nxp.com>; Fugang Duan <fugang.duan@nxp.com>
> Subject: Re: [Patch v1] i2c: imx7ulp: add i.MX7ULP i2c controller bus driver
> 
> On Tue, Mar 15, 2016 at 05:51:22PM +0800, Gao Pan wrote:
> > Add i.MX7ULP i2c bus driver which can continue operating in stop modes
> > provided an appropriate clock is available.
> >
> > It is also designed for low CPU overhead with DMA offloading of FIFO
> > register accesses.
> >
> > Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> 
> Since you need to resend anyhow (DT support?), just a few high-level things.
> 
Yes, I will send DT patch in the V2. 

> There is a lot of dev_dbg in here. Some of them are helpful when developing
> the driver, but not anymore once the driver is upstream.

Ok, will change it in V2. Thanks.
 
> Please check for that.
> 
> > +static int __init i2c_adap_imx_init(void) {
> > +	return platform_driver_register(&i2c_imx7ulp_driver);
> > +}
> > +subsys_initcall(i2c_adap_imx_init);
> 
> I usually don't accept subsys_initcall() for new drivers anymore. It usually
> works around problems. Make sure your I2C clients do defer probing properly.

Will change it in V2. Thanks.

Thanks.
Pandy.
