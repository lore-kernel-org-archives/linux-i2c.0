From: Yanes Martinez Adrian <adrian.yanes@aalto.fi>
Subject: RE: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Mon, 27 Aug 2012 12:45:39 +0000
Message-ID: <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>,
 <503B623C.4030304@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <503B623C.4030304@atmel.com>
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
To: "ludovic.desroches" <ludovic.desroches@atmel.com>
Cc: "rmallon@gmail.com" <rmallon@gmail.com>, Nikolaus Voss <n.voss@weinmann.de>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "h.feurstein@gmail.com" <h.feurstein@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "carsten.behling@garz-fricke.com" <carsten.behling@garz-fricke.com>
List-Id: linux-i2c@vger.kernel.org

>Hi Adrian,

Le 08/27/2012 12:40 PM, Yanes Martinez Adrian a =E9crit :
> Hi Ludovic,
>
>> Tested on at91rm9200, at91sam9261, at91sam9g20 and at91sam9m10 with
>> eeprom, temperature sensor and rtc devices (and wolfson chip for
>> sam9g20).
>
> concerning the at91rm9200, what was the amount of bytes you transmitted?
>

> I have only checked that I can communicate with i2c devices so the
> amount is very low (1-4 bytes).

IIRC it was from >7 bytes when the issues appeared.

> Some months ago I performed some testing[1] with the previous version of
> the patch and the main conclusion was that the absence of PDC in the
> AT91RM9200 made this driver unusable in such platform.
>

> Does the new driver break something? Was it working with the old one?

The old driver never worked properly. GPIO I2C has been the only alternative
to use I2C over AT91RM9200. With the proposed driver I just encountered
the same issues mentioned in the previous thread (so at the end nothing
changed for the AT91RM9200, GPIO is the only way to go).

>There are some issues with which are not related to the driver but to
>the design of the IP. With old I2C versions, using GPIO I2C is recommended.

I think a warning should be included in the proposed driver for that reason.
Despite the driver will work in the mentioned SoCs, the users will encounter
issues in boards like AT91RM9200 and other legacy products.

Regards,

Adrian.
