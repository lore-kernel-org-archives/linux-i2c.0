From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] i2c: Remove support for legacy PM
Date: Thu, 04 Dec 2014 19:19:58 +0100
Message-ID: <5480A5CE.3010802@metafoo.de>
References: <1417366352-22356-1-git-send-email-lars@metafoo.de> <1417366352-22356-2-git-send-email-lars@metafoo.de> <20141204181111.GD7944@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141204181111.GD7944@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 12/04/2014 07:11 PM, Wolfram Sang wrote:
> On Sun, Nov 30, 2014 at 05:52:32PM +0100, Lars-Peter Clausen wrote:
>> There haven't been any I2C driver that use the legacy suspend/resume
>> callbacks for a while now and new drivers are supposed to use PM ops. So
>> remove support for legacy suspend/resume for I2C drivers.
>>
>> Since there aren't any special bus specific things to do during
>> suspend/resume and since the PM core will automatically fallback directly to
>> using the device's PM ops if no bus PM ops are specified there is no need to
>> have any I2C bus PM ops.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>
> I'll keep this for 3.20, 3.19 is too close now. But thanks, the diffstat
> looks great :) Just curious, has buildbot tested this already?
>

No, but I did allyesconfig on both ARM and x86. As well as a `grep " 
i2c_driver "  -A20 * -r | grep '\(suspend\|resume\)'` and running the 
following cocci script.

@@
identifier fn;
identifier drv;
@@
struct i2c_driver drv  = {
     ...,
*   .suspend = fn,
     ...,
};

@@
identifier fn;
identifier drv;
@@
struct i2c_driver drv = {
     ...,
*   .resume = fn,
     ...,
};

None of those methods found anything, so I'm quite confident that there are 
no users left.

- Lars
