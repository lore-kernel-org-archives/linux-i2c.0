From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Wed, 7 Dec 2011 08:29:24 +0100
Message-ID: <20111207082924.2f88bd5d@endymion.delvare>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3C06C26914DACA4BB3A368F78CA0B3A71345F2-TcFNo7jSaXM0vywKSws3iq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tang Yuantian-B29983 <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sun york-R58495 <R58495-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Durai Kumar-R34055 <r34055-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Huang Changming-R66093 <r66093-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Yuantian,

Please don't top-post.

On Wed, 7 Dec 2011 05:25:49 +0000, Tang Yuantian-B29983 wrote:
> Hi Guenter,
> 
> I thought you were bore of discussion.
> Do you mind if I post similar patch?

I have no objection, as long as you give proper credit to the original
author.

Note that ultimately you'll have to get Ben Dooks to apply the patch. I
helped with the review but the i2c-mpc driver doesn't actually fall in
my jurisdiction.

-- 
Jean Delvare
