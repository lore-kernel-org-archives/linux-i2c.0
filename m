From: Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v4 00/18] i2c mux cleanup and locking update
Date: Tue, 15 Mar 2016 19:08:08 +0200
Message-ID: <56E84178.2020204@iki.fi>
References: <1457044050-15230-1-git-send-email-peda@lysator.liu.se>
 <56E817AE.2090005@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56E817AE.2090005-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Viorel Suman <viorel.suman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Terry Heo <terryheo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tommi Rantala <tt.rantala-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/15/2016 04:09 PM, Peter Rosin wrote:

> The series will be posted again for review. This is just a heads up.
>
> v5 compared to v4:
> - Rebase on top of v4.5-rc7.
> - A new patch making me maintainer of i2c muxes (also sent separately).
> - A new file Documentation/i2c/i2c-topology that describes various muxing
>    issues.
> - Rename "i2c-controlled" muxes "self-locked" instead, as it is perfectly
>    reasonable to have i2c-controlled muxes that use the pre-existing locking
>    scheme. The pre-existing locking scheme for i2c muxes is from here on
>    called "parent-locked".
> - Rename i2c-mux.c:i2c_mux_master_xfer to __i2c_mux_master_xfer since it
>    calls __i2c_transfer, which leaves room for a new i2c_mux_master_xfer
>    that calls i2c_transfer. Similar rename shuffle for i2c_mux_smbus_xfer.
> - Use sizeof(*priv) instead of sizeof(struct i2c_mux_priv). One instance.
> - Some follow-up patches that were posted in response to v2-v4 cleaning up
>    and simplifying various i2c muxes outside drivers/i2c/, among those is
>    an unrelated cleanup patch to drivers/media/dvb-frontends/rtl2832.c that
>    I carry here since it conflicts (trivially) with this series. That
>    unrelated patch is (currently) the last patch in the series.
>
>
> The series looks like this now:
>
> The following changes since commit f6cede5b49e822ebc41a099fe41ab4989f64e2cb:
>
>    Linux 4.5-rc7 (2016-03-06 14:48:03 -0800)
>
> are available in the git repository at:
>
>    https://github.com/peda-r/i2c-mux.git mux-core-and-locking-5

I reviewed and tested these patches:

c1ef4a2 [media] rtl2832: regmap is aware of lockdep, drop local locking hack
6636178 [media] rtl2832_sdr: get rid of empty regmap wrappers
001ad6b [media] rtl2832: declare that the i2c gate is self-locked
e2e82e4 [media] si2168: declare that the i2c gate is self-locked
b52f766 [media] si2168: convert to use an explicit i2c mux core
4ba9115 [media] rtl2832: convert to use an explicit i2c mux core
3f1778b [media] rtl2830: convert to use an explicit i2c mux core
5c8bfc8 [media] m88ds3103: convert to use an explicit i2c mux core


Reviewed-by: Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>
Tested-by: Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>

regards
Antti

-- 
http://palosaari.fi/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
