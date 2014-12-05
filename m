From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: cadence: Handle > 252 byte transfers
Date: Fri, 5 Dec 2014 09:50:04 +0530
Message-ID: <CAFcVEC+mpfjYB2K5eci-BFfjyKXvbxOOBVX_CH=ck1xJ+V9goQ@mail.gmail.com>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
	<1417610126-7957-2-git-send-email-harinik@xilinx.com>
	<20141204183242.GJ7944@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141204183242.GJ7944@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, Dec 5, 2014 at 12:02 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> +             /*
>> +              * If the device is sending data If there is further
>> +              * data to be sent. Calculate the available space
>> +              * in FIFO and fill the FIFO with that many bytes.
>> +              */
>
> This comment looks broken. In general, I think there should be more
> comments explaining why things have to be done this way.
>

There's some grammatical errors here. Let me correct it and add more
comments.

Regards,
Harini
