From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] i2c: tegra: use clk_disable_unprepare in place of clk_disable
Date: Wed, 27 Jun 2012 21:29:20 +0530
Message-ID: <4FEB2DD8.4090904@nvidia.com>
References: <1340196960-3002-1-git-send-email-ldewangan@nvidia.com> <4FE1F9A0.6080200@wwwdotorg.org> <4FE1F9D6.6090802@wwwdotorg.org> <4FE83374.6090608@nvidia.com> <4FE889D6.4030500@wwwdotorg.org> <4FE9564C.4010502@nvidia.com> <4FE9E338.6090601@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FE9E338.6090601@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "khali@linux-fr.org" <khali@linux-fr.org>, Stephen Warren <swarren@nvidia.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prashant Gaikwad <pgaikwad@nvidia.com>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 26 June 2012 09:58 PM, Stephen Warren wrote:
> On 06/26/2012 12:27 AM, Laxman Dewangan wrote:
>> On Monday 25 June 2012 09:25 PM, Stephen Warren wrote:
>>> On 06/25/2012 03:46 AM, Laxman Dewangan wrote:
>>>> Stephen,
>>>>
>>>> On Wednesday 20 June 2012 09:57 PM, Stephen Warren wrote:
>>>>> On 06/20/2012 10:26 AM, Stephen Warren wrote:
>>>>>> On 06/20/2012 06:56 AM, Laxman Dewangan wrote:
>>>>>>> Use clk_disable_unprepare() inplace of clk_disable().
>>>>>>> This was missed as part of moving clock enable/disable to
>>>>>>> prepare/unprepare for using the common clock framework.
>>>>> ...
>>>>>> I see no reason not to take the second patch in the series through the
>>>>>> I2C tree though.
>>>>> Uggh. Ignore that paragraph - the other patch was sent separately
>>>>> not as
>>>>> a series.
>>>> so are you taking care of this patch or do I need to send the patch
>>>> based on your tree in place of linux-next?
>>> Yes, this patch should be applied through the Tegra tree, since it will
>>> be a dependency of the common clock framework switchover there, which I
>>> hope to take place this kernel cycle.
>>>
>>> I did just attempt to apply this patch to the for-3.6/common-clk branch,
>>> but it doesn't apply:-( Could you please rebase and resend. Thanks.
>> Looked at your common_clk branch and the related code is not there.
>> The clk_disable() in the particular case is introduced by change
>> i2c: tegra: make all resource allocation through devm_*
>> which is not in your branch.
>>
>> Then later Prashant post the change as
>> i2c: tegra: Add clk_prepare/clk_unprepare
>> and it does not accounted for the above patch.
>>
>> So none of your local tree will have this issue.
> OK. In that case, it's best if this patch goes through the I2C tree
> since that's where the code is that it's modifying. This might not be
> optimal for runtime git bisection depending on the order Linus ends up
> merging things, but it's probably as good as we can do without
> inter-twining the I2C and Tegra trees a lot.


Then it can go Wolfram's tree along with other patch
  i2c: tegra: remove unused member variable.

as some of previous i2c patches are in his tree.
