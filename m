From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3 v2] i2c: i801: enable irq for i801 smbus
 transactions
Date: Wed, 20 Jun 2012 09:42:27 +0200
Message-ID: <20120620094227.541223db@endymion.delvare>
References: <1325847502-17841-1-git-send-email-djkurtz@chromium.org>
	<1325847502-17841-3-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325847502-17841-3-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

One more note on this...

On Fri,  6 Jan 2012 18:58:21 +0800, Daniel Kurtz wrote:
> Add a new 'feature' to i2c-i801 to enable using i801 interrupts.
> When the feature is enabled, then an isr is installed for the device's
> pci irq.

What if bit 1 of host configuration register (SMB_SMI_EN) is set? My
understanding is that our ISR will never be called in that case, so we
should stick to polled mode? We do check it already but it's only
informative at the moment:

	if (temp & SMBHSTCFG_SMB_SMI_EN)
		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
	else
		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");

-- 
Jean Delvare
