From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
Date: Thu, 14 May 2015 14:19:00 +0300
Message-ID: <555484A4.9090109@linaro.org>
References: <55534BA0.3000506@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55534BA0.3000506-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Lawnick Michael 61283229 <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 05/13/2015 04:03 PM, Alexander Sverdlin wrote:
> There are several problems in the function:
> - "to_cnt" variable does nothing
> - schedule_timeout() call without setting current state does nothing
> - "allow_sleep" parameter is not really used
>
> Refactor the function so that it really tries to wait. In case of timeout try
> to recover the bus.

Reviewed-by: Grygorii Strashko <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
> Changes in v2:
> - rebased on 110bc76729d4 of Linus's tree;
>
>   drivers/i2c/busses/i2c-davinci.c |   42 +++++++++++++++++--------------------
>   1 files changed, 19 insertions(+), 23 deletions(-)


-- 
regards,
-grygorii
