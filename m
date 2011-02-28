From: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND v2] i2c-eg20t: support new device OKI
 SEMICONDUCTOR ML7213 IOH
Date: Mon, 28 Feb 2011 14:52:25 +0300
Message-ID: <20110228115225.GB9075@bicker>
References: <1298876072-15452-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298876072-15452-1-git-send-email-tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 28, 2011 at 03:54:32PM +0900, Tomoya MORINAGA wrote:
> -	ret = i2c_add_adapter(&(adap_info->pch_data.pch_adapter));
> +		pch_adap->dev.parent = &pdev->dev;
>  
> -	if (ret) {
> -		pch_pci_err(pdev, "i2c_add_adapter FAILED\n");
> -		goto err_i2c_add_adapter;
> -	}
> +		ret = i2c_add_adapter(pch_adap);
> +		if (ret) {
> +			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
> +			goto err_i2c_add_adapter;

I think goto err_request_irq was intended here.  On a side note, it's
always better to name goto destinations after the destination instead
of the starting point.  In this case, we have two gotos to one
destination and the label err_request_irq makes no sense.

regards,
dan carpenter
