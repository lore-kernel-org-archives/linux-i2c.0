From: Andrew Chew <AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Date: Thu, 2 Sep 2010 15:16:20 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F763816B85AD096@HQMAIL03.nvidia.com>
References: <1283463351-15816-1-git-send-email-achew@nvidia.com>
 <20100902231942.21375cc0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100902231942.21375cc0-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Alan Cox' <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > +static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, 
> store_mode, 0);
> > +static IIO_DEVICE_ATTR(magn_x_calibscale, S_IRUGO, 
> show_calibscale, NULL, 0);
> > +static IIO_DEVICE_ATTR(magn_y_calibscale, S_IRUGO, 
> show_calibscale, NULL, 1);
> > +static IIO_DEVICE_ATTR(magn_z_calibscale, S_IRUGO, 
> show_calibscale, NULL, 2);
> > +static IIO_DEV_ATTR_MAGN_X(show_raw, AK8975_REG_HXL);
> > +static IIO_DEV_ATTR_MAGN_Y(show_raw, AK8975_REG_HYL);
> > +static IIO_DEV_ATTR_MAGN_Z(show_raw, AK8975_REG_HZL);
> 
> This seems odd as an interface as it's raw when the maths to provide
> non-raw (and thus abstract and easy for user space) data is trivial
> enough to do in kernel

IIO guys want to do normalization maths above the kernel-level magnetometer IIO layer.  This interface came before me, so I'm just following current conventions.--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
