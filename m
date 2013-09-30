From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 16:25:54 +0530
Message-ID: <CAK9yfHwPjTTsGDazk5nex3F8cOV23O0ApSRLjmV0Y7nx94xJ5Q@mail.gmail.com>
References: <1380512066-23681-1-git-send-email-sachin.kamat@linaro.org>
	<20130930105222.GD3222@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130930105222.GD3222@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 30 September 2013 16:22, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Sep 30, 2013 at 09:04:25AM +0530, Sachin Kamat wrote:
>> The data structure of_match_ptr() protects is always compiled in.
>> Hence of_match_ptr() is not needed.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Can you do this subsystem wide? At least mv64xxx is affected as well.

Sorry, I missed that. Will send a patch for that.

-- 
With warm regards,
Sachin
