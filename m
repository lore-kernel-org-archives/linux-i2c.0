From: Tang Yuantian-B29983 <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Wed, 7 Dec 2011 02:52:36 +0000
Message-ID: <3C06C26914DACA4BB3A368F78CA0B3A7134583@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1321338462-6138-1-git-send-email-guenter.roeck@ericsson.com>
	<CAOZdJXUPO5PyMkAw-2EPvy_qSUuqsgUA7Gr8mKUX7HyShoXk3g@mail.gmail.com>
	<E6AF40B3BFC8A9428EACB47497F0F4B62DC687@039-SN1MPN1-002.039d.mgd.msft.net>
	<ECEE0D23-8F53-402C-A97F-4DB0F0E9C79B@freescale.com>
	<1321464509.7847.41.camel@oslab-l1>
	<1321464968.2309.384.camel@groeck-laptop>
	<1321466135.7847.55.camel@oslab-l1>
	<20111116190954.67c846fc@endymion.delvare>
	<1321467638.7847.73.camel@oslab-l1>
	<20111116201048.4b7877dd@endymion.delvare>
	<1321470915.7847.122.camel@oslab-l1>
 <20111116201847.6b11dc7f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111116201847.6b11dc7f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org" <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sun york-R58495 <R58495-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Durai Kumar-R34055 <r34055-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Huang Changming-R66093 <r66093-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean Delvare,

We agree to apply this patch. Do you have any concerns?
Although Guenter said that he give up, I don't think he really meant it.
Also it is improper if I repost similar patch.
I tested this patch, it works.

Regards,
Yuantian

> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> Sent: 2011年11月17日 3:19
> To: sun york-R58495
> Cc: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org; Tabi Timur-B04825; linux-
> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tang Yuantian-B29983
> Subject: Re: [PATCH] i2c/busses: (mpc) Add support for
> SMBUS_READ_BLOCK_DATA
> Really, please. I understand you're only trying to help and understand
> the patch, but at some point, if you have zero knowledge about the topic,
> you're not the right person to review the patch, period. You are still
> welcome to test the patch if you can and want, that's a completely
> different task.
> 
> --
> Jean Delvare
