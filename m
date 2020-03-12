From: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] i2c: allow DT nodes without 'compatible'
Date: Thu, 12 Mar 2020 12:44:32 +0100
Message-ID: <20200312114432.GA3384@piout.net>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
 <20200220172403.26062-4-wsa+renesas@sang-engineering.com>
 <CAMuHMdWaPfc050dZiRr+gAFzsdjSo9Vo70ztWgrMGPJxLUqupw@mail.gmail.com>
 <e43eaaf1-a294-902f-9a52-ebf8b29acab1@lucaceresoli.net>
 <20200312111950.GA1013@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200312111950.GA1013@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Luca Ceresoli <luca-ep08DiM7hqZH3+C6az13tg@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i3c-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kieran Bingham <kieran-7hKh/agyDeatmTQ+vhA3Yw@public.gmane.org>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Jacopo Mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 12/03/2020 12:19:51+0100, Wolfram Sang wrote:
> > Clearly this does not fit the case reported by Alexandre: a device
> > having a driver which is known to be badly buggy, so we don't want to
> > instantiate it. But again, this should not affect DT as it is not
> > describing the HW, but only an implementation detail. Probably disabling
> > or blacklisting the driver would be a better option there?
> 
> "Fixing the driver" is the first thing coming to my mind ;) But yeah,
> blacklisting would be another good solution. With only the information
> above, DT is not the right place to fix a broken driver.
> 

To be clear, the driver is working properly but the HW isn't. It is a
PMIC and we need to avoid linux talking to it so the PMIC doesn't end up
killing the bus.

We end up with a node properly described in the device tree but with
status = "disabled". The relevance to the discussion was that you know
what is there and you want to avoid using its address.

See the pmic node on i2c1 in arch/arm/boot/dts/at91-sama5d3_xplained.dts
for what I'm referring to.

> > My apologies to Wolfram, I appreciate a lot the effort you are doing,
> > but before reviewing this patch I have never realized what I tried to
> > explain above.
> 
> All good, Luca! Talking over code usually brings in viewpoints which
> have been missed so far. This is expected. Actually, I am very happy to
> have this discussion!
> 
> All the best,
> 
>    Wolfram
> 



-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
