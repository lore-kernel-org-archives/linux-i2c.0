From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 1/1] i2c-i801: SMBus patch for Intel Ibex Peak
	DeviceIDs
Date: Thu, 21 Aug 2008 09:05:29 +0200
Message-ID: <20080821090529.4ce209c7@hyperion.delvare>
References: <200808202345.m7KNjRBv005585@imap1.linux-foundation.org>
	<20080821084446.6cdb11d3@hyperion.delvare>
	<20080820235541.da8f690c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080820235541.da8f690c.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 20 Aug 2008 23:55:41 -0700, Andrew Morton wrote:
> On Thu, 21 Aug 2008 08:44:46 +0200 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> 
> > Hi Andrew,
> > 
> > On Wed, 20 Aug 2008 16:45:26 -0700, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> > > From: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > 
> > > Add the Intel Ibex Peak (PCH) SMBus Controller DeviceIDs.
> > > 
> > > Signed-off-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> > > ---
> > > 
> > >  drivers/i2c/busses/Kconfig    |    1 +
> > >  drivers/i2c/busses/i2c-i801.c |    3 +++
> > >  2 files changed, 4 insertions(+)
> > 
> > I have this patch in my tree already, but I can't export it, because it
> > depends on a pci_ids.h patch which is not yet in Linus' tree.
> 
> Sigh.
> 
> > > 
> > > diff -puN drivers/i2c/busses/Kconfig~i2c-i801-smbus-patch-for-intel-ibex-peak-deviceids drivers/i2c/busses/Kconfig
> > > --- a/drivers/i2c/busses/Kconfig~i2c-i801-smbus-patch-for-intel-ibex-peak-deviceids
> > > +++ a/drivers/i2c/busses/Kconfig
> > > @@ -97,6 +97,7 @@ config I2C_I801
> > >  	    ICH9
> > >  	    Tolapai
> > >  	    ICH10
> > > +	    PCH
> > >  
> > >  	  This driver can also be built as a module.  If so, the module
> > >  	  will be called i2c-i801.
> > > diff -puN drivers/i2c/busses/i2c-i801.c~i2c-i801-smbus-patch-for-intel-ibex-peak-deviceids drivers/i2c/busses/i2c-i801.c
> > > --- a/drivers/i2c/busses/i2c-i801.c~i2c-i801-smbus-patch-for-intel-ibex-peak-deviceids
> > > +++ a/drivers/i2c/busses/i2c-i801.c
> > > @@ -41,6 +41,7 @@
> > >    Tolapai               0x5032     32     hard     yes     yes     yes
> > >    ICH10                 0x3a30     32     hard     yes     yes     yes
> > >    ICH10                 0x3a60     32     hard     yes     yes     yes
> > > +  PCH                   0x3b30     32     hard     yes     yes     yes
> > >  
> > >    Features supported by this driver:
> > >    Software PEC                     no
> > > @@ -576,6 +577,7 @@ static struct pci_device_id i801_ids[] =
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TOLAPAI_1) },
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_4) },
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
> > > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_2) },
> > >  	{ 0, }
> > >  };
> > >  
> > > @@ -599,6 +601,7 @@ static int __devinit i801_probe(struct p
> > >  	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
> > >  	case PCI_DEVICE_ID_INTEL_ICH10_4:
> > >  	case PCI_DEVICE_ID_INTEL_ICH10_5:
> > > +	case PCI_DEVICE_ID_INTEL_PCH_2:
> > >  		i801_features |= FEATURE_I2C_BLOCK_READ;
> > >  		/* fall through */
> > >  	case PCI_DEVICE_ID_INTEL_82801DB_3:
> > > _
> 
> Are you sure?  PCI_DEVICE_ID_INTEL_PCH_2 is there in 2.6.27-rc4.

Ah, must have happened overnight, it wasn't there yesterday. I'll
resync my tree now.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
