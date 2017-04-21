From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
Date: Sat, 22 Apr 2017 01:28:28 +0200
Message-ID: <c41cf9f6-ca9a-a29a-f6a3-c2b1a1d09a60@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <20170418085156.GA4773@kroah.com>
 <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
 <20170418114430.GA1496@kroah.com>
 <aacdc359-e46d-7d1a-d959-63d4ecb99fde@axentia.se>
 <0f605429-afa2-2818-96d5-5da0bad122d6@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <0f605429-afa2-2818-96d5-5da0bad122d6@axentia.se>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

On 2017-04-20 23:53, Peter Rosin wrote:
> On 2017-04-18 23:53, Peter Rosin wrote:
>> On 2017-04-18 13:44, Greg Kroah-Hartman wrote:
>>> On Tue, Apr 18, 2017 at 12:59:50PM +0200, Peter Rosin wrote:
>>>> On 2017-04-18 10:51, Greg Kroah-Hartman wrote:
>>>>> On Thu, Apr 13, 2017 at 06:43:07PM +0200, Peter Rosin wrote:
> 
> *snip*
> 
>>>>>> +	if (mux->idle_state != MUX_IDLE_AS_IS &&
>>>>>> +	    mux->idle_state != mux->cached_state)
>>>>>> +		ret = mux_control_set(mux, mux->idle_state);
>>>>>> +
>>>>>> +	up_read(&mux->lock);
>>>>>
>>>>> You require a lock to be held for a "global" function?  Without
>>>>> documentation?  Or even a sparse marking?  That's asking for trouble...
>>>>
>>>> Documentation I can handle, but where should I look to understand how I
>>>> should add sparse markings?
>>>
>>> Run sparse on the code and see what it says :)
>>
>> Will do.
> 
> I just did, and even went through the trouble of getting the bleeding
> edge sparse from the git repo when sparse 0.5.0 came up empty, but it's
> all silence for me. So, how do I add sparse markings?

I looked some more into this, and the markings I find that seem related
are __acquire() and __release(). But neither mutex_lock() nor up_read()
has markings like that, so adding them when using those kinds of locks
in an imbalanced way seems like a sure way of *getting* sparse messages
about context imbalance...

So, either that, or you are talking about __must_check markings?

I feel like I'm missing something, please advise further.

Cheers,
peda

