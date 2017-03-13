From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c-mux adapter names not unique
Date: Mon, 13 Mar 2017 22:01:33 +0100
Message-ID: <152b649c-76c0-9541-4159-43ad77b14469@axentia.se>
References: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
 <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se>
 <CAAuRgKAYgBjk=FhQfMsGdOB+-4ObUkYgWVb-Uu+0wgM+ORWOug@mail.gmail.com>
 <26e08683-2bdb-4c8e-bd6e-b4887bc26dc3@axentia.se>
 <CAAuRgKDJBoQ8v6a=nOpcVDYOeycgP+WayRhXG7YNzt0pjXphxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr50114.outbound.protection.outlook.com ([40.107.5.114]:10469
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750902AbdCMVBl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Mar 2017 17:01:41 -0400
In-Reply-To: <CAAuRgKDJBoQ8v6a=nOpcVDYOeycgP+WayRhXG7YNzt0pjXphxA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: MikeB <mabnhdev@gmail.com>
Cc: linux-i2c@vger.kernel.org

On 2017-03-13 16:05, MikeB wrote:
> On Mon, Mar 13, 2017 at 10:48 AM, Peter Rosin <peda@axentia.se> wrote:
>>
>> And why not fix the bad assumption in OpenSwitch instead and kill the
>> generic problem for every kind of adapter? Limiting yourself to a
>> band-aid for i2c-mux adapters seems short-sighted and not very helpful
>> for the next victim of this OpenSwitch problem...
>>
>> Note that you do not need two muxing levels to get duplicate names like
>> this, it's enough with two parallel multiplexers on the root adapter. Or,
>> of course, two AT91 adapters (or similar, i.e. with a fixed name).
> 
> If I thought that OpenSwitch's expectation of Linux to name unique
> adapters uniquely, I would push for a change in OpenSwitch.
> 
> I personally think Linux's naming convention is a short-sighted and
> insufficient which is why I came to Linux first.
> 
> I don't want a short-sighted band-aid which is why I asked the
> original question.
> 
> I'll try elsewhere for a solution...

That's probably best, since if we do change the adapter naming convention
to something that is unique and stable across reboots (which presumably is
what is sought, and BTW probably not a trivial problem) some other person
is going to suffer a regression when OpenSwitch fails to associate with
the intended adapter after a kernel update. I.e. the very fact that
OpenSwitch is already using this interface makes it harder to change. And
who knows, maybe there are other users that will suffer if naming is
changed?

[Note that I know nothing about OpenSwitch, I'm just deducing the above
from what you have stated previously]

I'm sorry, but there's not always a simple and convenient answer...

Cheers,
peda
