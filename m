From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 07 Oct 2009 16:11:04 +0100
Message-ID: <4ACCAF88.8060900@cam.ac.uk>
References: <20091007115017.6941faa7@hyperion.delvare> <20091007095610.GF3177@pengutronix.de> <20091007120734.31a41f33@hyperion.delvare> <20091007102557.GG3177@pengutronix.de> <4ACC85B7.2010300@cam.ac.uk> <20091007142746.4bc4f0f4@hyperion.delvare> <20091007124748.GH3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091007124748.GH3177-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
>> I think we can simply move the driver and convert it directly, and
>> document the interface changes. I've always said loudly that the
>> tsl2550 driver was the first of its kind and as such its interface was
>> subject to change when other similar drivers would be added. Which is
>> what's happening right now.
> 
> ACK. So we move it when ALS is going mainline (probably next merge-window)?
> That's foreseeable enough, I think. BTW Jonathan, is there an ALS-tree or so? I
> couldn't find any reference...
I think it's just a patch set at the mo - I'll post reply to that tread and ask
what the intentions wrt merge and who is doing it etc.

Jonathan
