From: "Tomoya MORINAGA" <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: RE: [PATCH v3] i2c-eg20t: support new device OKI SEMICONDUCTOR ML7213 IOH
Date: Wed, 2 Mar 2011 12:18:35 +0900
Message-ID: <9B1A3736CA9445A9A96F14E0B8ED18B1@hacdom.okisemi.com>
References: <1298956583-3734-1-git-send-email-tomoya-linux@dsn.okisemi.com> <4D6D91B7.5070209@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D6D91B7.5070209-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Ben Dooks' <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: 'Jean Delvare' <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Seth Heasley' <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Linus Walleij' <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, 'Samuel Ortiz' <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Wednesday, March 02, 2011 9:39 AM, Ben Dooks wrote:
> Ok, will apply to i2c-next.
Thank you for your applying.

> > +/* Definition for ML7213 by OKI SEMICONDUCTOR */
> > +#define PCI_VENDOR_ID_ROHM		0x10DB
> > +#define PCI_DEVICE_ID_ML7213_I2C	0x802D
> 
> we should get this moved to a pci header file at somepoint.
Do you mean include/linux/pci_ids ?


> > +		strcpy(pch_adap->name, KBUILD_MODNAME);
> 
> really should be strlcpy() and ensure that the string length is used.
OK.
We will update in next update.


> > -	pch_i2c_init(&adap_info->pch_data);
> > +		pch_i2c_init(&adap_info->pch_data[i]);
> > +	}
> >   	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
> > -		  KBUILD_MODNAME,&adap_info->pch_data);
> > +		  KBUILD_MODNAME, adap_info);
> 
> how about using dev_name() of the platform device to register 
> these things?
Sorry, I can't understand your saying.
Could you explain in more detail ? 

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.
