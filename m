From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Mon, 27 Aug 2012 16:29:47 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC3D747@wm021.weinmann.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>,
 <503B623C.4030304@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
 <503B7D6E.7090906@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <503B7D6E.7090906@atmel.com>
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
To: "'ludovic.desroches'" <ludovic.desroches@atmel.com>, "''Wolfram Sang'
 (w.sang@pengutronix.de)'" <w.sang@pengutronix.de>
Cc: 'Yanes Martinez Adrian' <adrian.yanes@aalto.fi>, "'carsten.behling@garz-fricke.com'" <carsten.behling@garz-fricke.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'h.feurstein@gmail.com'" <h.feurstein@gmail.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'rmallon@gmail.com'" <rmallon@gmail.com>
List-Id: linux-i2c@vger.kernel.org

ludovic.desroches wrote on Monday, August 27, 2012 4:00 PM :
> For the moment, I don't have the necessary knowledge about the TWI
> controller to take a decision. I would say it can be done in an other
> patch in order to have your driver included in the mainline quickly
> since it doesn't introduce a breakage.

That would be the most pragmatic approach.
Wolfram, is the anything left to do from my side?

Regards,
Niko
