From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c: convert i2c-isch to platform_device
Date: Tue, 23 Feb 2010 09:24:31 +0100
Message-ID: <20100223092431.0fd05b5c@hyperion.delvare>
References: <4B73DAEE.5080400@compulab.co.il>
	<4B73DBB2.7020601@compulab.co.il>
	<4B7C0E5D.3070909@compulab.co.il>
	<4B812B42.2090405@compulab.co.il>
	<4B837D0C.3000708@compulab.co.il>
	<20100223091221.086ff17b@hyperion.delvare>
	<20100223082054.GA3550@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100223082054.GA3550-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Samuel,

On Tue, 23 Feb 2010 09:20:55 +0100, Samuel Ortiz wrote:
> Hi Jean,
> 
> On Tue, Feb 23, 2010 at 09:12:21AM +0100, Jean Delvare wrote:
> > I can add my
> > 
> > Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > 
> > but the patch itself would rather go through Samuel's mfd tree. The
> > different patches depend on each other so pushing them through
> > different trees would cause trouble.
> Exactly. I asked Denis to rebase them against Linus' latest because I was
> planning to merge them through my tree.
> I'll take patches 2 and 3 from this patchset.

You mean patches 1 and 2?

-- 
Jean Delvare
