From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: mv64xxx: Remove redundant of_match_ptr
Date: Wed, 2 Oct 2013 22:21:55 +0530
Message-ID: <CAK9yfHzP2e0QehmTisZ+qdr3zfcfDrLAGizqcUmc19gcLhEnwA@mail.gmail.com>
References: <1380542526-2943-1-git-send-email-sachin.kamat@linaro.org>
	<20131001222049.GC5028@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131001222049.GC5028@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2 October 2013 03:50, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Sep 30, 2013 at 05:32:06PM +0530, Sachin Kamat wrote:
>> The data structure of_match_ptr() protects is always compiled in.
>> Hence of_match_ptr() is not needed.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Applied to for-next, thanks!

Thanks.

> I hope you checked if you missed other
> occurences, too. My pointing to mv64xxx was an example, not a complete
> list.

I checked all the files in the sub-system manually now and found one
other similar instance. Have sent out a patch for it.

-- 
With warm regards,
Sachin
