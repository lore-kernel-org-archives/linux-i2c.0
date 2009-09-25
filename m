From: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Subject: Re: [rtc-linux] Re: i2c/rtc init dependency problem
Date: Fri, 25 Sep 2009 15:13:43 -0400
Message-ID: <152584230909251213l8f9663eo39151206e9ec8cd4@mail.gmail.com>
References: <152584230909240758h674ffe3cw4d5e6baef5efc9b8@mail.gmail.com>
	 <20090924151953.GD3154@pengutronix.de>
	 <8b192c78-6ebf-42ec-b334-756f56cc5400@g6g2000vbr.googlegroups.com>
	 <20090925065843.GA4125@pengutronix.de>
	 <152584230909250749w305b5202tba55bfedd742fea9@mail.gmail.com>
	 <152584230909251138r7051a279k71e10ac778e28742@mail.gmail.com>
	 <20090925204533.69681f35@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090925204533.69681f35-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexander Bigga <ab-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 25, 2009 at 2:45 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Fri, 25 Sep 2009 14:38:39 -0400, Jon Ringle wrote:
>> I think the problem is that rtc-m41t80 does not provide either of th=
e following:
>> =A0 =A0 struct i2c_driver: detect and address_data (both are null)
>> as required by i2c_detect()
>
> This should be OK. detect and address_data are optional and only need=
ed
> for drivers which autodetect their devices. The rtc-m41t80 probably
> doesn't want to do this. The device should be declared by the arch or
> platform.

Can you point me to an example of how one declares a i2c device?

Thanks,
Jon
