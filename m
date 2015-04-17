From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 0/3] i2c: davinci improvements and fixes
Date: Fri, 17 Apr 2015 20:32:52 +0300
Message-ID: <553143C4.2060903@linaro.org>
References: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org> <20150410155940.GA2408@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150410155940.GA2408@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/10/2015 06:59 PM, Wolfram Sang wrote:
> On Mon, Apr 06, 2015 at 03:38:38PM +0300, grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Grygorii Strashko <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> This series converts driver to use I2C bus recovery infrastructure and
>> adds Davinci I2C bus recovery mechanizm based on using ICPFUNC registers.
>> These patches are combination of two patches from Ben Gardiner [1] and
>> Mike Looijmans [2] which i've reworked to use I2C bus recovery infrastructure
>
> Applied to for-next, thanks for keeping at it and providing useful info!
>

Thanks

-- 
regards,
-grygorii
