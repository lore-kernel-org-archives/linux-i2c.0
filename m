From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-ali1535: enable SPARC support
Date: Thu, 5 Jan 2012 20:51:05 +0100
Message-ID: <20120105205105.6a2d03b3@endymion.delvare>
References: <4ECE2410.7040608@geomatys.fr>
	<20111227.141759.1836372889946924661.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111227.141759.1836372889946924661.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Tue, 27 Dec 2011 14:17:59 -0500 (EST), David Miller wrote:
> From: "corentin.labbe" <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
> Date: Thu, 24 Nov 2011 12:01:36 +0100
> 
> > The i2c-ali1535 driver don't work on SPARC, this is because it assumes that ioport address are 16bits wide (address stored with an unsigned short).
> > But on SPARC arch, ioports are mapped in memory and so are stored with an unsigned long.
> > 
> > This patch corrects this by using pci_resource_start for getting IOMEM base address, then reading the SMBBA of the i2c busse and using together for I/O access.
> > 
> > I like to thanks Jean DELVARE for reviewing of my patch.
> > 
> > Thanks
> > 
> > Signed-off-by: LABBE Corentin <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
> 
> Jean has asked for some more changes, please follow his suggestions and
> resubmit, thanks.

Actually I ended up doing the changes myself, and the patch is queued
for 3.3 already:
http://khali.linux-fr.org/devel/linux-3/jdelvare-i2c/i2c-ali1535-enable-sparc-support.patch

Please let me know quickly if you see anything wrong there.

-- 
Jean Delvare
