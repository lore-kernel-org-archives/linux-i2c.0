From: Carsten Behling <carsten.behling@garz-fricke.com>
Subject: AW: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Wed, 23 Nov 2011 10:31:44 +0100
Message-ID: <D99582E5322435468A77E74BB0039E7B1D1655BFBB@SRV02.hamburg.garz-fricke.de>
References: <D99582E5322435468A77E74BB0039E7B1D1655BF4D@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
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
Cc: "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

> this case is already catched in at91_do_twi_transfer():

Sorry, I did not found this code in your patch.
(http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06556.html):

> +       if (is_read) {
> +               if (!dev->buf_len)
> +                       at91_twi_write(dev, AT91_TWI_CR,
> +                                      AT91_TWI_START | AT91_TWI_STOP);
> +               else
> +                       at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_START);
> +               at91_twi_write(dev, AT91_TWI_IER,
> +                              AT91_TWI_TXCOMP | AT91_TWI_RXRDY);
> +       } else {
> +               at91_twi_write_next_byte(dev);
> +               at91_twi_write(dev, AT91_TWI_IER,
> +                              AT91_TWI_TXCOMP | AT91_TWI_TXRDY);
> +       }

Is there a more recent version ?

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

Gesendet: Dienstag, 22. November 2011 17:26
An: Carsten Behling
Cc: 'linux-i2c@vger.kernel.org'; 'linux-arm-kernel@lists.infradead.org'; 'l=
inux-kernel@vger.kernel.org'
Betreff: RE: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver

Hi,

Carsten Behling wrote on 2011-11-22:
> +static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
> +{
> +       *dev->buf =3D at91_twi_read(dev, AT91_TWI_RHR) & 0xff;
> +
> +       /* send stop if second but last byte has been read */
> +       if (--dev->buf_len =3D=3D 1)
> +               at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
> =

> =

> =

> If dev->buf_len =3D1 at the beginning of a read transfer, a stop conditio=
n will
> never be send.

this case is already catched in at91_do_twi_transfer():

+       if (dev->msg->flags & I2C_M_RD) {
+               unsigned start_flags =3D AT91_TWI_START;
+
+               /* if only one byte is to be read, immediately stop transfe=
r */
+               if (dev->buf_len <=3D 1 && !(dev->msg->flags & I2C_M_RECV_L=
EN))
+                       start_flags |=3D AT91_TWI_STOP;
+               at91_twi_write(dev, AT91_TWI_CR, start_flags);

Thanks for reviewing,
Niko
