From: "Murphy, Dan" <dmurphy-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Date: Wed, 8 Sep 2010 10:34:46 -0500
Message-ID: <C9D59C82B94F474B872F2092A87F26141272E7852C@dlee07.ent.ti.com>
References: <1283470837-18210-1-git-send-email-achew@nvidia.com>
 <0680EC522D0CC943BC586913CF3768C003C2018464@dbde02.ent.ti.com>
 <643E69AA4436674C8F39DCC2C05F763816B85AD0A9@HQMAIL03.nvidia.com>
 <0680EC522D0CC943BC586913CF3768C003C2018BD4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C2018BD4-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Andrew Chew <AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio@vger>
Cc: "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Andrew
Do you know if AKM is updating their user space eCompass library to interface with IIO?

Dan

> -----Original Message-----
> From: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-iio-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Datta, Shubhrajyoti
> Sent: Wednesday, September 08, 2010 5:05 AM
> To: Andrew Chew; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; Laxman Dewangan
> Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
> 
> 
> 
> > -----Original Message-----
> > From: Andrew Chew [mailto:AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org]
> > Sent: Wednesday, September 08, 2010 4:37 AM
> > To: Datta, Shubhrajyoti; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; Laxman Dewangan
> > Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
> >
> > > > This is for the Asahi Kasei AK8975 3-axis magnetometer.  It
> > > resides within
> > > > the magnetometer section of the IIO subsystem, and
> > > implements the raw
> > > > magn_x,y,z attributes, as well as x,y,z factory calibration
> > > attributes.
> > > >
> > > Could you help me with the datasheet details.
> >
> > What do you mean by this?
> Could you share a link where the datasheet could be downloaded.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
