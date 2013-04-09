From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [3/7] i2c-designware-pci: use managed functions pcim_* and devm_*
Date: Tue, 9 Apr 2013 11:03:49 +0200
Message-ID: <20130409090348.GB28509@the-dreams.de>
References: <1363867800-23861-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363867800-23861-3-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> @@ -296,10 +273,11 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci-%d",
>  		adap->nr);
>  
> -	r = request_irq(pdev->irq, i2c_dw_isr, IRQF_SHARED, adap->name, dev);
> +	r = devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr, IRQF_SHARED,
> +			adap->name, dev);

IRQ question from patch 1 fits here, too.
