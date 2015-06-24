From: "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Wed, 24 Jun 2015 16:18:30 +0300
Message-ID: <20150624131830.GF827@lahna.fi.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
 <20150609085146.GD1478@lahna.fi.intel.com>
 <CAKi4VAJwD45VbWuCHegfkB-tbgvgza52-cgVNF4AxF8NCuYyRQ@mail.gmail.com>
 <20150610070722.GM1478@lahna.fi.intel.com>
 <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE@LocalDomain>
 <OFB47A681B.5488F019-ONC1257E6D.005A6CD2-C1257E6D.005BD52F@alitech.com>
 <CAKi4VA+t3d-XoqDiL9ez+9qDR_ndgGnAOhkpZsJyJ2tMjfCYLA@mail.gmail.com>
 <OFB918064C.F72245F4-ONC1257E6E.00287EC7-C1257E6E.00299EF2@alitech.com>
 <20150624112723.GE827@lahna.fi.intel.com>
 <1435150578.1075.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435150578.1075.5.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "De Marchi, Lucas" <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org" <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, "lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Mello, Fabio" <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 24, 2015 at 12:56:19PM +0000, De Marchi, Lucas wrote:
> Yeah, but it would be bad to ignore the problem as well. The way it is now
> kills any possibility of using DW controller for reading sensors like
> gyroscope, accelerometer, barometer that have higher sampling rate etc.  I'll
> try to come up with a new patch but since I can't reproduce the problem here
> it'd be good to know if there's any means for me to test.  What do you think
> that could be done? Maybe putting the controller to sleep only in case of
> errors?

Instead of disabling the adapter after each transfer, I wonder if it is
enough if we just mask all interrupts? That should also prevent the
interrupt loop Christian is seeing on his hardware.
