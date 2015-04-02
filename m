From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: Handling Slave monitor mode
Date: Fri, 3 Apr 2015 01:39:52 +0530
Message-ID: <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
	<20150327153713.GC27238@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150327153713.GC27238@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, Mar 27, 2015 at 9:07 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Tue, Mar 17, 2015 at 09:48:15PM +0530, Nava kishore Manne wrote:
>> In slave monitor mode, the I2C interface is set up as a master and
>> continues to attempt a transfer to a particular slave until the
>> slave device responds with an ACK.
>>
>> Added this feature for zero length transfers enable the controller
>> for slave monitor interrupt and get the status. Disable the slave
>> monitor mode feature upon successful handling.
>>
>> Signed-off-by: Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> Acked-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>
> I am not sure this is going to work.
>
> How often is this access tried when there is no device? It should be
> tried only once.

Once slave monitor is enabled in the host controller, it retries till there's an
ACK or slave monitor is disabled. The SW wont be involved and need not
be interrupted in this gap. The way this feature works in the controller though,
I'm afraid there's no way to distinguish between no slave/ busy slave.
The out is the software timeout in that case.
Please suggest how to use this feature better.

>
> Those 0byte messages can be read or write, so transferring one bit, one
> could say. I assume this one can only read? (which is not a show-stopper
> but the cases should be handled)
>

Yes, only read is used.

Thanks for the review.

Regards,
Harini
