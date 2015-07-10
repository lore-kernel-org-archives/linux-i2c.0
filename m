From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 6/9] i2c: xiic: Add a debug msg in case of timeout
Date: Fri, 10 Jul 2015 10:41:03 +0530
Message-ID: <CAKfKVtGRb=EEgZ1_a4qQdM1MnCzP2iOb=h58ztoFtGsy3cYrfA@mail.gmail.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
	<1434554299-23443-7-git-send-email-shubhraj@xilinx.com>
	<20150709172942.GC4744@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150709172942.GC4744@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 9, 2015 at 10:59 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Wed, Jun 17, 2015 at 08:48:16PM +0530, Shubhrajyoti Datta wrote:
>> Currently we return silently upon a timeout.
>> Adding an error message to aid debugability. Not
>>  a functional change.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>
> I am not in favour of this. In case of a stalled bus, this can easily
> flood the logs. If it is for debugging, it should also be dev_dbg. And
> then, it probably can also be added when needed. I mean the errno is
> quite descriptive, no?
>
I agree I had added it for debugging.
