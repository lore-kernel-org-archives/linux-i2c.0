From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: Re: [TEST PATCH] rtc: convert ds1307 to interim probe_new
Date: Mon, 11 Jul 2016 10:13:25 +0100
Message-ID: <57836335.1050702@bingham.xyz>
References: <20160610133200.GB1624@katana>
 <1465766027-485-1-git-send-email-kieran@bingham.xyz>
 <20160613171324.GA2238@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160613171324.GA2238@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 13/06/16 18:13, Wolfram Sang wrote:
> 
>> As we match on only the device, not the manufacturer, I've changed your sketch
>> so that the test maxim line is on a compatible with name ds9999 to make it
>> unique. Otherwise, we would match to the dallas,ds1307 id type.
> 
> OK, so I assumed correctly that userspace instantiation wouldn't have
> worked fully.
> 
>> If you would prefer that we support separate manufacturers, I can update the
>> match function so that it attempts a full match first, followed by a stripped
>> manufacturer match. I'm not certain if we have a need for that at the moment
>> though, as the current drivers simply match on the device name:
> 
> I think we *need* that. We can't instantiate my previous example via
> userspace otherwise. Also, stripping vendor names is what we want to get
> rid of with this series, no?

Awww <multiple expletives removed>

I just re-read this - Has this series been blocked on me without me
realising?

/me cowers in a corner in shame...

I think the aim of this series was to simplify the code structures.

Making the vendor names usable, makes sense IMO, but I don't think that
was a goal of the original series.

I think the series was trying to make an improvement *without* changing
functionality / usage.

Re-introducing vendor names into the i2c matching would be a change in
scope from my view, but if it's required to get this series moving let
me know.

>> This patch also demonstrates a method to obtain the device ID from the new
>> match system for drivers which would normally have expected this information to
>> be passed in.
> 
> Thanks for the testing!
> 
>    Wolfram
> 

-- 
Regards

Kieran Bingham
