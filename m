From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] [trivial] dt-bindings: i2c: i2c-mux: Spelling s/required
 is/required if/
Date: Mon, 25 Sep 2017 17:36:17 +0200
Message-ID: <fbda62c7-3947-fb5c-b4e9-d727a4f324a5@axentia.se>
References: <1505998349-10091-1-git-send-email-geert+renesas@glider.be>
 <2e6b5d12-f3aa-7228-9335-e3910e790109@axentia.se>
 <CAMuHMdWMh5jnfeqxoczdq7SnEj7Sa-egcxgwCi-0y4bmQv6meg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:19781
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934109AbdIYPg1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 25 Sep 2017 11:36:27 -0400
In-Reply-To: <CAMuHMdWMh5jnfeqxoczdq7SnEj7Sa-egcxgwCi-0y4bmQv6meg@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Kosina <trivial@kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2017-09-25 17:24, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Mon, Sep 25, 2017 at 5:13 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2017-09-21 14:52, Geert Uytterhoeven wrote:
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Yes, this is trivial, both the patch and my complaint, but can you please
>> add a "body of explanation" as suggested by submitting-patches in its topic
>> "The canonical patch format"?
> 
> A patch should provide the answer to 3 questions: what?, why?, and how?,
> and IMHO all of these have been answered.
> What more can I say, besides duplicating the one-line summary?
> 
>> Maintainers accepting empty patch descriptions are publicly shamed, and
>> I do not wish to be in that boat, sorry...
> 
> Are they? AFAIK only if they apply patches that need more explanation.

There was an LWN article a while back that counted the number of patches
with an empty body and presented a table with top "offenders".

But ok, I'll just fix it up myself as I apply it. Hopefully w/o adding any
further speeling mitsaeks..,.

Cheers,
Peter
