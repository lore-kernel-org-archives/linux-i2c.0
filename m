From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] ARM: Tegra: i2c driver
Date: Tue, 21 Jun 2011 12:24:05 -0600
Message-ID: <BANLkTinUkAL_JwOhSSx5o9QYVH9G_B=5sw@mail.gmail.com>
References: <20110621002318.8086.48367.stgit@riker> <74CDBE0F657A3D45AFBB94109FB122FF049D2EB8AD@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049D2EB8AD-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ken Radtke <kradtke-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org" <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 21, 2011 at 11:27 AM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> John Bonesio wrote at Monday, June 20, 2011 6:23 PM:
>> This patch modifies the tegra i2c driver so that it can be initiailized
>> using the device tree along with the devices connected to the i2c bus.
>
> The patch title "ARM: Tegra: i2c driver" doesn't really describe what the
> patch does and has the wrong tag; It sounds like adding a new driver.
> Perhaps "i2c: Tegra: Add DeviceTree support"?

Yes, sounds appropriate to me.

g.

>
> The code looks fine.
>
> --
> nvpublic
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
