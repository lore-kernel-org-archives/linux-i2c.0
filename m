From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] [I2C] i2c-viapro: Add new PCI device ID For VX855
Date: Sun, 17 May 2009 16:03:57 +0200
Message-ID: <20090517160357.49fb0be4@hyperion.delvare>
References: <20090517060439.GE4909@prithivi.gnumonks.org>
	<20090517101952.533373c1@hyperion.delvare>
	<20090517125940.GA19746@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090517125940.GA19746-jI4mzJ+yNOMOwssVsN95jSCwEArCW2h5@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 17 May 2009 20:59:40 +0800, Harald Welte wrote:
> On Sun, May 17, 2009 at 10:19:52AM +0200, Jean Delvare wrote:
> 
> > Thanks for your contribution. You did not include
> > PCI_DEVICE_ID_VIA_VX855 to the list of devices which support I2C block
> > transactions (in function vt596_probe), is this on purpose or an
> > overlook?
> 
> it was an overlook on my side, sorry.  Can you just add that yourself or
> do you wnat me to send another patch?

I'll add it myself, no problem.

-- 
Jean Delvare
