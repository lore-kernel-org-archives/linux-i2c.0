From: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Date: Mon, 13 Jan 2014 14:12:31 +0100
Message-ID: <20140113131231.GE2111@phys.ethz.ch>
References: <20131217063226.GD25105@phys.ethz.ch>
 <20131217180131.GB2840@roeck-us.net>
 <20131217181053.GE7071@katana>
 <20131220134349.GV25105@phys.ethz.ch>
 <20140113130426.GG2586@katana>
Reply-To: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140113130426.GG2586@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear all,

thanks for the feedback. I was already in contact with Jean because I noticed
the following:

I recently compiled 3.13.0-rc7 on my PC Engines apu beta box, and I2C works
out of the box, without the need for my patch. I'm still looking for somebody
who could shed some light on this situation - chances are we don't need the
patch any longer.
So: is anybody aware of any Hudson-1 related changes to the i2c-piix4 code?

thanks,
-Christian


On Mon, Jan 13, 2014 at 02:04:26PM +0100, Wolfram Sang wrote:
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
> 



-- 
Dr. Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>  support: +41 44 633 26 68
IT Services Group, HPT H 8                    voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://nic.phys.ethz.ch/
