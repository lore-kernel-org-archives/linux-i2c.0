From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 8 Nov 2011 16:35:21 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B38B899@wm021.weinmann.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
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
To: "'balbi@ti.com'" <balbi@ti.com>
Cc: "'rmallon@gmail.com'" <rmallon@gmail.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'khali@linux-fr.org'" <khali@linux-fr.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> > +#include <mach/at91_twi.h>
> > +#include <mach/board.h>
> > +#include <mach/cpu.h>
> 
> avoid including <mach/*> on drivers.

Should I move at91_twi.h to include/linux (omap does it like this,
other use the mach-include)?


> > +	if (irqstatus & AT91_TWI_TXCOMP) {
> > +		at91_disable_twi_interrupts(dev);
> > +		dev->transfer_status = status;
> > +		complete(&dev->cmd_complete);
> > +	}
> > +	else if (irqstatus & AT91_TWI_RXRDY) {
> > +		at91_twi_read_next_byte(dev);
> > +	}
> > +	else if (irqstatus & AT91_TWI_TXRDY) {
> > +		at91_twi_write_next_byte(dev);
> > +	}
> > +	else {
> > +		return IRQ_NONE;
> 
> coding style is wrong. Also, are those IRQ events really mutually exclusive ??

These are indeed mutually exclusive (semantically).

Niko
