From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Date: Mon, 13 Jan 2014 14:13:39 +0100
Message-ID: <20140113141339.57042e48@endymion.delvare>
References: <20131217063226.GD25105@phys.ethz.ch>
	<20131217180131.GB2840@roeck-us.net>
	<20131217181053.GE7071@katana>
	<20131220134349.GV25105@phys.ethz.ch>
	<20140113130426.GG2586@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140113130426.GG2586@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 13 Jan 2014 14:04:26 +0100, Wolfram Sang wrote:
> On Fri, Dec 20, 2013 at 02:43:49PM +0100, Christian Herzog wrote:
> > Dear list,
> > 
> > thanks for your instructions. I slightly modified the driver so that it builds
> > on 3.13-rc4. I can confirm that it works well. I also talked to the company
> > (www.men.de) that released the original patch and they would love to get it
> > into the kernel. Please find attached the patch to i2c-piix4.c of 3.13-rc4.
> > I also prepared a .tgz that contains
> > - the original archive from men.de
> > - my modified driver
> > - the patch itself
> 
> Thanks for posting a patch known to work with a recent kernel. Yet, this
> is way too intrusive. We need minimal changes in logical steps to get a
> new feature supported. Ping to Jean for the details, x86 drivers are his
> expertise.

On my to-do list, but swamped by more urgent matters at the moment :(

-- 
Jean Delvare
