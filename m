From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] i2c: at91: fix write transfers by clearing pending
 interrupt first
Date: Tue, 20 Oct 2015 15:27:02 +0200
Message-ID: <20151020132702.GA25824@odux.rfo.atmel.com>
References: <1444746104-20615-1-git-send-email-ludovic.desroches@atmel.com>
 <561D20E7.5070405@lysator.liu.se>
 <561D359D.8000500@atmel.com>
 <561D46FE.4090801@lysator.liu.se>
 <20151014054321.GA20049@odux.rfo.atmel.com>
 <56203B0E.1030104@lysator.liu.se>
 <5620BE9A.10302@lysator.liu.se>
 <20151019085136.GK26893@odux.rfo.atmel.com>
 <5624CA9F.5080309@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5624CA9F.5080309@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
List-Id: linux-i2c@vger.kernel.org

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2015 at 12:49:03PM +0200, Peter Rosin wrote:
> On 2015-10-19 10:51, Ludovic Desroches wrote:
> > Hi Peter,
> > 
> > On Fri, Oct 16, 2015 at 11:08:42AM +0200, Peter Rosin wrote:
> >> On 2015-10-16 01:47, Peter Rosin wrote:
> >>> On 2015-10-14 07:43, Ludovic Desroches wrote:
> >>>> On Tue, Oct 13, 2015 at 08:01:34PM +0200, Peter Rosin wrote:
> >>>>> On 2015-10-13 18:47, Cyrille Pitchen wrote:
> >>>>>> Le 13/10/2015 17:19, Peter Rosin a écrit :
> >>>>>>> On 2015-10-13 16:21, Ludovic Desroches wrote:
> > 
> > [...]
> > 
> >>> I have started to get this when I run with this patch:
> >>>
> >>> [   73.310000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [  198.200000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [  509.880000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [  615.750000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [  617.750000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [ 1766.640000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [ 2035.380000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [ 2227.190000] at91_i2c f0014000.i2c: RXRDY still set!
> >>> [ 2313.100000] at91_i2c f0014000.i2c: RXRDY still set!
> >>>
> >>> My USB serial dongle was hung which was why I didn't notice until just now.
> >>>
> >>> This is probably not when communication with the eeprom though, and certainly not
> >>> writing to it, but perhpaps when polling the temperature (using the jc42 driver).
> >>> I'll investigate further in the morning to see if I can pinpoint it.
> >>
> >> Yep, it's the jc42 accesses that triggers this (to the same chip as the
> >> eeprom, but a different block of transistors I suppose).
> >>
> >> Looking at the i2c bus, the accesses normally go like this:
> >>
> >> [0.000000] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
> >> [0.000521] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
> >> [0.001024] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
> >> [0.001524] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P
> >> [0.196991] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
> >> [0.197514] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
> >> [0.198019] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
> >> [0.198520] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P
> >>
> >> I.e. chunks of four transfers every ~200 ms (I removed the 1Hz rate
> >> limiter in the jc42 driver to get more frequent incidents).
> >>
> >> But when the diagnostic (RXRDY still set!) is output it continues
> >> with this:
> >>
> >> [0.399755] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
> >> [0.404998] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
> >> [0.405508] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
> >> [0.406008] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P
> >>
> >> Notice the ~5 ms delay (about the time it should take to output
> >> the diagnostic at 115200 baud) after the access to register 0x05
> >> at 0.399755.
> >>
> >> This is the only thing that I can observe on the bus, so it appears
> >> to be harmless.
> >>
> >> It appears that the i2c access at 0.399755 finds the TWI
> >> registers in an odd state, but nothing from the access at
> >> 0.198520 appears to have gone wrong. Is this a race? Anyway,
> >> the diagnostic is pretty frequent and annoying. printk_once?
> > 
> > I'll try to reproduce it on my side. The only issue you have is having
> > the message about RXRDY? I mean no issue with i2c transfers?
> 
> Exactly, the only issue is the message, the bus looks good and transfers
> work as they should AFAICT.
> > It is not the possible bug we had in mind, this bug will prevent the
> > master device to release the i2c bus. It will stop the transfer but
> > without sending a stop on the bus.
> 
> Agreed, this is not about the extra frame caused by the spurious write
> to the THR register. This is something else.
> 
> One suspicion is that the driver gets an unexpected irq from its own
> NACK (the one that it puts out to end the read) and races with the
> expected interrupt at TXCOMP?
>

I have discussed with the designer of this IP. So the NACK flag is only
used for 'real' nack not protocol ones.

Concerning the read issue, it have attached a patch (apply it on top of
Cyrille's patch). Could you have a try? I have reproduced your issue only one
time so it's hard for me to tell if it works well or not.

Regards

Ludovic

--sm4nu43k4a2Rpi4c
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment; filename="i2c_at91_fix_rx_issue.patch"

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 94c087b..05e3d8e 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -347,8 +347,14 @@ error:
 
 static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 {
-	if (!dev->buf_len)
+	/*
+	 * If we are in this case, it means there is garbage data in RHR, so
+	 * delete them.
+	 */
+	if (!dev->buf_len) {
+		at91_twi_read(dev, AT91_TWI_RHR);
 		return;
+	}
 
 	/* 8bit read works with and without FIFO */
 	*dev->buf = readb_relaxed(dev->base + AT91_TWI_RHR);
@@ -465,6 +471,8 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 
 	if (!irqstatus)
 		return IRQ_NONE;
+	if (irqstatus & AT91_TWI_RXRDY)
+		at91_twi_read_next_byte(dev);
 
 	/*
 	 * When a NACK condition is detected, the I2C controller sets the NACK,
@@ -507,8 +515,6 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 	if (irqstatus & (AT91_TWI_TXCOMP | AT91_TWI_NACK)) {
 		at91_disable_twi_interrupts(dev);
 		complete(&dev->cmd_complete);
-	} else if (irqstatus & AT91_TWI_RXRDY) {
-		at91_twi_read_next_byte(dev);
 	} else if (irqstatus & AT91_TWI_TXRDY) {
 		at91_twi_write_next_byte(dev);
 	}
@@ -600,11 +606,6 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	} else if (dev->msg->flags & I2C_M_RD) {
 		unsigned start_flags = AT91_TWI_START;
 
-		if (sr & AT91_TWI_RXRDY) {
-			dev_err(dev->dev, "RXRDY still set!");
-			at91_twi_read(dev, AT91_TWI_RHR);
-		}
-
 		/* if only one byte is to be read, immediately stop transfer */
 		if (!has_alt_cmd && dev->buf_len <= 1 &&
 		    !(dev->msg->flags & I2C_M_RECV_LEN))

--sm4nu43k4a2Rpi4c--
