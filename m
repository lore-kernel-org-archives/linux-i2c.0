From: Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
Subject: Re: Fwd: [Proposal] PM sleep children of inactive I2C bus segments
 off Masters in multi-master systems
Date: Wed, 1 Oct 2014 14:16:57 -0700
Message-ID: <20141001211657.GA7904@svl-evodev-groeck.juniper.net>
References: <CAAVjN7dwS62EKMnuZc_P1UjkbRVk6RXqJ91GwWZ96bbY5Ct-rg@mail.gmail.com>
 <CAAVjN7eUmBVcAGPbcn3qsJ9M9uu2nkFoKHqGhhKGekZSceGiMw@mail.gmail.com>
 <20141001184304.GA6832@svl-evodev-groeck.juniper.net>
 <CAAVjN7edpkXYMHBm+wLegA_pc0hnm_YZf_z=Ni3h=EbDTmfegQ@mail.gmail.com>
 <20141001194115.GA6948@svl-evodev-groeck.juniper.net>
 <CAAVjN7fGRzyu7gxavJUay+K_Mm-0t1T_0Bysk6-sdaqu5=5k5A@mail.gmail.com>
 <20141001202058.GB6948@svl-evodev-groeck.juniper.net>
 <CAAVjN7e4nO579TfAJ5zMNe__Q9yU_-6naq4-0vm1rimespSrsw@mail.gmail.com>
 <20141001204302.GA7744@svl-evodev-groeck.juniper.net>
 <20141001211046.GA2368@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141001211046.GA2368@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajat Jain <rajatjain-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 01, 2014 at 11:10:47PM +0200, Wolfram Sang wrote:
> 
> > Maybe you can find an error code which with some level of confidence
> > reflects "lost mastership". Then you can implement whatever makes sense
> > for your use case in your user space application(s).
> 
> We have a documented fault code for ArbitrationLost and that is -EAGAIN
> (see Documentation/i2c/fault-codes). If a driver does use something
> else, patches are very welcome.
> 
> Other than that, I find this thread very confusing. Of course can
> another master modify the clients, this is what multi-master is all
> about, no?
> 
That is the point I was trying to make in one of my earlier replies.

Guenter
