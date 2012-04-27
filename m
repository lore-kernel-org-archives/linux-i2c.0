From: Carsten Behling <carsten.behling@garz-fricke.com>
Subject: AW: [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Fri, 27 Apr 2012 10:36:47 +0200
Message-ID: <D99582E5322435468A77E74BB0039E7B1D2293684D@SRV02.hamburg.garz-fricke.de>
References: <D99582E5322435468A77E74BB0039E7B1D22784CF0@SRV02.hamburg.garz-fricke.de>
 <alpine.DEB.2.00.1204261035060.16439@gatekeeper.vosshq.de>
 <D99582E5322435468A77E74BB0039E7B1D22784E8B@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D0905E0994A@wm021.weinmann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D0905E0994A@wm021.weinmann.com>
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
To: "Voss, Nikolaus" <N.Voss@weinmann.de>
Cc: "'devel@ayanes.com'" <devel@ayanes.com>, 'Wolfram Sang' <w.sang@pengutronix.de>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, 'Hubert Feurstein' <h.feurstein@gmail.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, Marc-Oliver Westerburg <Westerburg@garz-fricke.com>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hi Niko,

you a right. Driver works with that patch.

Mit freundlichen Gr=FC=DFen / Best regards
Carsten Behling

Development Engineer
Garz & Fricke GmbH
Tempowerkring 2, 21079 Hamburg - Germany
Amtsgericht Hamburg HRB 60514
Gesch=E4ftsf=FChrer: Manfred Garz, Matthias Fricke
Phone: +49 (0) 40 791 899 - 56
Fax:    +49 40 / 791 899 - 39
www.garz-fricke.com =


 =



-----Urspr=FCngliche Nachricht-----
Von: Voss, Nikolaus [mailto:N.Voss@weinmann.de] =

Gesendet: Freitag, 27. April 2012 10:05
An: Carsten Behling
Cc: Marc-Oliver Westerburg; 'devel@ayanes.com'; 'Wolfram Sang'; 'linux-arm-=
kernel@lists.infradead.org'; 'linux-kernel@vger.kernel.org'; 'linux-i2c@vge=
r.kernel.org'; 'Hubert Feurstein'
Betreff: RE: [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c: add new driver

Hi Carsten,

Carsten Behling wrote on 2012-04-27:
>>  	INIT_COMPLETION(dev->cmd_complete);
>> +	dev->transfer_status =3D 0;
>>  	if (dev->msg->flags & I2C_M_RD) {
>>  		unsigned start_flags =3D AT91_TWI_START;
> =

> this patch will not work, because you reset 'dev->transfer_status'
> before it is evaluated on errors (AT91_TWI_NACK, AT91_TWI_OVRE). =


it should, because transfer_status is updated by the ISR between
wait_for_completion_interruptible_timeout() and the error evaluation.
Please try it out.

> > P.S. Are you using a RM9200? Seems that this SOC has some problems...
> =

> Yes, our ECO920 uses the RM9200, but we support it with an very old kernel
> (2.6.21). I remember there were many problems with I2C.

Ok, but good to hear the driver basically works with the RM9200.

Niko
