From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 28 Aug 2012 17:32:52 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC3DB91@wm021.weinmann.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
 <503CDF48.5080201@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <503CDF48.5080201@atmel.com>
Content-Language: de-DE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "'ludovic.desroches'" <ludovic.desroches@atmel.com>
Cc: "'rmallon@gmail.com'" <rmallon@gmail.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'h.feurstein@gmail.com'" <h.feurstein@gmail.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'adrian.yanes@aalto.fi'" <adrian.yanes@aalto.fi>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'carsten.behling@garz-fricke.com'" <carsten.behling@garz-fricke.com>
List-Id: linux-i2c@vger.kernel.org

Hi Ludovic,

ludovic.desroches wrote on Tuesday, August 28, 2012 5:10 PM:
> > +static const struct platform_device_id twi_ip_type = {
> > +	/*
> > +	 * driver_data is 2 for SAM9261 compatible ip, see enum twi_ip_id in
> > +	 * drivers/i2c/busses/i2c-at91.c
> > +	 */
> > +	.driver_data	= 2,
> > +};
> > +
> >   static struct platform_device at91sam9261_twi_device = {
> >   	.name			= "i2c-gpio",
> >   	.id			= -1,
> > +	.id_entry		= &twi_ip_type,
> >   	.dev.platform_data	= &pdata,
> >   };
> >
> 
> [...]
> 
> You add the id_entry to the i2c-gpio device instead of at91_i2c device.

Oh! I'll post the complete series tomorrow.

Regards,
Niko
