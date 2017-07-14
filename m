From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/2] i2c: move include files out of include/linux/i2c
Date: Fri, 14 Jul 2017 07:10:02 +0200
Message-ID: <31675aa2-b8c2-a53b-f7a2-a6d700b3c596@axentia.se>
References: <20170521203743.6514-1-wsa@the-dreams.de>
 <20170713094610.noqty3z6sty6mfj5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10132.outbound.protection.outlook.com ([40.107.1.132]:31648
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750786AbdGNFKK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 14 Jul 2017 01:10:10 -0400
In-Reply-To: <20170713094610.noqty3z6sty6mfj5@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 2017-07-13 11:46, Wolfram Sang wrote:
> Hi peda,
> 
> On Sun, May 21, 2017 at 10:37:41PM +0200, Wolfram Sang wrote:
>> It doesn't make sense to use include/linux/i2c for client drivers which may in
>> fact rather be hwmon or input or whatever devices. As a result, I want to
>> deprecate include/linux/i2c for good. This series moves the include files to a
>> better location, largely include/platform_data because that is what most of the
>> moved include files contain. Note that some files don't seem to have upstream
>> users in board code, so they maybe could even be removed? I didn't check for
>> that now, but I did it for one i2c master driver recently. So, it may be
>> possible.
>>
>> And while i2c muxes might be a corner case, I still want to deprecate
>> include/linux/i2c for good ;)
>>
>> No runtime testing because of no HW, but buildbot is happy with this series at
>> least. A branch can be found here:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data
> 
> Since there were no other i2c-mux patches this merge window and thus no
> pull request, do you mind if I pick these two patches for my second pull
> request this merge window to have them included in 4.13 already?

I don't seem to have this series in my inbox and not in my i2c folder either?
(and I don't remember having seen the patches, but this was a while ago so I
could easily have forgotten everything about it)

Anyway, I had to lookup the branch to see what this was about. And in that
branch, I find b7f1e84715a1 ("i2c: pca954x: move header file out of I2C realm"),
but I initially didn't find the mlxcpld patch. That was because it had an
"x86: " prefix that I didn't react to. I first found the mlxcpld patch in
patchwork and then I found it in the branch too, but in patchwork it has the
expected "i2c: mux: " prefix so I'm not sure what you are talking about
*exactly*.

But I'm sure you'll do something sensible, just go ahead.

Cheers,
Peter

PS. Please Cc me if you want a faster reaction, I didn't notice this
yesterday.
