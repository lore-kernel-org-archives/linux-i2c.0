From: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH V3] i2c: davinci: update to devm_* API
Date: Thu, 21 Feb 2013 03:25:34 +0000
Message-ID: <A4887BF146CD57468F700B415D2F4701583A28@DBDE01.ent.ti.com>
References: <1360241520-11476-1-git-send-email-manishv.b@ti.com>
 <20130215190943.GB4351@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130215190943.GB4351-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram

On Sat, Feb 16, 2013 at 00:39:43, Wolfram Sang wrote:
> On Thu, Feb 07, 2013 at 06:22:00PM +0530, Vishwanathrao Badarkhe, Manish wrote:
> > Update the code to use devm_* API so that driver core will manage 
> > resources.
> > Also, if "devm_request_and_ioremap" fails return -EADDRNOTAVAIL 
> > instead of -EBUSY.
> > 
> > Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>
> 
> Basically OK, please resend when devm_ioremap_resource hits mainline in 3.9.

Thanks for pointing this out. Sure, I will resend this patch once 
devm_ioremap_resource hits mainline in 3.9.

Regards, 
Manish
