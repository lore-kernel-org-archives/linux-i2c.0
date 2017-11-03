From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH RFC 4/4] i2c: at91: take slave mode capabilities of
 hardware into account
Date: Fri, 3 Nov 2017 09:46:02 +0100
Message-ID: <20171103084602.sbqv5opdjyopx43q@rfolt0960.corp.atmel.com>
References: <cover.1509112910.git.me@jue.yt>
 <1e3e7e50e25afd3ebe14daf89d1f194c45ca6cbb.1509112910.git.me@jue.yt>
 <20171031152250.4oasjhfpya5rmzyv@rfolt0960.corp.atmel.com>
 <20171101111636.GA17565@jfi-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:5700 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdKCIqF (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Nov 2017 04:46:05 -0400
Content-Disposition: inline
In-Reply-To: <20171101111636.GA17565@jfi-dev>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Juergen Fitschen <me@jue.yt>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Juergen,

On Wed, Nov 01, 2017 at 12:16:36PM +0100, Juergen Fitschen wrote:
> Hello Ludovic,
> 
> Thank you very much for your feedback!
> 
> On Tue, Oct 31, 2017 at 04:22:50PM +0100, Ludovic Desroches wrote:
> > On Fri, Oct 27, 2017 at 05:12:17PM +0200, Juergen Fitschen wrote:
> > > Some AT91 hardware has no slave mode included or only limited features
> > > (i.e. no fifos).
> > > 
> > 
> > I am wondering if it won't be better to squash this patch into the
> > previous one:
> > Without it, it seems that we can set slave_detected for the RM9200 even
> > if it doesn't support the slave mode.
> 
> Good point. I will squash both patches into one in the next version. In the
> first place I wanted to support the review process by splitting the changes in
> two patches.
> 
> > > diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
> > > index bb502c1..4a4fa67 100644
> > > --- a/drivers/i2c/busses/i2c-at91.h
> > > +++ b/drivers/i2c/busses/i2c-at91.h
> > > @@ -107,9 +107,14 @@
> > >  
> > >  #define	AT91_TWI_VER		0x00fc	/* Version Register */
> > >  
> > > +#define	AT91_TWI_SM_AVAILABLE	BIT(0)	/* Slave mode supported */
> > > +#define	AT91_TWI_SM_CAN_NACK	BIT(1)	/* Can send NACKs in slave mode */
> > > +#define	AT91_TWI_SM_HAS_FIFO	BIT(2)	/* Has FIFO for slave mode */
> > > +
> > 
> > I would not add AT91_TWI_SM_CAN_NACK, AT91_TWI_SM_HAS_FIFO since there
> > is no code relying on them. Maybe you have some plans for the future?
> 
> Wolfram mentioned that supporting NACKs would be a welcome feature [1]. But I
> haven't implemented it, yet. The same goes for FIFO support. ATM I am not sure
> if my application will need this, since I am observing quite a lot clock
> stretching without FIFOs due to the occupied receive holding registered (RHR).
> 
> BTW: Both implementations would be kind of controversal. Without using FIFOs the
> desired NACK would be delayed by 1 byte (cf. my "artistic" ASCII graphic [2]).
> If FIFOs are enabled the delay would be even larger. So the options are:
> 
>  * No NACKs at all
>  * NACKs delayed by 1 byte, no FIFOs
>  * NACKs delayed by n byte, with FIFOs
> 
> Non of these abovementioned options is optimal and fulfill the desired behaviour
> (cf. section I2C_SLAVE_WRITE_RECEIVED of [3]).  Furthermore, AFAIK NACKs and
> FIFOs are just supported by SAMA5D2x MPUs.
> 
> These are the main reasons why I haven't implented anything related to
> AT91_TWI_SM_CAN_NACK and AT91_TWI_SM_HAS_FIFO. The designware driver ignores
> the NACK problem, as well.
> 
> Do you have an opinion on this topic?
> 

After discussing with the hardware guy, I confirm that we can't NACK the
byte we have just received. From his point of view and according to the
i2c specification it's not something that can be handled:

"On the byte level, a device may be able to receive bytes of data at a fast rate, but needs
more time to store a received byte or prepare another byte to be transmitted. Slaves can
then hold the SCL line LOW after reception and acknowledgment of a byte to force the
master into a wait state until the slave is ready for the next byte transfer in a type of
handshake procedure (see Figure 7)." From the Clock stretching section.

Since the clock stretching is only allowed after the acknowledgment, we
won't have time to change the ACK value for the byte we have just
received.

I think using NACKs delayed by 1 byte is the only solution. Using FIFOs
should not be recommended for slave mode since it will delay the NACKs
in an unpredictable way, it'll depend on FIFOs content.

Regards

Ludovic

> In the next version of this patchset I will remove this. I think readding these
> flags if needed shouldn't be a big deal.
> 
> 
> Best regards
>   Juergen
> 
> 
> [1] https://marc.info/?l=linux-i2c&m=150831224824540&w=2
> [2] https://marc.info/?l=linux-i2c&m=150833171430595&w=2
> [3] https://www.kernel.org/doc/Documentation/i2c/slave-interface
