From: Yanes Martinez Adrian <adrian.yanes@aalto.fi>
Subject: RE: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Mon, 27 Aug 2012 10:40:37 +0000
Message-ID: <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <503B4919.6080306@atmel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "ludovic.desroches" <ludovic.desroches@atmel.com>, Nikolaus Voss <n.voss@weinmann.de>
Cc: "rmallon@gmail.com" <rmallon@gmail.com>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "h.feurstein@gmail.com" <h.feurstein@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "carsten.behling@garz-fricke.com" <carsten.behling@garz-fricke.com>
List-Id: linux-i2c@vger.kernel.org

Hi Ludovic,

>Tested on at91rm9200, at91sam9261, at91sam9g20 and at91sam9m10 with
>eeprom, temperature sensor and rtc devices (and wolfson chip for
>sam9g20).

concerning the at91rm9200, what was the amount of bytes you transmitted?

Some months ago I performed some testing[1] with the previous version of
the patch and the main conclusion was that the absence of PDC in the
AT91RM9200 made this driver unusable in such platform.

Please double check this.

Thanks in advance,

Adrian.

1 - http://thread.gmane.org/gmane.linux.drivers.i2c/10367/focus=1287445
