From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: recovery: change input parameter to i2c_adapter
 for prepare/unprepare_recovery
Date: Thu, 5 Mar 2015 20:41:31 +0200
Message-ID: <54F8A35B.5040706@ti.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com> <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com> <20141204182910.GH7944@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141204182910.GH7944@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 12/04/2014 08:29 PM, Wolfram Sang wrote:
> On Mon, Dec 01, 2014 at 05:34:05PM +0200, Grygorii Strashko wrote:
>> This patch changes type of input parameter for .prepare/unprepare_re=
covery()
>> callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter =
*.
>> This allows to simplify implementation of these callbacks and avoid
>> type conversations from i2c_bus_recovery_info to i2c_adapter.
>> The i2c_bus_recovery_info can be simply retrieved from struct i2c_ad=
apter
>> which contains pointer on it.
>>
>> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>
> Ah, bus recovery, I need to have a closer look on this one. Scheduled
> for 3.20.
>

Unfortunately, it looks like you've missed these patches :(

I'm going to resend them if you agree.

regards,
-grygorii
