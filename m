From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5] staging: iio: light: Adding driver for ISL29018 ALS
Date: Thu, 7 Oct 2010 14:41:37 -0700
Message-ID: <20101007214137.GA9269@kroah.com>
References: <1286480883-25589-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1286480883-25589-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 07, 2010 at 12:48:03PM -0700, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> adding support for the ISL 29018 ambient light and proximity sensor.
>=20
> Addressed comments from reviews by Jonathan Cameron and Joe Perches
>   * Removed some excess dbg prints that only printed function name
>   * Renamed some properties to make them more descriptive
>   * Added a property to list available adc resolutions
>   * Defined arrays for resolutions/ranges as static const
>   * Change loops initialization to memset for extensibility.
>     * used sizeof() instead of ARRAY_SIZE() to be safer
>   * Added a property to list available adc ranges
>=20
> Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

Too bad no one actually compiled this driver:
  CC [M]  drivers/staging/iio/light/isl29018.o
drivers/staging/iio/light/isl29018.c:420:8: error: =E2=80=98show_prox_i=
nfrared_suppression=E2=80=99 undeclared here (not in a function)
drivers/staging/iio/light/isl29018.c:433:1: error: =E2=80=98iio_dev_att=
r_range_available=E2=80=99 undeclared here (not in a function)
drivers/staging/iio/light/isl29018.c:435:1: error: =E2=80=98iio_dev_att=
r_adc_resolution_available=E2=80=99 undeclared here (not in a function)
drivers/staging/iio/light/isl29018.c: In function =E2=80=98isl29018_chi=
p_init=E2=80=99:
drivers/staging/iio/light/isl29018.c:451:6: warning: unused variable =E2=
=80=98i=E2=80=99
drivers/staging/iio/light/isl29018.c: At top level:
drivers/staging/iio/light/isl29018.c:350:16: warning: =E2=80=98show_pro=
x_infrared_supression=E2=80=99 defined but not used
drivers/staging/iio/light/isl29018.c:416:1: warning: =E2=80=98iio_const=
_attr_range_available=E2=80=99 defined but not used
drivers/staging/iio/light/isl29018.c:417:1: warning: =E2=80=98iio_const=
_attr_adc_resolution_available=E2=80=99 defined but not used
make[2]: *** [drivers/staging/iio/light/isl29018.o] Error 1
make[1]: *** [drivers/staging/iio/light] Error 2
make: *** [_module_drivers/staging/iio] Error 2

Please fix this up before resending it.

thanks,

greg k-h
