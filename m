From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: [PATCH v7 0/5] AT91: replace broken TWI driver i2c-at91.c
Date: Wed, 11 Jan 2012 15:06:52 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0882DEF3E8@wm021.weinmann.com>
References: <cover.1322062555.git.n.voss@weinmann.de>
 <4ECFB755.6060509@gmail.com>
 <D99582E5322435468A77E74BB0039E7B1D18739F99@SRV02.hamburg.garz-fricke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <D99582E5322435468A77E74BB0039E7B1D18739F99@SRV02.hamburg.garz-fricke.de>
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
To: 'Carsten Behling' <carsten.behling@garz-fricke.com>, 'Hubert Feurstein' <h.feurstein@gmail.com>
Cc: "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Carsten Behling wrote on 2011-12-28:
> I've tested this driver with the pca953x GPIO expander driver with a PCA9554.
> 
> In the case of 8 GPIO pins (my case) "i2c_smbus_read_byte_data(...)"
[...]
> I observed that reading out the GPIO status is one read delayed.
> The first read to a register from the pca953x driver does not result in a
> RXRDY interrupt and at91_twi_read_next_byte(...) is not called.
> Only the completion routine is triggered with a TXCOMP interrupt.

Which SOC are you using? This is probably a hardware bug since on my
at91sam9g45 i2c_smbus_read_byte_data() works reliably without any
problems. Please check the errata and see if there is a useable
workaround. If not, the driver should be disabled for your SOC.

> Additionally, I took a look at the status flags just after the control flags
> are set (in at91_do_twi_transfer(...), AT91_TWI_START|AT91_TWI_STOP for the
> one byte read). Surprisingly, the AT91_TWI_RXRDY flag is zero before the first
> register read and one for the following reads. According to the manual this
> flag should be zero after a read on AT91_TWI_RHR.
> 
> Reading the AT91_TWI_RHR before the control flags are set to be sure that the
> AT91_TWI_RXRDY is cleared leads to a never occurring RXRDY interrupt.

Again, this behavior does not conform to the datasheet, I suspect documented
or undocumented errata... At91rm9200 has at least one erratum for which I
imported a workaround from the old driver (which does not use interrupts).

Niko
