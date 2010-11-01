From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] NFC: Driver for NXP Semiconductors PN544 NFC
 chip.
Date: Mon, 01 Nov 2010 10:17:41 +0200
Message-ID: <1288599461.1603.58.camel@masi.mnp.nokia.com>
References: <1288333569-19979-1-git-send-email-matti.j.aaltonen@nokia.com>
	 <1288333569-19979-2-git-send-email-matti.j.aaltonen@nokia.com>
	 <20101029143500.bc1cbc7d.akpm@linux-foundation.org>
Reply-To: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101029143500.bc1cbc7d.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2010-10-29 at 14:35 -0700, ext Andrew Morton wrote:
> On Fri, 29 Oct 2010 09:26:09 +0300
> "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > +static void __exit pn544_exit(void)
> > +{
> > +	flush_scheduled_work();
> 
> You said this had been removed.  Did you send the correct version?

I was the "correct" version but I clearly made some kind of mistake when
preparing it, sorry...

Cheers,
Matti

> 
> > +	i2c_del_driver(&pn544_driver);
> > +	pr_info(DRIVER_DESC ", Exiting.\n");
> > +}
