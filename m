From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3 v2] i2c: i801: enable irq for i801 smbus
 transactions
Date: Wed, 20 Jun 2012 10:58:47 +0200
Message-ID: <20120620105847.65cf37f2@endymion.delvare>
References: <1325847502-17841-1-git-send-email-djkurtz@chromium.org>
	<1325847502-17841-3-git-send-email-djkurtz@chromium.org>
	<20120619204704.69454016@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120619204704.69454016-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Jun 2012 20:47:04 +0200, Jean Delvare wrote:
> On Fri,  6 Jan 2012 18:58:21 +0800, Daniel Kurtz wrote:
> > @@ -879,8 +953,24 @@ static int __devinit i801_probe(struct pci_dev *dev,
> >  	i801_probe_optional_slaves(priv);
> >  
> >  	pci_set_drvdata(dev, priv);
> > +
> > +	if (priv->features & FEATURE_IRQ) {
> > +		init_waitqueue_head(&priv->waitq);
> > +		spin_lock_init(&priv->lock);
> > +
> > +		err = request_irq(dev->irq, i801_isr, IRQF_SHARED,
> > +				  i801_driver.name, priv);
> > +		if (err) {
> > +			dev_err(&dev->dev, "Failed to allocate irq %d: %d",
> 
> Missing "\n".
> 
> > +				dev->irq, err);
> > +			goto exit_del_adapter;
> > +		}
> 
> I believe order is wrong, and interrupt handler should be installed
> _before_ registering the adapter. Otherwise you have a race condition
> where the handler could be called before the waitqueue and spinlock are
> initialized.

Oh, and it's not a theoretical thing. I can reproducibly crash the
kernel by removing and loading the i2c-i801 driver again. Swapping
request_irq() and i2c_add_adapter() solves it.

-- 
Jean Delvare
