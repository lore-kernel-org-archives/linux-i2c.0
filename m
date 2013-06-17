From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Mon, 17 Jun 2013 09:48:21 -0600
Message-ID: <51BF2FC5.40207@wwwdotorg.org>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org> <CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 05/22/2013 01:56 AM, Linus Walleij wrote:
> On Mon, May 13, 2013 at 10:18 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
>> This tries to address an issue found when writing an MFD driver
>> for the Nomadik STw481x PMICs: as the platform is using device
>> tree exclusively I want to specify the driver matching like
>> this:
> (...)
>> ---
>> ChangeLog v1->v2:
>> - Use of_match_device() to determine if there is a DT match in
>>   the probe code. If there is a match we pass NULL for the
>>   id_table match parameter.
> 
> Ping on this.
> 
> v2 should be doing what Grant suggested...

This has just shown up in next-20130617, and breaks at least the
TPS65910 and TPS62360 drivers, since they assume that the id parameter
passed to probe is non-NULL. However, now the parameter is NULL since
these drivers have both an ID table and an OF match table.

I'd like to suggest this patch be reverted an re-introduced immediately
after the merge window. That should give enough time for everyone to get
a heads-up on fixing any drivers with a similar problem, rather than
trying to cram all that in immediately before the merge window. I'd also
suggest that this patch should be accompanied by fixes for any similarly
broken drivers, based on code inspection.

Do people agree? If not, please let us know ASAP so we can post patches
to fix this.
