From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v1 02/10] i2c: core: Have clients point to their firmware nodes
Date: Thu, 6 Aug 2015 16:17:28 +0200
Message-ID: <CAAObsKD557c5ssAYUqa=azCs05=o5CA++-sFOBx=063Zwev2dQ@mail.gmail.com>
References: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435676108-20590-3-git-send-email-tomeu.vizoso@collabora.com> <20150731103624.GB1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150731103624.GB1522@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 31 July 2015 at 12:36, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Tue, Jun 30, 2015 at 04:55:00PM +0200, Tomeu Vizoso wrote:
>> This is needed by platform-independent code that needs to do something
>> with devices based on the data provided by the firmware.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>
> Dunno the status of this series, but the i2c change is trivial enough.
> So in case, the rest is accepted:
>
> Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Currently my series is moving away from fwnode because the current
approach is very much dependent on the firmware, but I think this fix
is worth in its own because someone else will find this problem sooner
or later.

Regards,

Tomeu
