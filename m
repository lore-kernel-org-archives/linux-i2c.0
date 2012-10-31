From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Wed, 31 Oct 2012 14:28:48 +0530
Message-ID: <CAKohponHvQLCBZGj8mjSD=F0Xtxs0bwfS06skSoB1e-xtJi2MQ@mail.gmail.com>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
	<CAKohpokgrKVpGOcT=H7TvNCQyKwHfcUPetXj-_Ug1pP35nyFEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpokgrKVpGOcT=H7TvNCQyKwHfcUPetXj-_Ug1pP35nyFEg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 19 October 2012 19:03, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 4 October 2012 16:34, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
>> protocol Rev. 03 section 3.1.16 titled "Bus clear".
>>
>> http://www.nxp.com/documents/user_manual/UM10204.pdf
>>
>> Sometimes during operation i2c bus hangs and we need to give dummy clocks to
>> slave device to start the transfer again. Now we may have capability in the bus
>> controller to generate these clocks or platform may have gpio pins which can be
>> toggled to generate dummy clocks. This patch supports both.
>>
>> This patch also adds in generic bus recovery routines gpio or scl line based
>> which can be used by bus controller. In addition controller driver may provide
>> its own version of the bus recovery routine.
>>
>> This doesn't support multi-master recovery for now.
>
> Hi Wolfram,
>
> I haven't pinged you earlier as i knew merge window is around. Can you please
> share your opinion for this now?

Ping!!

--
viresh
