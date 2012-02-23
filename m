From: Huang Changming-R66093 <r66093-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Thu, 23 Feb 2012 06:57:54 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C02C64E@039-SN1MPN1-002.039d.mgd.msft.net>
References: <ECEE0D23-8F53-402C-A97F-4DB0F0E9C79B@freescale.com>
	<1321464509.7847.41.camel@oslab-l1>
	<1321464968.2309.384.camel@groeck-laptop>
	<1321466135.7847.55.camel@oslab-l1>
	<20111116190954.67c846fc@endymion.delvare>
	<1321467638.7847.73.camel@oslab-l1>
	<20111116201048.4b7877dd@endymion.delvare>
	<1321470915.7847.122.camel@oslab-l1>
	<20111116201847.6b11dc7f@endymion.delvare>
	<3C06C26914DACA4BB3A368F78CA0B3A7134583@039-SN1MPN1-004.039d.mgd.msft.net>
	<20111207032000.GA17575@ericsson.com>
	<3C06C26914DACA4BB3A368F78CA0B3A71345F2@039-SN1MPN1-004.039d.mgd.msft.net>
 <20111207082924.2f88bd5d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111207082924.2f88bd5d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sun york-R58495 <R58495-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Durai Kumar-R34055 <r34055-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We have sent the v2 since 12/12/2011, could you have any comment about it?
http://marc.info/?l=linux-i2c&m=132368362506671&w=2


Thanks
Jerry Huang


> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> Sent: Wednesday, December 07, 2011 3:29 PM
> To: Tang Yuantian-B29983
> Cc: Guenter Roeck; Tabi Timur-B04825; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; sun york-R58495; Durai Kumar-R34055; Huang
> Changming-R66093
> Subject: Re: [PATCH] i2c/busses: (mpc) Add support for
> SMBUS_READ_BLOCK_DATA
> 
> Hi Yuantian,
> 
> Please don't top-post.
> 
> On Wed, 7 Dec 2011 05:25:49 +0000, Tang Yuantian-B29983 wrote:
> > Hi Guenter,
> >
> > I thought you were bore of discussion.
> > Do you mind if I post similar patch?
> 
> I have no objection, as long as you give proper credit to the original
> author.
> 
> Note that ultimately you'll have to get Ben Dooks to apply the patch. I
> helped with the review but the i2c-mpc driver doesn't actually fall in my
> jurisdiction.
> 
> --
> Jean Delvare
