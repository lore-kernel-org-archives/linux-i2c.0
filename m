From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on the same bus
Date: Fri, 31 Oct 2014 14:17:58 -0700
Message-ID: <5453FC86.1080408@roeck-us.net>
References: <CAB0SmAFZ5KPpeSbQia9kq668G5kE6hpw9eBRy=59U6GOymkj9A@mail.gmail.com> <20141031210301.GA4169@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141031210301.GA4169@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 10/31/2014 02:03 PM, Wolfram Sang wrote:
> Hi,
>
> On Mon, Oct 27, 2014 at 11:46:01AM -0700, Martin Belanger wrote:
>> This is regarding a series of emails between Guenter Roeck and Jean
>> Delvare titled "Problem with multiple i2c multiplexers on one bus, and
>> mux bus naming" sent in November 2013. Ref:
>> http://thread.gmane.org/gmane.linux.drivers.i2c/16980
>
> Please CC those people then, too. That helps getting their attention.
> I've done this now.
>
>> I'm having the same problem with multiple PCA954x multiplexers on the
>> same bus and there is no way to tell them apart just by looking at the
>> "name" file.
>>
>> There was a suggestion to change the name from "i2c-N-mux (chan_id M)"
>> to "i2c-N-mux-XX (chan_id M)" or even "i2c-N-mux-i2c-XX (chan_id M)",
>> where XX is the multiplexer's i2c address. That would solve my
>> problem, but unfortunately it looks like Guenter never submitted the
>> patch (or maybe it was rejected?).
>
> It just dropped off :( But you guys have my attention now, let's fix
> this issue for 3.19! I am just reading through the old mails and will
> think about it. Input is welcome.
>
I didn't follow up on the issue since it was not an immediate concern,
and my proposed solution had some problems. If I remember correctly,
one of the problems was that the multiplexer does not have to be an
i2c chip. In that case XX would be unknown and/or have to be omitted.

Guenter

>> I would like to submit a similar change, but I was thinking of adding
>> a module parameter so that the change is not the default behavior.
>> The idea is to preserve backward compatibility for applications that
>> don't require this fix. For example, modprobe i2c-dev
>> explicit_mux_id=1 would use i2c-N-mux-i2c-XX (chan_id M), whereas
>> modprobe i2c-dev would default to the current behavior: i.e. i2c-N-mux
>> (chan_id M).
>
> I don't like the need to set a module parameter to fix a flaw. I do
> consider changing the ABI to have better strings in "name". But as said,
> I need to think about it a little more...
>
> Thanks,
>
>     Wolfram
>
