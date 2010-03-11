From: "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
 bus
Date: Thu, 11 Mar 2010 10:28:24 -0600
Message-ID: <F8C55F6A02E92D48BDDFC6048552C6F14E9A921F@dlee03.ent.ti.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	<1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com>
	<225d086e1002050553tc1a696avce827cc115f56b1c@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8@dbde02.ent.ti.com>
	<4B702A17.3070104@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E2639D67@dbde02.ent.ti.com>
	<4B7135B3.9080104@mvista.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E263A447@dbde02.ent.ti.com>
 <F8C55F6A02E92D48BDDFC6048552C6F14E6D9F3F@dlee03.ent.ti.com>
 <4B94FD84.3060100@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B94FD84.3060100-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Philby John [mailto:pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
> Sent: Monday, March 08, 2010 7:37 AM
> To: Griffis, Brad
> Cc: Nori, Sekhar; davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-
> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
> bus
> 
> I did go through your document, but what does "free data format" mean?
> It would be good to expand the procedure that enables you to move into
> this mode. If this wouldn't require modfying pinmux settings shouldn't
> it be part of the core i2c implementation?

Just to make sure my point was clear, I think the GPIO method is simpler/easier if you're just looking at a single device and assuming that device has muxed the I2C with GPIO.  That said, my method is a little more complicated/convoluted when looking at a single device, but I think the code would scale better across the entire Davinci tree since it requires no knowledge of whether the pin-muxing option is available and how the pin-muxing is implemented for that particular device.

You enter the "free data format" mode by setting the FDF bit in the ICMDR register.  It is described in Section 2.6.3 of the OMAP-L138 I2C Guide:

http://www.ti.com/lit/sprufl9

The advantage of using this mode is that you would not require any device-specific pin-muxing knowledge/changes.  The entire recovery can occur within the context of the I2C controller.

So to do a read in the "free data format" mode you would write ICMDR.FDF = 1 (free data format), ICMDR.TRX = 0 (read), ICMDR.STT = 1 (start), ICMDR.STP = 1.  This should cause it to clock in 8 bits of data plus an ack, freeing up the bus.

Brad
