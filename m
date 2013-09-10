From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: qup: Add device tree bindings information
Date: Tue, 10 Sep 2013 15:08:57 +0300
Message-ID: <1378814937.960.37.camel@iivanov-dev.int.mm-sol.com>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
	 <3A0F4153-1C55-4008-8EB1-D6FA60D87CEA@codeaurora.org>
	 <1377797186.30358.14.camel@localhost>
	 <767E9FBB-2975-4795-9C7E-69E302511FF2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <767E9FBB-2975-4795-9C7E-69E302511FF2-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi Kumar,

On Fri, 2013-08-30 at 10:21 -0500, Kumar Gala wrote: 
> On Aug 29, 2013, at 12:26 PM, Ivan T. Ivanov wrote:

<snip>

> >>> +
> >>> +Optional properties :
> >>> + - Child nodes conforming to i2c bus binding
> >>> + - clock-frequency : Desired I2C bus clock frequency in Hz. If
> >>> +		not set thedefault frequency is 100kHz
> >>> + - qcom,src-freq : Frequency of the source clocking this bus in Hz.
> >>> +		Divider value is set based on soruce-frequency and
> >>> +		desired I2C bus frequency. If this value is not
> >>> +		provided, the source clock is assumed to be running
> >>> +		at 19.2 MHz.
> >> 
> >> I'd spell out frequency instead of 'freq' to be consistent with 'clock-frequency'
> > 
> > ok.
> > 
> >> 
> >> Is the frequency of the 'iface' clock?  Can we not use clk_get_rate?
> > 
> > It is for 'core' clock. I think that for higher I2C bus frequencies,
> > 'core' clock have to be higher, but I am not sure what is relation.
> 
> Ok, can we use clk_get_rate on the 'core' clk to get its frequency instead of needing a DT prop for it?

Probably I didn't explain it well. The 'core' clock have to be
accelerated before higher bus frequencies could be achieved.  

> 
> > 
> >> 
> >>> +
> >>> +Aliases: An alias may optionally be used to bind the I2C controller
> >>> +to bus number. Aliases are of the form i2c<n> where <n> is an integer
> >>> +representing the bus number to use.
> >>> +
> >>> +Example:
> >>> +
> >>> + aliases {
> >>> +		i2c0 = &i2c_A;
> >>> +		i2c1 = &i2c_B;
> >>> +		i2c2 = &i2c_C;
> >>> + };
> >> 
> >> What is the purpose here?
> > 
> > Define on which I2C bus this controller operate. I2C client 
> > drivers usually do i2c_get_adapter(bus_number) before its
> > registration. This is for drivers before invention of
> > of_i2c_register_devices(), I believe.
> 
> Since this is for upstream why dont we use of_i2c_register_devices() and remove this stuff related to aliases.

Adapter driver already is using of_i2c_register_devices(). Also OF
helper function will/or is already part of i2c_register_adapter().
Attempt here was to make it compatible with older i2c client drivers.

Regards,
Ivan

> 
> - k
> 
