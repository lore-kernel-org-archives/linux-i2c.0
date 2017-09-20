From: "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v6 0/3] enable eeprom "size" property and runtime pm
Date: Wed, 20 Sep 2017 03:51:36 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A5972FC1250@FMSMSX114.amr.corp.intel.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <20170905134821.vyrita5fssc5uxxh@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170905134821.vyrita5fssc5uxxh-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adding Tomasz...

> -----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus-X3B1VOXEql0@public.gmane.org]
> Sent: Tuesday, September 05, 2017 6:48 AM
> To: Mohandass, Divagar <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: Re: [PATCH v6 0/3] enable eeprom "size" property and runtime pm
> 
> Hi Divagar,
> 
> On Mon, Sep 04, 2017 at 03:58:45PM +0530, Divagar Mohandass wrote:
> > This series adds support for eeprom "size" property which will be read
> > by the driver for eeprom size. The existing ACPI has a different
> > default size which can be overridden with a DSD property value provided by
> the platform FW.
> >
> > This series also adds support for runtime PM. The eeprom driver
> > currently did not have support for runtime PM and the device was kept in D0
> throughout.
> >
> > [v1]
> > - Add support for eeprom "size" property.
> > - Add runtime PM support to the driver.
> >
> > [v2]
> > - Improved the patch subject.
> >
> > [v3]
> > - Addressed comments from Sakari Ailus.
> > - Improved patch description.
> > - Improved pm support patch.
> >
> > [v4]
> > - Improved runtime pm support.
> > - Addressed comments from Sakari Ailus.
> >
> > [v5]
> > - Addressed comments from Sakari Ailus.
> > - Improved error handling for PM support.
> >
> > [v6]
> > - Addressed comments from Sakari Ailus.
> >
> > Divagar Mohandass (3):
> >   dt-bindings: add eeprom "size" property
> >   eeprom: at24: add support to fetch eeprom device property "size"
> >   eeprom: at24: enable runtime pm support
> >
> >  .../devicetree/bindings/eeprom/eeprom.txt          |  2 ++
> >  drivers/misc/eeprom/at24.c                         | 42 ++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> 
> Thanks for the update!
> 
> For the set:
> 
> Reviewed-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> --
> Kind regards,
> 
> Sakari Ailus
> e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
